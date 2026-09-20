#!/usr/bin/env python3
"""Run matched delayed-conflict micro instances using real domain schemas.

The same four edge costs are permuted so that a capacity violation appears on
the second (early) or fourth (deep) move.  Total demand, capacity, objects, and
goal remain fixed.  High-branching variants add executable dead-end side
roads; they do not create another route to the goal.
"""

from __future__ import annotations

import argparse
import csv
import json
import re
import sys
import time
from datetime import datetime, timezone
from pathlib import Path

sys.dont_write_bytecode = True
HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(HERE))
sys.path.insert(0, str(ROOT / "src" / "planner_gui"))

import benchmark_core as core
from profiles import build_command


CAPACITY = 10
COSTS = {"early": (6, 6, 1, 1), "deep": (1, 1, 6, 6)}


def manifestation_depth(costs: tuple[int, ...], capacity: int = CAPACITY) -> int:
    remaining = capacity
    for index, cost in enumerate(costs, start=1):
        if remaining < cost:
            return index
        remaining -= cost
    raise ValueError("cost sequence does not produce a blocked edge")


def side_objects(branching: int) -> list[str]:
    return [f"side{i}_{j}" for i in range(3) for j in range(branching)]


def watering_problem(depth: str, branching: int) -> str:
    costs = COSTS[depth]
    sides = side_objects(branching)
    locations = [f"n{i}" for i in range(5)] + sides
    connected = []
    numeric = []
    for index, cost in enumerate(costs):
        connected.append(f"    (connected n{index} n{index + 1})")
        numeric += [
            f"    (= (move-energy n{index} n{index + 1}) {cost})",
            f"    (= (move-time n{index} n{index + 1}) {cost})",
        ]
    for i in range(3):
        for j in range(branching):
            side = f"side{i}_{j}"
            connected.append(f"    (connected n{i} {side})")
            numeric += [
                f"    (= (move-energy n{i} {side}) 1)",
                f"    (= (move-time n{i} {side}) 1)",
            ]
    return f"""(define (problem watering-delayed-{depth}-b{branching})
  (:domain robotic-watering)
  (:objects robot1 - robot can1 - container plant1 - plant {' '.join(locations)} - location)
  (:init
    (at-robot robot1 n0)
    (holding robot1 can1)
    (plant-at plant1 n4)
{chr(10).join(connected)}
    (= (battery-capacity robot1) {CAPACITY})
    (= (battery-level robot1) {CAPACITY})
    (= (container-capacity can1) 1)
    (= (water-level can1) 1)
    (= (plant-demand plant1) 1)
    (= (watered-amount plant1) 0)
{chr(10).join(numeric)}
    (= (pick-time) 1) (= (drop-time) 1) (= (fill-time) 1)
    (= (watering-unit-time) 1) (= (charge-time) 1)
    (= (pick-energy) 1) (= (drop-energy) 1) (= (fill-energy) 1)
    (= (watering-unit-energy) 1) (= (total-watering-time) 0)
  )
  (:goal (>= (watered-amount plant1) (plant-demand plant1)))
  (:metric minimize (total-watering-time))
)
"""


def logistics_problem(depth: str, branching: int) -> str:
    costs = COSTS[depth]
    sides = side_objects(branching)
    places = [f"n{i}" for i in range(5)] + sides
    roads = []
    numeric = []
    for index, cost in enumerate(costs):
        roads.append(f"    (local-road n{index} n{index + 1})")
        numeric += [
            f"    (= (distance n{index} n{index + 1}) {cost})",
            f"    (= (local-road-time n{index} n{index + 1}) {cost})",
        ]
    for i in range(3):
        for j in range(branching):
            side = f"side{i}_{j}"
            roads.append(f"    (local-road n{i} {side})")
            numeric += [
                f"    (= (distance n{i} {side}) 1)",
                f"    (= (local-road-time n{i} {side}) 1)",
            ]
    place_facts = " ".join(f"(place {place})" for place in places)
    return f"""(define (problem logistics-delayed-{depth}-b{branching})
  (:domain logistic)
  (:objects driver1 truck1 pack1 {' '.join(places)})
  (:init
    (driver driver1) (truck truck1) (package pack1) {place_facts}
    (at truck1 n0) (in driver1 truck1) (loaded pack1 truck1)
{chr(10).join(roads)}
    (= (package-weight pack1) 1)
    (= (truck-capacity truck1) 10) (= (truck-load truck1) 1)
    (= (fuel-capacity truck1) {CAPACITY}) (= (fuel-level truck1) {CAPACITY})
    (= (manual-capacity driver1) 0)
    (= (refuel-cost truck1) 100) (= (refuel-time truck1) 1)
{chr(10).join(numeric)}
    (= (budget) 0) (= (total-cost) 0) (= (total-delivery-time) 0)
  )
  (:goal (at pack1 n4))
  (:metric minimize (total-delivery-time))
)
"""


