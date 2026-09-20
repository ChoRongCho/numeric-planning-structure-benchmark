#!/usr/bin/env python3
"""Controlled delayed numeric conflict experiment.

The generated task has one valid route and a shorter, misleading resource-
infeasible route.  The experiment independently changes:

* when cumulative fuel exhaustion becomes explicit (early/deep), and
* how many infeasible prefixes remain available (low/high branching).

An exact finite-state oracle labels every reachable state.  A small reference
GBFS uses a delete/decrease relaxation, and the installed Metric-FF can be run
on the same generated PDDL tasks.
"""

from __future__ import annotations

import argparse
import csv
import heapq
import json
import math
import re
import subprocess
import time
from collections import defaultdict, deque
from dataclasses import asdict, dataclass
from datetime import datetime
from pathlib import Path
from typing import Iterable

try:
    from benchmark_core import validate_plan
    from planner_adapters import classify, extract_plan, render_plan
except ModuleNotFoundError:  # Imported as scripts.run.delayed_conflict_experiment.
    from scripts.run.benchmark_core import validate_plan
    from scripts.run.planner_adapters import classify, extract_plan, render_plan


ROOT = Path(__file__).resolve().parents[2]


@dataclass(frozen=True)
class Edge:
    name: str
    source: str
    target: str
    fuel_cost: int
    route: str
    level: int


@dataclass(frozen=True)
class Variant:
    name: str
    revelation: str
    branching_label: str
    branching: int
    depth: int
    initial_fuel: int
    good_depth: int
    consuming_levels: tuple[int, ...]

    @property
    def manifestation_depth(self) -> int:
        """First edge depth whose cumulative cost exceeds initial fuel."""
        consumed = 0
        for level in range(1, self.depth + 1):
            if level in self.consuming_levels:
                consumed += 1
            if consumed > self.initial_fuel:
                return level
        raise ValueError(f"{self.name} does not contain a cumulative conflict")


@dataclass
class Graph:
    variant: Variant
    nodes: list[str]
    edges: list[Edge]
    terminals: set[str]

    def outgoing(self) -> dict[str, list[Edge]]:
        result: dict[str, list[Edge]] = defaultdict(list)
        for edge in self.edges:
            result[edge.source].append(edge)
        for edges in result.values():
            edges.sort(key=lambda edge: edge.name)
        return result


State = tuple[str, int]


def safe_name(value: str) -> str:
    return re.sub(r"[^a-z0-9-]+", "-", value.lower()).strip("-")


def variants(depth: int, high_branching: int, initial_fuel: int) -> list[Variant]:
    consuming = initial_fuel + 1
    if depth < consuming * 2:
        raise ValueError(
            f"depth must be at least {consuming * 2} so early/deep conflicts are separated"
        )
    early = tuple(range(1, consuming + 1))
    deep = tuple(range(depth - consuming + 1, depth + 1))
    return [
        Variant(
            name=f"{revelation}-{branching_label}",
            revelation=revelation,
            branching_label=branching_label,
            branching=branching,
            depth=depth,
            initial_fuel=initial_fuel,
            good_depth=depth + 2,
            consuming_levels=early if revelation == "early" else deep,
        )
        for revelation in ("early", "deep")
        for branching_label, branching in (("low", 1), ("high", high_branching))
    ]


def build_graph(variant: Variant) -> Graph:
    nodes = ["root"]
    edges: list[Edge] = []

    previous = "root"
    for level in range(1, variant.good_depth + 1):
        target = f"good-{level}"
        nodes.append(target)
        edges.append(Edge(f"z-good-{level}", previous, target, 0, "good", level))
        previous = target
    terminals = {previous}

    parents = ["root"]
    for level in range(1, variant.depth + 1):
        children: list[str] = []
        for parent_index, parent in enumerate(parents):
            for child_index in range(variant.branching):
                child = f"bad-{level}-{parent_index}-{child_index}"
                children.append(child)
                nodes.append(child)
                cost = 1 if level in variant.consuming_levels else 0
                edges.append(Edge(
                    f"a-bad-{level}-{parent_index}-{child_index}",
                    parent, child, cost, "bad", level,
                ))
        parents = children
    terminals.update(parents)
    return Graph(variant, nodes, edges, terminals)


