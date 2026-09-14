#!/usr/bin/env python3
"""Generate solvable numeric logistics PDDL problems and graph summaries.

Edit the global configuration below, then run this file. For every pNNN.pddl
problem, an images/pNNN.png summary is created. Road counts refer to undirected
connections; PDDL facts are emitted in both directions.
"""

from __future__ import annotations

import argparse
import math
import os
import random
import re
from dataclasses import dataclass
from pathlib import Path

os.environ.setdefault("MPLCONFIGDIR", "/tmp/changmin-logistics-matplotlib")

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt
import networkx as nx
from matplotlib.lines import Line2D


# ---------------------------------------------------------------------------
# Global generator configuration: edit these values.
# ---------------------------------------------------------------------------

NUM_PROBLEMS = 1
START_INDEX = 4  # p001 is the hand-designed reference instance.

NUM_PACKAGES = 9
NUM_TRUCKS = 2
NUM_PLACES = 8
NUM_HIGHWAYS = 5
NUM_LOCAL_ROADS = 10

RANDOM_SEED = 5302
MANUAL_CAPACITY = 100
MIN_PACKAGE_WEIGHT = 50
MAX_PACKAGE_WEIGHT = 130
MIN_TRUCK_CAPACITY = 800
MAX_TRUCK_CAPACITY = 1200

# Budget = one optional refuel per truck + this fraction of all highway tolls.
# This is an initial scaling rule and the main target for later fine-tuning.
HIGHWAY_BUDGET_RATIO = 0.40
MIN_FUEL_STATION_RATIO = 0.30

DOMAIN_DIR = Path(__file__).resolve().parent
INSTANCE_DIR = DOMAIN_DIR / "instances"
IMAGE_DIR = DOMAIN_DIR / "images"
README_PATH = DOMAIN_DIR / "README.md"
SUMMARY_START = "<!-- AUTO-GENERATED-PROBLEM-SUMMARY:START -->"
SUMMARY_END = "<!-- AUTO-GENERATED-PROBLEM-SUMMARY:END -->"


@dataclass(frozen=True)
class Package:
    name: str
    origin: str
    destination: str
    weight: int


@dataclass(frozen=True)
class Truck:
    name: str
    driver: str
    start: str
    capacity: int
    fuel_capacity: int
    initial_fuel: int
    refuel_cost: int
    refuel_time: int


@dataclass
class ProblemData:
    problem_name: str
    places: list[str]
    local_roads: set[tuple[str, str]]
    highways: set[tuple[str, str]]
    distances: dict[tuple[str, str], int]
    highway_times: dict[tuple[str, str], int]
    local_times: dict[tuple[str, str], int]
    tolls: dict[tuple[str, str], int]
    fuel_stations: set[str]
    trucks: list[Truck]
    packages: list[Package]
    budget: int


def canonical_edge(a: str, b: str) -> tuple[str, str]:
    return (a, b) if a < b else (b, a)


def validate_configuration() -> None:
    if NUM_PROBLEMS < 1:
        raise ValueError("NUM_PROBLEMS must be at least 1")
    if NUM_PLACES < 2:
        raise ValueError("NUM_PLACES must be at least 2")
    if NUM_PACKAGES < 1:
        raise ValueError("NUM_PACKAGES must be at least 1")
    if not 1 <= NUM_TRUCKS <= NUM_PLACES:
        raise ValueError("NUM_TRUCKS must be between 1 and NUM_PLACES")

    max_edges = NUM_PLACES * (NUM_PLACES - 1) // 2
    if not NUM_PLACES - 1 <= NUM_LOCAL_ROADS <= max_edges:
        raise ValueError(
            f"NUM_LOCAL_ROADS must be in [{NUM_PLACES - 1}, {max_edges}] "
            "so the local-road graph can be connected"
        )
    if not 0 <= NUM_HIGHWAYS <= max_edges:
        raise ValueError(f"NUM_HIGHWAYS must be in [0, {max_edges}]")
    if not 0.0 <= HIGHWAY_BUDGET_RATIO <= 1.0:
        raise ValueError("HIGHWAY_BUDGET_RATIO must be between 0 and 1")
    if not 0.0 < MIN_FUEL_STATION_RATIO <= 1.0:
        raise ValueError("MIN_FUEL_STATION_RATIO must be in (0, 1]")
    if MIN_TRUCK_CAPACITY <= MANUAL_CAPACITY:
        raise ValueError("MIN_TRUCK_CAPACITY must exceed MANUAL_CAPACITY")
    if MAX_TRUCK_CAPACITY < MIN_TRUCK_CAPACITY:
        raise ValueError("MAX_TRUCK_CAPACITY must be >= MIN_TRUCK_CAPACITY")
    if MIN_PACKAGE_WEIGHT < 1 or MAX_PACKAGE_WEIGHT < MIN_PACKAGE_WEIGHT:
        raise ValueError("package weight range is invalid")
    if MAX_PACKAGE_WEIGHT <= MANUAL_CAPACITY:
        raise ValueError(
            "MAX_PACKAGE_WEIGHT must exceed MANUAL_CAPACITY so a heavy package can exist"
        )
    if MAX_PACKAGE_WEIGHT > MIN_TRUCK_CAPACITY:
        raise ValueError("every package must fit in every generated truck")