def metric_ff_evaluated(log_path: Path) -> int | None:
    if not log_path.exists():
        return None
    matches = re.findall(r"evaluating\s+(\d+)\s+states", log_path.read_text(errors="replace"))
    return int(matches[-1]) if matches else None


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("--timeout", type=float, default=30.0)
    parser.add_argument("--memory-mb", type=int, default=4096)
    parser.add_argument("--output", default="results/delayed-conflict-domain-micro")
    parser.add_argument("--planner", default="metric-ff-cross-v1")
    parser.add_argument("--heuristic", default="numeric-hff")
    parser.add_argument("--search", default="default")
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    output_root = Path(args.output)
    if not output_root.is_absolute():
        output_root = ROOT / output_root
    stamp = datetime.now().strftime("%Y%m%d-%H%M%S-%f")
    run_dir = core.unique_run_dir(output_root.resolve(), stamp)
    inputs = run_dir / "inputs"
    inputs.mkdir(parents=True)

    variants = []
    for domain in ("watering", "logistics"):
        for depth in ("early", "deep"):
            for branch_label, branching in (("low", 0), ("high", 2)):
                name = f"{domain}__{depth}-{branch_label}"
                path = inputs / f"{name}.pddl"
                maker = watering_problem if domain == "watering" else logistics_problem
                path.write_text(maker(depth, branching), encoding="utf-8")
                variants.append({
                    "domain": domain,
                    "variant": name,
                    "depth": depth,
                    "branching": branch_label,
                    "side_actions_per_layer": branching,
                    "manifestation_edge": manifestation_depth(COSTS[depth]),
                    "path": path,
                })

    benchmark_map = core.benchmark_map()
    planner_map = core.planner_map()
    benchmark_ids = {"watering": "changmin_04_watering", "logistics": "changmin_02_logistics"}
    results = []
    print(f"results: {run_dir.relative_to(ROOT)}", flush=True)
    started = time.monotonic()
    for index, variant in enumerate(variants, start=1):
        entry = dict(benchmark_map[benchmark_ids[variant["domain"]]])
        entry["id"] = f"delayed_micro_{variant['domain']}"

        def builder(domain: Path, problem: Path) -> list[str]:
            if args.planner == "metric-ff-cross-v1":
                options = {"helpful": "true"}
            elif args.planner == "enhsp":
                options = {"helpful": "default", "ties": "arbitrary"}
            else:
                options = {}
            return build_command(ROOT, args.planner, domain, problem, args.heuristic, args.search, options)

        row = core.run_case(
            run_dir=run_dir,
            planner=args.planner,
            entry=entry,
            problem=variant["path"],
            capability=planner_map[args.planner],
            timeout=args.timeout,
            force=False,
            dry_run=False,
            validate_plans=True,
            memory_limit_mb=args.memory_mb,
            process_limit=128,
            log_limit_mb=32,
            monitor_interval=0.1,
            configuration_id=f"h-{args.heuristic}__s-{args.search}",
            heuristic=args.heuristic,
            search=args.search,
            command_builder=builder,
        )
        case_dir = Path(row["case_directory"])
        if not case_dir.is_absolute():
            case_dir = ROOT / case_dir
        row.update({
            "instance": variant["variant"],
            "source_domain": variant["domain"],
            "depth_condition": variant["depth"],
            "branching_condition": variant["branching"],
            "side_actions_per_layer": variant["side_actions_per_layer"],
            "manifestation_edge": variant["manifestation_edge"],
            "evaluated_states": metric_ff_evaluated(case_dir / "planner.log"),
        })
        results.append(row)
        print(
            f"[{index}/{len(variants)}] {variant['variant']} {row['status']} "
            f"wall={row['wall_seconds']} evaluated={row['evaluated_states']}", flush=True,
        )

    extras = [
        "source_domain", "depth_condition", "branching_condition",
        "side_actions_per_layer", "manifestation_edge", "evaluated_states",
    ]
    with (run_dir / "results.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(core.RESULT_COLUMNS) + extras)
        writer.writeheader()
        writer.writerows(results)
    (run_dir / "manifest.json").write_text(json.dumps({
        "created_at": datetime.now(timezone.utc).isoformat(),
        "capacity": CAPACITY,
        "edge_costs": COSTS,
        "case_count": len(results),
        "runner_wall_seconds": round(time.monotonic() - started, 6),
        "control": "same total edge cost; only cost order and dead-end side branching change",
    }, indent=2) + "\n", encoding="utf-8")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