def write_pddl(graph: Graph, directory: Path) -> tuple[Path, Path]:
    directory.mkdir(parents=True, exist_ok=True)
    domain_name = f"delayed-conflict-{safe_name(graph.variant.name)}"
    constants = " ".join(graph.nodes)
    edge_facts = "\n    ".join(
        f"(edge {edge.source} {edge.target}) (= (edge-cost {edge.source} {edge.target}) {edge.fuel_cost})"
        for edge in graph.edges
    )
    terminal_facts = " ".join(f"(terminal {terminal})" for terminal in sorted(graph.terminals))
    domain = f"""(define (domain {domain_name})
  (:requirements :strips :typing :fluents)
  (:types node)
  (:constants {constants} - node)
  (:predicates (at ?n - node) (edge ?from ?to - node) (terminal ?n - node) (done))
  (:functions (fuel) (total-cost) (edge-cost ?from ?to - node))
  (:action a-move
    :parameters (?from ?to - node)
    :precondition (and (at ?from) (edge ?from ?to)
                       (>= (fuel) (edge-cost ?from ?to)))
    :effect (and (not (at ?from)) (at ?to)
                 (decrease (fuel) (edge-cost ?from ?to))
                 (increase (total-cost) 1)))
  (:action z-finish
    :parameters (?n - node)
    :precondition (and (at ?n) (terminal ?n))
    :effect (and (done) (increase (total-cost) 1)))
)
"""
    problem = f"""(define (problem {domain_name}-p01)
  (:domain {domain_name})
  (:init (at root) {terminal_facts}
    {edge_facts}
    (= (fuel) {graph.variant.initial_fuel}) (= (total-cost) 0))
  (:goal (done))
  (:metric minimize (total-cost))
)
"""
    domain_path = directory / "domain.pddl"
    problem_path = directory / "problem.pddl"
    domain_path.write_text(domain)
    problem_path.write_text(problem)
    (directory / "graph.json").write_text(json.dumps({
        "variant": {**asdict(graph.variant), "manifestation_depth": graph.variant.manifestation_depth},
        "nodes": graph.nodes,
        "terminals": sorted(graph.terminals),
        "edges": [asdict(edge) for edge in graph.edges],
    }, indent=2) + "\n")
    return domain_path, problem_path


def concrete_successors(graph: Graph, state: State) -> Iterable[tuple[Edge, State]]:
    node, fuel = state
    for edge in graph.outgoing().get(node, []):
        if fuel >= edge.fuel_cost:
            yield edge, (edge.target, fuel - edge.fuel_cost)


def exact_oracle(graph: Graph) -> dict[str, object]:
    initial = ("root", graph.variant.initial_fuel)
    reachable = {initial}
    queue = deque([initial])
    transitions: dict[State, list[tuple[Edge, State]]] = defaultdict(list)
    reverse: dict[State, list[State]] = defaultdict(list)
    while queue:
        state = queue.popleft()
        for edge, successor in concrete_successors(graph, state):
            transitions[state].append((edge, successor))
            reverse[successor].append(state)
            if successor not in reachable:
                reachable.add(successor)
                queue.append(successor)

    distance: dict[State, int] = {}
    reverse_queue: deque[State] = deque()
    for state in reachable:
        if state[0] in graph.terminals:
            distance[state] = 1  # The terminal finish action.
            reverse_queue.append(state)
    while reverse_queue:
        state = reverse_queue.popleft()
        for predecessor in reverse.get(state, []):
            candidate = distance[state] + 1
            if predecessor not in distance or candidate < distance[predecessor]:
                distance[predecessor] = candidate
                reverse_queue.append(predecessor)

    bad_root_actions = []
    good_root_actions = []
    for edge, successor in transitions[initial]:
        record = {"action": edge.name, "successor_solvable": successor in distance}
        (good_root_actions if edge.route == "good" else bad_root_actions).append(record)

    return {
        "initial_solvable": initial in distance,
        "initial_exact_distance": distance.get(initial),
        "reachable_states": len(reachable),
        "solvable_states": len(distance),
        "dead_end_states": len(reachable - distance.keys()),
        "distance": distance,
        "reachable": reachable,
        "transitions": transitions,
        "bad_root_actions": bad_root_actions,
        "good_root_actions": good_root_actions,
    }