def sample_connected_edges(
    places: list[str], edge_count: int, rng: random.Random
) -> set[tuple[str, str]]:
    """Create a random spanning tree, then add edges up to edge_count."""
    order = places.copy()
    rng.shuffle(order)
    edges: set[tuple[str, str]] = set()
    for index in range(1, len(order)):
        parent = rng.choice(order[:index])
        edges.add(canonical_edge(order[index], parent))

    candidates = [
        canonical_edge(a, b)
        for index, a in enumerate(places)
        for b in places[index + 1 :]
        if canonical_edge(a, b) not in edges
    ]
    rng.shuffle(candidates)
    edges.update(candidates[: edge_count - len(edges)])
    return edges


def sample_highways(
    places: list[str], edge_count: int, rng: random.Random
) -> set[tuple[str, str]]:
    candidates = [
        canonical_edge(a, b)
        for index, a in enumerate(places)
        for b in places[index + 1 :]
    ]
    rng.shuffle(candidates)
    return set(candidates[:edge_count])


def generate_data(problem_index: int) -> ProblemData:
    rng = random.Random(RANDOM_SEED + problem_index)
    places = [f"place{i}" for i in range(1, NUM_PLACES + 1)]
    local_roads = sample_connected_edges(places, NUM_LOCAL_ROADS, rng)
    highways = sample_highways(places, NUM_HIGHWAYS, rng)
    all_edges = local_roads | highways

    distances = {edge: rng.randint(4, 14) for edge in sorted(all_edges)}
    local_times = {
        edge: distances[edge] + rng.randint(3, 8) for edge in sorted(local_roads)
    }
    highway_times = {
        edge: max(1, math.ceil(distances[edge] * rng.uniform(0.35, 0.60)))
        for edge in sorted(highways)
    }
    tolls = {
        edge: max(1, math.ceil(distances[edge] / 3)) for edge in sorted(highways)
    }

    # Keep fuel stations at or above a fixed fraction of all places, while
    # also providing a station for every truck starting position.
    station_count = min(
        NUM_PLACES,
        max(NUM_TRUCKS, math.ceil(NUM_PLACES * MIN_FUEL_STATION_RATIO)),
    )
    station_order = places.copy()
    rng.shuffle(station_order)
    fuel_stations = set(station_order[:station_count])
    station_list = sorted(fuel_stations)

    trucks: list[Truck] = []
    for index in range(NUM_TRUCKS):
        trucks.append(
            Truck(
                name=f"truck{index + 1}",
                driver=f"driver{index + 1}",
                start=station_list[index % len(station_list)],
                capacity=rng.randint(MIN_TRUCK_CAPACITY, MAX_TRUCK_CAPACITY),
                fuel_capacity=0,  # Filled after package routes are known.
                initial_fuel=0,  # Set to the generated full capacity below.
                refuel_cost=5 + math.ceil(NUM_PLACES / 3),
                refuel_time=2 + math.ceil(NUM_PLACES / 5),
            )
        )

    # Package 1 is always too heavy to walk, making truck/refuel mandatory.
    packages: list[Package] = []
    for index in range(NUM_PACKAGES):
        origin, destination = rng.sample(places, 2)
        weight = (
            rng.randint(MANUAL_CAPACITY + 1, MAX_PACKAGE_WEIGHT)
            if index == 0
            else rng.randint(MIN_PACKAGE_WEIGHT, MAX_PACKAGE_WEIGHT)
        )
        packages.append(
            Package(
                name=f"pack{index + 1}",
                origin=origin,
                destination=destination,
                weight=weight,
            )
        )

    # Fuel consumption equals road distance. Take the three roads with the
    # largest distance values and use their sum as the base tank capacity.
    # For very small graphs with fewer than three roads, use every road.
    largest_road_consumptions = sorted(distances.values(), reverse=True)[:3]
    base_fuel_demand = sum(largest_road_consumptions)
    fuel_capacity_ratio = rng.uniform(1.00, 1.20)
    fuel_capacity = max(20, math.ceil(base_fuel_demand * fuel_capacity_ratio))
    trucks = [
        Truck(
            name=truck.name,
            driver=truck.driver,
            start=truck.start,
            capacity=truck.capacity,
            fuel_capacity=fuel_capacity,
            initial_fuel=fuel_capacity,
            refuel_cost=truck.refuel_cost,
            refuel_time=truck.refuel_time,
        )
        for truck in trucks
    ]

    refuel_reserve = sum(truck.refuel_cost for truck in trucks)
    highway_allowance = math.ceil(sum(tolls.values()) * HIGHWAY_BUDGET_RATIO)
    budget = refuel_reserve + highway_allowance

    return ProblemData(
        problem_name=f"logistics-p{problem_index:03d}",
        places=places,
        local_roads=local_roads,
        highways=highways,
        distances=distances,
        highway_times=highway_times,
        local_times=local_times,
        tolls=tolls,
        fuel_stations=fuel_stations,
        trucks=trucks,
        packages=packages,
        budget=budget,
    )


def add_bidirectional_facts(
    lines: list[str], predicate: str, edges: set[tuple[str, str]]
) -> None:
    for a, b in sorted(edges):
        lines.append(f"    ({predicate} {a} {b}) ({predicate} {b} {a})")


def add_bidirectional_values(
    lines: list[str], function: str, values: dict[tuple[str, str], int]
) -> None:
    for (a, b), value in sorted(values.items()):
        lines.append(
            f"    (= ({function} {a} {b}) {value}) "
            f"(= ({function} {b} {a}) {value})"
        )


def render_pddl(data: ProblemData) -> str:
    lines = [
        f"(define (problem {data.problem_name}) (:domain logistic)",
        "  (:objects",
        f"    {' '.join(truck.driver for truck in data.trucks)}",
        f"    {' '.join(truck.name for truck in data.trucks)}",
        f"    {' '.join(package.name for package in data.packages)}",
        f"    {' '.join(data.places)}",
        "  )",
        "",
        "  (:init",
    ]
    for truck in data.trucks:
        lines.extend(
            [
                f"    (driver {truck.driver})",
                f"    (truck {truck.name})",
                f"    (at {truck.driver} {truck.start})",
                f"    (at {truck.name} {truck.start})",
            ]
        )
    for package in data.packages:
        lines.extend(
            [f"    (package {package.name})", f"    (at {package.name} {package.origin})"]
        )
    for place in data.places:
        lines.append(f"    (place {place})")
    for station in sorted(data.fuel_stations):
        lines.append(f"    (fuel-station {station})")

    lines.append("")
    add_bidirectional_facts(lines, "local-road", data.local_roads)
    add_bidirectional_facts(lines, "walkable", data.local_roads)
    add_bidirectional_facts(lines, "highway", data.highways)
    lines.append("")

    for driver in (truck.driver for truck in data.trucks):
        lines.append(f"    (= (manual-capacity {driver}) {MANUAL_CAPACITY})")
    for package in data.packages:
        lines.append(f"    (= (package-weight {package.name}) {package.weight})")
    for truck in data.trucks:
        lines.extend(
            [
                f"    (= (truck-capacity {truck.name}) {truck.capacity})",
                f"    (= (truck-load {truck.name}) 0)",
                f"    (= (fuel-capacity {truck.name}) {truck.fuel_capacity})",
                f"    (= (fuel-level {truck.name}) {truck.initial_fuel})",
                f"    (= (refuel-cost {truck.name}) {truck.refuel_cost})",
                f"    (= (refuel-time {truck.name}) {truck.refuel_time})",
            ]
        )

    lines.append("")
    add_bidirectional_values(lines, "distance", data.distances)
    add_bidirectional_values(lines, "local-road-time", data.local_times)
    add_bidirectional_values(lines, "highway-time", data.highway_times)
    add_bidirectional_values(lines, "toll-cost", data.tolls)
    walk_times = {edge: math.ceil(data.local_times[edge] * 1.5) for edge in data.local_roads}
    loaded_walk_times = {
        edge: math.ceil(data.local_times[edge] * 2.0) for edge in data.local_roads
    }
    add_bidirectional_values(lines, "walk-time", walk_times)
    add_bidirectional_values(lines, "loaded-walk-time", loaded_walk_times)

    lines.extend(
        [
            "",
            f"    (= (budget) {data.budget})",
            "    (= (total-cost) 0)",
            "    (= (total-delivery-time) 0)",
            "  )",
            "",
            "  (:goal (and",
        ]
    )
    for package in data.packages:
        lines.append(f"    (at {package.name} {package.destination})")
    lines.extend(
        ["  ))", "", "  (:metric minimize (total-delivery-time))", ")", ""]
    )
    return "\n".join(lines)