def relaxed_distances(graph: Graph, fuel: int) -> dict[str, int]:
    """Distance to a terminal while ignoring cumulative decreases.

    Each edge still has to be individually applicable at the state's current
    fuel value.  Fuel is not reduced between relaxed layers.
    """
    reverse: dict[str, list[str]] = defaultdict(list)
    for edge in graph.edges:
        if fuel >= edge.fuel_cost:
            reverse[edge.target].append(edge.source)
    result = {terminal: 1 for terminal in graph.terminals}
    queue = deque(graph.terminals)
    while queue:
        node = queue.popleft()
        for predecessor in reverse.get(node, []):
            candidate = result[node] + 1
            if predecessor not in result or candidate < result[predecessor]:
                result[predecessor] = candidate
                queue.append(predecessor)
    return result


def relaxed_h(graph: Graph, state: State) -> float:
    node, fuel = state
    return float(relaxed_distances(graph, fuel).get(node, math.inf))


def reference_analysis(graph: Graph, oracle: dict[str, object]) -> dict[str, object]:
    reachable: set[State] = oracle["reachable"]  # type: ignore[assignment]
    distance: dict[State, int] = oracle["distance"]  # type: ignore[assignment]
    false_finite = [state for state in reachable if state not in distance and math.isfinite(relaxed_h(graph, state))]

    initial = ("root", graph.variant.initial_fuel)
    open_list: list[tuple[float, int, State]] = []
    counter = 0
    heapq.heappush(open_list, (relaxed_h(graph, initial), counter, initial))
    seen = {initial}
    expanded = 0
    false_finite_expanded = 0
    goal_state: State | None = None
    while open_list:
        heuristic, _, state = heapq.heappop(open_list)
        if not math.isfinite(heuristic):
            continue
        expanded += 1
        if state not in distance:
            false_finite_expanded += 1
        if state[0] in graph.terminals:
            goal_state = state
            break
        for _, successor in concrete_successors(graph, state):
            if successor in seen:
                continue
            seen.add(successor)
            value = relaxed_h(graph, successor)
            if not math.isfinite(value):
                continue
            counter += 1
            heapq.heappush(open_list, (value, counter, successor))

    finite_branching = []
    for state in false_finite:
        count = sum(
            1 for _, successor in concrete_successors(graph, state)
            if math.isfinite(relaxed_h(graph, successor))
        )
        finite_branching.append(count)
    return {
        "relaxed_initial_h": relaxed_h(graph, initial),
        "false_finite_states": len(false_finite),
        "false_finite_fraction": len(false_finite) / len(reachable) if reachable else 0,
        "mean_persistent_branching": (
            sum(finite_branching) / len(finite_branching) if finite_branching else 0
        ),
        "reference_gbfs_solved": goal_state is not None,
        "reference_gbfs_expanded": expanded,
        "reference_false_finite_expanded": false_finite_expanded,
    }


def write_oracle_traces(graph: Graph, oracle: dict[str, object], directory: Path) -> None:
    reachable: set[State] = oracle["reachable"]  # type: ignore[assignment]
    distance: dict[State, int] = oracle["distance"]  # type: ignore[assignment]
    transitions: dict[State, list[tuple[Edge, State]]] = oracle["transitions"]  # type: ignore[assignment]
    state_columns = (
        "node", "fuel", "state_solvable", "exact_remaining_cost", "relaxed_h",
        "false_finite", "concrete_successors", "finite_relaxed_successors",
        "solvable_successors",
    )
    with (directory / "oracle_states.csv").open("w", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=state_columns)
        writer.writeheader()
        for state in sorted(reachable):
            successors = transitions.get(state, [])
            h_value = relaxed_h(graph, state)
            writer.writerow({
                "node": state[0],
                "fuel": state[1],
                "state_solvable": str(state in distance).lower(),
                "exact_remaining_cost": distance.get(state, "infinity"),
                "relaxed_h": int(h_value) if math.isfinite(h_value) else "infinity",
                "false_finite": str(state not in distance and math.isfinite(h_value)).lower(),
                "concrete_successors": len(successors),
                "finite_relaxed_successors": sum(
                    math.isfinite(relaxed_h(graph, successor)) for _, successor in successors
                ),
                "solvable_successors": sum(successor in distance for _, successor in successors),
            })

    action_columns = (
        "node", "fuel", "action", "route", "level", "fuel_cost",
        "successor_node", "successor_fuel", "successor_solvable",
        "successor_exact_remaining_cost", "successor_relaxed_h", "bad_action_ranking_candidate",
    )
    with (directory / "oracle_actions.csv").open("w", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=action_columns)
        writer.writeheader()
        for state in sorted(reachable):
            successors = transitions.get(state, [])
            has_solvable = any(successor in distance for _, successor in successors)
            for edge, successor in successors:
                h_value = relaxed_h(graph, successor)
                writer.writerow({
                    "node": state[0],
                    "fuel": state[1],
                    "action": edge.name,
                    "route": edge.route,
                    "level": edge.level,
                    "fuel_cost": edge.fuel_cost,
                    "successor_node": successor[0],
                    "successor_fuel": successor[1],
                    "successor_solvable": str(successor in distance).lower(),
                    "successor_exact_remaining_cost": distance.get(successor, "infinity"),
                    "successor_relaxed_h": int(h_value) if math.isfinite(h_value) else "infinity",
                    "bad_action_ranking_candidate": str(has_solvable and successor not in distance).lower(),
                })