def render_graph(data: ProblemData, output_path: Path, seed: int) -> None:
    graph = nx.Graph()
    graph.add_nodes_from(data.places)
    graph.add_edges_from(data.local_roads | data.highways)
    positions = nx.spring_layout(graph, seed=seed, k=1.2 / math.sqrt(NUM_PLACES))

    figure, axis = plt.subplots(figsize=(13, 9))
    axis.set_title(
        f"{data.problem_name}: numeric logistics environment",
        fontsize=16,
        fontweight="bold",
    )
    nx.draw_networkx_edges(
        graph,
        positions,
        edgelist=sorted(data.local_roads),
        edge_color="#6b7280",
        width=4.0,
        alpha=0.75,
        ax=axis,
    )
    nx.draw_networkx_edges(
        graph,
        positions,
        edgelist=sorted(data.highways),
        edge_color="#dc2626",
        width=2.2,
        style="dashed",
        alpha=0.95,
        ax=axis,
    )
    node_colors = [
        "#fbbf24" if place in data.fuel_stations else "#dbeafe"
        for place in data.places
    ]
    nx.draw_networkx_nodes(
        graph,
        positions,
        node_color=node_colors,
        edgecolors="#1f2937",
        node_size=2500,
        linewidths=1.5,
        ax=axis,
    )

    node_labels: dict[str, str] = {}
    for place in data.places:
        details = [place]
        if place in data.fuel_stations:
            details.append("FUEL")
        for truck in data.trucks:
            if truck.start == place:
                details.append(f"{truck.name}/{truck.driver}")
        origins = [p.name for p in data.packages if p.origin == place]
        goals = [p.name for p in data.packages if p.destination == place]
        if origins:
            details.append("start: " + ",".join(origins))
        if goals:
            details.append("goal: " + ",".join(goals))
        node_labels[place] = "\n".join(details)
    nx.draw_networkx_labels(graph, positions, labels=node_labels, font_size=8, ax=axis)

    edge_labels: dict[tuple[str, str], str] = {}
    for edge in sorted(data.local_roads | data.highways):
        labels = []
        if edge in data.local_roads:
            labels.append(f"L d{data.distances[edge]}/t{data.local_times[edge]}")
        if edge in data.highways:
            labels.append(
                f"H d{data.distances[edge]}/t{data.highway_times[edge]}"
                f"/USD{data.tolls[edge]}"
            )
        edge_labels[edge] = "\n".join(labels)
    nx.draw_networkx_edge_labels(
        graph,
        positions,
        edge_labels=edge_labels,
        font_size=7,
        rotate=False,
        bbox={"boxstyle": "round,pad=0.15", "fc": "white", "ec": "none", "alpha": 0.8},
        ax=axis,
    )

    package_summary = ", ".join(
        f"{p.name}:{p.origin}->{p.destination}(w={p.weight})"
        for p in data.packages
    )
    truck_summary = ", ".join(
        f"{t.name}(cap={t.capacity}, fuel={t.initial_fuel}/{t.fuel_capacity}, "
        f"refuel={t.refuel_cost})"
        for t in data.trucks
    )
    figure.text(
        0.02,
        0.02,
        f"budget={data.budget} | fuel stations={len(data.fuel_stations)}\n"
        f"{truck_summary}\n{package_summary}",
        fontsize=8,
        family="monospace",
        va="bottom",
    )
    axis.legend(
        handles=[
            Line2D([0], [0], color="#6b7280", lw=4, label="Local: slow/free/walkable"),
            Line2D([0], [0], color="#dc2626", lw=2, ls="--", label="Highway: fast/toll"),
            Line2D(
                [0],
                [0],
                marker="o",
                color="w",
                markerfacecolor="#fbbf24",
                markeredgecolor="#1f2937",
                markersize=12,
                label="Fuel station",
            ),
        ],
        loc="upper left",
    )
    axis.axis("off")
    figure.tight_layout(rect=(0, 0.10, 1, 1))
    figure.savefig(output_path, dpi=180, bbox_inches="tight")
    plt.close(figure)


def generate_problems() -> list[tuple[Path, Path]]:
    validate_configuration()
    INSTANCE_DIR.mkdir(parents=True, exist_ok=True)
    IMAGE_DIR.mkdir(parents=True, exist_ok=True)
    outputs: list[tuple[Path, Path]] = []
    for offset in range(NUM_PROBLEMS):
        problem_index = START_INDEX + offset
        data = generate_data(problem_index)
        stem = f"p{problem_index:03d}"
        problem_path = INSTANCE_DIR / f"{stem}.pddl"
        image_path = IMAGE_DIR / f"{stem}.png"
        problem_path.write_text(render_pddl(data), encoding="utf-8")
        render_graph(data, image_path, RANDOM_SEED + problem_index)
        outputs.append((problem_path, image_path))
        print(f"generated: {problem_path}")
        print(f"summary:   {image_path}")
    return outputs


def _facts(text: str, predicate: str, arity: int) -> list[tuple[str, ...]]:
    arguments = r"\s+([^\s()]+)" * arity
    pattern = re.compile(rf"\(\s*{re.escape(predicate)}{arguments}\s*\)", re.I)
    return [tuple(match.groups()) for match in pattern.finditer(text)]


def _numeric_values(text: str) -> dict[str, list[float]]:
    pattern = re.compile(
        r"\(=\s*\(\s*([\w-]+)(?:\s+[^()]*)?\)\s*"
        r"([-+]?\d+(?:\.\d+)?)\s*\)",
        re.I,
    )
    values: dict[str, list[float]] = {}
    for function, raw_value in pattern.findall(text):
        values.setdefault(function.lower(), []).append(float(raw_value))
    return values


def _undirected_count(edges: list[tuple[str, str]]) -> int:
    return len({tuple(sorted(edge)) for edge in edges})


def _format_number(value: float) -> str:
    return str(int(value)) if value.is_integer() else f"{value:g}"


def _format_range(values: list[float]) -> str:
    if not values:
        return "-"
    low, high = min(values), max(values)
    return _format_number(low) if low == high else f"{_format_number(low)}–{_format_number(high)}"


def parse_problem_summary(problem_path: Path) -> dict[str, str | int]:
    text = problem_path.read_text(encoding="utf-8")
    init_text, _, goal_text = text.partition("(:goal")
    packages = {args[0] for args in _facts(init_text, "package", 1)}
    trucks = {args[0] for args in _facts(init_text, "truck", 1)}
    places = {args[0] for args in _facts(init_text, "place", 1)}
    stations = {args[0] for args in _facts(init_text, "fuel-station", 1)}
    numeric = _numeric_values(init_text)

    initial_locations = {
        item: place
        for item, place in _facts(init_text, "at", 2)
        if item in packages
    }
    goal_locations = {
        item: place
        for item, place in _facts(goal_text, "at", 2)
        if item in packages
    }
    deliveries = ", ".join(
        f"{package}:{initial_locations.get(package, '?')}→{goal_locations.get(package, '?')}"
        for package in sorted(packages)
    )

    return {
        "problem": problem_path.stem,
        "packages": len(packages),
        "trucks": len(trucks),
        "places": len(places),
        "highways": _undirected_count(_facts(init_text, "highway", 2)),
        "local_roads": _undirected_count(_facts(init_text, "local-road", 2)),
        "stations": len(stations),
        "budget": _format_range(numeric.get("budget", [])),
        "package_weight": _format_range(numeric.get("package-weight", [])),
        "manual_capacity": _format_range(numeric.get("manual-capacity", [])),
        "truck_capacity": _format_range(numeric.get("truck-capacity", [])),
        "truck_load": _format_range(numeric.get("truck-load", [])),
        "fuel_level": _format_range(numeric.get("fuel-level", [])),
        "fuel_capacity": _format_range(numeric.get("fuel-capacity", [])),
        "toll": _format_range(numeric.get("toll-cost", [])),
        "highway_time": _format_range(numeric.get("highway-time", [])),
        "local_time": _format_range(numeric.get("local-road-time", [])),
        "deliveries": deliveries or "-",
    }