def parse_metric_ff_expanded(output: str) -> str:
    patterns = (
        r"Expanded Nodes:\s*(\d+)",
        r"(\d+)\s+states? evaluated",
        r"evaluated\s+(\d+)\s+states?",
        r"searching,\s+evaluating\s+(\d+)\s+states?",
        r"(\d+)\s+expanded",
    )
    for pattern in patterns:
        matches = re.findall(pattern, output, re.IGNORECASE)
        if matches:
            return matches[-1]
    return ""


def run_metric_ff(domain: Path, problem: Path, case_dir: Path, timeout: float) -> dict[str, object]:
    command = [
        str(ROOT / "planners" / "plannerctl"), "run", "metric-ff-cross-v1",
        "-o", str(domain.resolve()), "-f", str(problem.resolve()), "-E",
    ]
    started = time.monotonic()
    try:
        result = subprocess.run(
            command, cwd=case_dir, text=True, stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT, timeout=timeout, check=False,
        )
        elapsed = time.monotonic() - started
        timed_out = False
        returncode: int | None = result.returncode
        output = result.stdout
    except subprocess.TimeoutExpired as error:
        elapsed = time.monotonic() - started
        timed_out = True
        returncode = None
        output = (error.stdout or "") + (error.stderr or "")
        if isinstance(output, bytes):
            output = output.decode(errors="replace")
    (case_dir / "metric-ff.log").write_text(output)
    (case_dir / "metric-ff-command.json").write_text(json.dumps(command, indent=2) + "\n")
    status = classify(returncode, timed_out, output)
    actions = extract_plan("metric-ff-cross-v1", output, domain.read_text()) if status == "solved" else []
    validation = "not-run"
    if actions:
        plan = case_dir / "metric-ff.plan"
        plan.write_text(render_plan(actions))
        validation = validate_plan(domain, problem, plan, case_dir / "metric-ff-validation.log")
    return {
        "metric_ff_status": status,
        "metric_ff_validation": validation,
        "metric_ff_wall_seconds": round(elapsed, 6),
        "metric_ff_expanded": parse_metric_ff_expanded(output),
        "metric_ff_plan_length": len(actions) if actions else "",
        "metric_ff_returncode": "timeout" if timed_out else returncode,
    }