def render_problem_summary(rows: list[dict[str, str | int]]) -> str:
    lines = [
        SUMMARY_START,
        "## Problem 설정 요약",
        "",
        "> 이 구간은 `generate_problem.py --summarize`가 instances의 p001~pNNN을",
        "> 직접 파싱해 갱신한다. 수동으로 편집하지 않는다.",
        "",
        "### 환경 크기와 예산",
        "",
        "| Problem | Packages | Trucks | Places | Highways | Local roads | Fuel stations | Budget |",
        "|---|---:|---:|---:|---:|---:|---:|---:|",
    ]
    for row in rows:
        lines.append(
            f"| `{row['problem']}` | {row['packages']} | {row['trucks']} | "
            f"{row['places']} | {row['highways']} | {row['local_roads']} | "
            f"{row['stations']} | {row['budget']} |"
        )

    lines.extend(
        [
            "",
            "### Numeric 초기값 범위",
            "",
            "| Problem | Package kg | Manual kg | Truck capacity kg | Initial load kg | Fuel initial | Fuel capacity | Toll | Highway time | Local time |",
            "|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|",
        ]
    )
    for row in rows:
        lines.append(
            f"| `{row['problem']}` | {row['package_weight']} | "
            f"{row['manual_capacity']} | {row['truck_capacity']} | "
            f"{row['truck_load']} | {row['fuel_level']} | "
            f"{row['fuel_capacity']} | {row['toll']} | "
            f"{row['highway_time']} | {row['local_time']} |"
        )

    lines.extend(["", "### 배송 설정", ""])
    for row in rows:
        lines.append(f"- `{row['problem']}`: {row['deliveries']}")
    lines.extend(["", SUMMARY_END])
    return "\n".join(lines)


def summarize_problems() -> list[Path]:
    def problem_number(path: Path) -> int:
        match = re.fullmatch(r"p(\d+)\.pddl", path.name, re.I)
        return int(match.group(1)) if match else 10**9

    problem_paths = sorted(INSTANCE_DIR.glob("p*.pddl"), key=problem_number)
    if not problem_paths:
        raise FileNotFoundError(f"no pNNN.pddl files found in {INSTANCE_DIR}")
    rows = [parse_problem_summary(path) for path in problem_paths]
    generated = render_problem_summary(rows)
    readme = README_PATH.read_text(encoding="utf-8") if README_PATH.exists() else "# 02 Logistics\n"

    if SUMMARY_START in readme and SUMMARY_END in readme:
        before = readme.split(SUMMARY_START, 1)[0].rstrip()
        after = readme.split(SUMMARY_END, 1)[1].lstrip()
        readme = f"{before}\n\n{generated}\n"
        if after:
            readme += f"\n{after.rstrip()}\n"
    else:
        readme = f"{readme.rstrip()}\n\n{generated}\n"
    README_PATH.write_text(readme, encoding="utf-8")
    print(f"summarized {len(problem_paths)} problems: {README_PATH}")
    return problem_paths


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Generate logistics problems or summarize existing instances."
    )
    parser.add_argument(
        "--summarize",
        action="store_true",
        help="parse p001-pNNN and update the generated README summary",
    )
    args = parser.parse_args()
    if args.summarize:
        summarize_problems()
    else:
        generate_problems()


if __name__ == "__main__":
    main()