def write_summary(output_root: Path, rows: list[dict[str, object]]) -> None:
    columns = [
        "variant", "revelation", "branching", "manifestation_depth",
        "reachable_states", "dead_end_states", "false_finite_states",
        "reference_gbfs_expanded", "reference_false_finite_expanded",
        "metric_ff_status", "metric_ff_validation", "metric_ff_wall_seconds",
        "metric_ff_expanded", "metric_ff_plan_length",
    ]
    with (output_root / "results.csv").open("w", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=columns, extrasaction="ignore")
        writer.writeheader()
        writer.writerows(rows)

    by_variant = {str(row["variant"]): row for row in rows}
    early_high = by_variant["early-high"]
    deep_high = by_variant["deep-high"]
    deep_low = by_variant["deep-low"]

    def ratio(numerator: object, denominator: object) -> str:
        try:
            return f"{float(numerator) / float(denominator):.2f}배"
        except (TypeError, ValueError, ZeroDivisionError):
            return "계산 불가"

    lines = [
        "# Delayed numeric conflict 2×2 결과",
        "",
        "## 결과 읽는 법",
        "",
        "- `early/deep`: 같은 총 연료 부족이 경로 초반/후반에 드러난다.",
        "- `low/high`: 모순이 드러나기 전까지 선택 가능한 실패 경로가 적다/많다.",
        "- `False-finite`: exact oracle은 dead end라고 판정하지만 감소를 무시한 relaxation은 유한한 값을 준 상태다.",
        "- 네 조건 모두 하나의 별도 good route가 있어 전체 PDDL 문제는 solvable이다.",
        "",
        "## 결과",
        "",
        "| Variant | Depth | Branching | False-finite | Reference expanded | Metric-FF | VAL | Metric-FF expanded |",
        "|---|---:|---:|---:|---:|---|---|---:|",
    ]
    for row in rows:
        lines.append(
            f"| {row['variant']} | {row['manifestation_depth']} | {row['branching']} | "
            f"{row['false_finite_states']} | {row['reference_gbfs_expanded']} | "
            f"{row['metric_ff_status']} | {row['metric_ff_validation']} | "
            f"{row['metric_ff_expanded'] or '—'} |"
        )
    lines += [
        "",
        "## 첫 해석",
        "",
        f"- High branching에서 모순을 early에서 deep으로 옮기면 false-finite 상태가 "
        f"{early_high['false_finite_states']}개에서 {deep_high['false_finite_states']}개로 늘었다.",
        f"- 같은 비교에서 Metric-FF evaluated states는 {early_high['metric_ff_expanded']}개에서 "
        f"{deep_high['metric_ff_expanded']}개로 늘었다 "
        f"({ratio(deep_high['metric_ff_expanded'], early_high['metric_ff_expanded'])}).",
        f"- Deep conflict에서 branching을 low에서 high로 바꾸면 Metric-FF evaluated states는 "
        f"{deep_low['metric_ff_expanded']}개에서 {deep_high['metric_ff_expanded']}개로 늘었다 "
        f"({ratio(deep_high['metric_ff_expanded'], deep_low['metric_ff_expanded'])}).",
        "- 이 결과는 synthetic 조작과 측정 pipeline의 sanity check이며 실제 domain 일반화 증거는 아니다.",
        "",
    ]
    (output_root / "summary.md").write_text("\n".join(lines))


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--depth", type=int, default=6, help="bad-route edge depth")
    parser.add_argument("--high-branching", type=int, default=2)
    parser.add_argument("--initial-fuel", type=int, default=2)
    parser.add_argument("--timeout", type=float, default=30.0)
    parser.add_argument("--skip-planner", action="store_true", help="run only oracle/reference search")
    parser.add_argument("--output", type=Path, help="output directory")
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    stamp = datetime.now().strftime("%Y%m%d-%H%M%S")
    output_root = (args.output or ROOT / "results" / "delayed-conflict" / stamp).resolve()
    output_root.mkdir(parents=True, exist_ok=False)
    rows: list[dict[str, object]] = []
    for variant in variants(args.depth, args.high_branching, args.initial_fuel):
        case_dir = output_root / variant.name
        graph = build_graph(variant)
        domain, problem = write_pddl(graph, case_dir)
        oracle = exact_oracle(graph)
        reference = reference_analysis(graph, oracle)
        write_oracle_traces(graph, oracle, case_dir)
        row: dict[str, object] = {
            "variant": variant.name,
            "revelation": variant.revelation,
            "branching_label": variant.branching_label,
            "branching": variant.branching,
            "manifestation_depth": variant.manifestation_depth,
            "nodes": len(graph.nodes),
            "edges": len(graph.edges),
            **{key: value for key, value in oracle.items() if key not in {"distance", "reachable", "transitions"}},
            **reference,
        }
        if args.skip_planner:
            row.update({
                "metric_ff_status": "skipped", "metric_ff_validation": "not-run",
                "metric_ff_wall_seconds": "", "metric_ff_expanded": "",
                "metric_ff_plan_length": "", "metric_ff_returncode": "",
            })
        else:
            row.update(run_metric_ff(domain, problem, case_dir, args.timeout))
        (case_dir / "result.json").write_text(json.dumps(row, indent=2, default=str) + "\n")
        rows.append(row)
        print(
            f"{variant.name:10s} depth={variant.manifestation_depth} branch={variant.branching} "
            f"false-finite={row['false_finite_states']} ref-expanded={row['reference_gbfs_expanded']} "
            f"metric-ff={row['metric_ff_status']} val={row['metric_ff_validation']}",
            flush=True,
        )
    write_summary(output_root, rows)
    print(f"results: {output_root}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
