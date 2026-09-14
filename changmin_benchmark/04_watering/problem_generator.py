#!/usr/bin/env python3
"""Generate solvable robotic-watering PDDL problems and PNG summaries.

Edit the global configuration below, then run this file. Each generated
instances/pNNN.pddl has a matching images/pNNN.png environment summary.
"""

from __future__ import annotations

import argparse
import math
import os
import random
import re
from dataclasses import dataclass
from pathlib import Path

os.environ.setdefault("MPLCONFIGDIR", "/tmp/changmin-watering-matplotlib")

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt
import networkx as nx


# ---------------------------------------------------------------------------
# Global generator configuration: edit these values.
# ---------------------------------------------------------------------------

NUM_PROBLEMS = 4
START_INDEX = 1
USE_BENCHMARK_PROFILES = True

NUM_PLANTS = 3
NUM_LOCATIONS = 5  # Includes base.
NUM_EXTRA_CONNECTIONS = 2  # Added after a connected spanning tree.
NUM_TAPS = 1
NUM_CHARGING_STATIONS = 2  # Includes base.
COLOCATE_TAPS_AND_CHARGERS = False

RANDOM_SEED = 5304
MIN_PLANT_DEMAND = 2
MAX_PLANT_DEMAND = 5
MIN_EDGE_DISTANCE = 3
MAX_EDGE_DISTANCE = 10

# Capacity relative to total demand. The generator still guarantees that the
# largest individual plant can be served after a full refill.
WATER_CAPACITY_RATIO = 0.60

# Multiplier over a conservative energy capacity that permits a base round
# trip to any one location. 1.0 is tight; 1.3+ is progressively looser.
BATTERY_CAPACITY_FACTOR = 1.30

# Reproducible p001-p004 progression. These values override the corresponding
# globals above when USE_BENCHMARK_PROFILES is True.
BENCHMARK_PROFILES = {
    1: dict(
        plants=3, locations=5, extra_connections=2, taps=1, chargers=2,
        min_demand=2, max_demand=5, water_ratio=0.60, battery_factor=1.30,
    ),
    2: dict(
        plants=4, locations=6, extra_connections=3, taps=1, chargers=2,
        min_demand=2, max_demand=5, water_ratio=0.50, battery_factor=1.25,
    ),
    3: dict(
        plants=5, locations=7, extra_connections=3, taps=1, chargers=2,
        min_demand=2, max_demand=6, water_ratio=0.40, battery_factor=1.15,
    ),
    4: dict(
        plants=6, locations=8, extra_connections=4, taps=2, chargers=2,
        min_demand=3, max_demand=6, water_ratio=0.30, battery_factor=1.05,
    ),
}

PICK_TIME = 1
DROP_TIME = 1
FILL_TIME = 6
WATERING_UNIT_TIME = 2
CHARGE_TIME = 15

PICK_ENERGY = 1
DROP_ENERGY = 1
FILL_ENERGY = 2
WATERING_UNIT_ENERGY = 1

DOMAIN_DIR = Path(__file__).resolve().parent
INSTANCE_DIR = DOMAIN_DIR / "instances"
IMAGE_DIR = DOMAIN_DIR / "images"
README_PATH = DOMAIN_DIR / "README.md"
SUMMARY_START = "<!-- AUTO-GENERATED-PROBLEM-SUMMARY:START -->"
SUMMARY_END = "<!-- AUTO-GENERATED-PROBLEM-SUMMARY:END -->"


@dataclass(frozen=True)
class Plant:
    name: str
    location: str
    demand: int


@dataclass
class ProblemData:
    problem_name: str
    locations: list[str]
    edges: set[tuple[str, str]]
    distances: dict[tuple[str, str], int]
    move_times: dict[tuple[str, str], int]
    plants: list[Plant]
    taps: set[str]
    stations: set[str]
    water_capacity: int
    battery_capacity: int


def apply_benchmark_profile(problem_index: int) -> None:
    global NUM_PLANTS, NUM_LOCATIONS, NUM_EXTRA_CONNECTIONS
    global NUM_TAPS, NUM_CHARGING_STATIONS
    global MIN_PLANT_DEMAND, MAX_PLANT_DEMAND
    global WATER_CAPACITY_RATIO, BATTERY_CAPACITY_FACTOR

    try:
        profile = BENCHMARK_PROFILES[problem_index]
    except KeyError as error:
        raise ValueError(
            f"no BENCHMARK_PROFILES entry for p{problem_index:03d}"
        ) from error
    NUM_PLANTS = profile["plants"]
    NUM_LOCATIONS = profile["locations"]
    NUM_EXTRA_CONNECTIONS = profile["extra_connections"]
    NUM_TAPS = profile["taps"]
    NUM_CHARGING_STATIONS = profile["chargers"]
    MIN_PLANT_DEMAND = profile["min_demand"]
    MAX_PLANT_DEMAND = profile["max_demand"]
    WATER_CAPACITY_RATIO = profile["water_ratio"]
    BATTERY_CAPACITY_FACTOR = profile["battery_factor"]


def canonical_edge(a: str, b: str) -> tuple[str, str]:
    return (a, b) if a < b else (b, a)


def validate_configuration() -> None:
    if NUM_PROBLEMS < 1 or START_INDEX < 1:
        raise ValueError("NUM_PROBLEMS and START_INDEX must be positive")
    if NUM_PLANTS < 1:
        raise ValueError("NUM_PLANTS must be positive")
    if NUM_LOCATIONS < 3:
        raise ValueError("NUM_LOCATIONS must be at least 3")
    max_edges = NUM_LOCATIONS * (NUM_LOCATIONS - 1) // 2
    if not 0 <= NUM_EXTRA_CONNECTIONS <= max_edges - (NUM_LOCATIONS - 1):
        raise ValueError("NUM_EXTRA_CONNECTIONS is outside the valid range")
    if not 1 <= NUM_TAPS < NUM_LOCATIONS:
        raise ValueError("NUM_TAPS must be in [1, NUM_LOCATIONS - 1]")
    if not 1 <= NUM_CHARGING_STATIONS <= NUM_LOCATIONS:
        raise ValueError("NUM_CHARGING_STATIONS must be in [1, NUM_LOCATIONS]")
    if (
        not COLOCATE_TAPS_AND_CHARGERS
        and NUM_CHARGING_STATIONS - 1 > NUM_LOCATIONS - 1 - NUM_TAPS
    ):
        raise ValueError(
            "not enough non-tap locations for separated charging stations"
        )
    if MIN_PLANT_DEMAND < 1 or MAX_PLANT_DEMAND < MIN_PLANT_DEMAND:
        raise ValueError("plant demand range is invalid")
    if MIN_EDGE_DISTANCE < 1 or MAX_EDGE_DISTANCE < MIN_EDGE_DISTANCE:
        raise ValueError("edge distance range is invalid")
    if not 0.0 < WATER_CAPACITY_RATIO <= 1.0:
        raise ValueError("WATER_CAPACITY_RATIO must be in (0, 1]")
    if BATTERY_CAPACITY_FACTOR < 1.0:
        raise ValueError("BATTERY_CAPACITY_FACTOR must be at least 1.0")


def sample_connected_edges(
    locations: list[str], extra_count: int, rng: random.Random
) -> set[tuple[str, str]]:
    order = locations.copy()
    rng.shuffle(order)
    edges: set[tuple[str, str]] = set()
    for index in range(1, len(order)):
        edges.add(canonical_edge(order[index], rng.choice(order[:index])))
    candidates = [
        canonical_edge(a, b)
        for index, a in enumerate(locations)
        for b in locations[index + 1 :]
        if canonical_edge(a, b) not in edges
    ]
    rng.shuffle(candidates)
    edges.update(candidates[:extra_count])
    return edges


def generate_data(problem_index: int) -> ProblemData:
    rng = random.Random(RANDOM_SEED + problem_index)
    locations = ["base"] + [f"zone{i}" for i in range(1, NUM_LOCATIONS)]
    edges = sample_connected_edges(locations, NUM_EXTRA_CONNECTIONS, rng)
    distances = {edge: rng.randint(MIN_EDGE_DISTANCE, MAX_EDGE_DISTANCE) for edge in edges}
    move_times = {edge: distance + rng.randint(1, 4) for edge, distance in distances.items()}

    service_locations = locations[1:]
    plants = [
        Plant(
            name=f"plant{index + 1}",
            location=rng.choice(service_locations),
            demand=rng.randint(MIN_PLANT_DEMAND, MAX_PLANT_DEMAND),
        )
        for index in range(NUM_PLANTS)
    ]

    taps = set(rng.sample(service_locations, NUM_TAPS))
    station_candidates = (
        service_locations.copy()
        if COLOCATE_TAPS_AND_CHARGERS
        else [location for location in service_locations if location not in taps]
    )
    rng.shuffle(station_candidates)
    stations = {"base"}
    stations.update(station_candidates[: NUM_CHARGING_STATIONS - 1])

    total_demand = sum(plant.demand for plant in plants)
    water_capacity = max(
        max(plant.demand for plant in plants),
        math.ceil(total_demand * WATER_CAPACITY_RATIO),
    )
    if total_demand > 1:
        water_capacity = min(water_capacity, total_demand - 1)

    graph = nx.Graph()
    for edge, distance in distances.items():
        graph.add_edge(*edge, weight=distance)
    from_base = nx.single_source_dijkstra_path_length(graph, "base", weight="weight")
    farthest_energy = max(from_base.values())
    service_round_trip = (
        2 * farthest_energy
        + MAX_PLANT_DEMAND * WATERING_UNIT_ENERGY
        + PICK_ENERGY
        + DROP_ENERGY
    )
    refill_round_trip = (
        2 * farthest_energy + PICK_ENERGY + FILL_ENERGY + DROP_ENERGY
    )
    safe_capacity = max(service_round_trip, refill_round_trip)
    battery_capacity = math.ceil(safe_capacity * BATTERY_CAPACITY_FACTOR)

    return ProblemData(
        problem_name=f"robotic-watering-p{problem_index:03d}",
        locations=locations,
        edges=edges,
        distances=distances,
        move_times=move_times,
        plants=plants,
        taps=taps,
        stations=stations,
        water_capacity=water_capacity,
        battery_capacity=battery_capacity,
    )


def render_pddl(data: ProblemData) -> str:
    lines = [
        f"(define (problem {data.problem_name}) (:domain robotic-watering)",
        "  (:objects",
        "    robot1 - robot",
        "    watering-can1 - container",
        f"    {' '.join(plant.name for plant in data.plants)} - plant",
        f"    {' '.join(data.locations)} - location",
        "  )",
        "",
        "  (:init",
        "    (at-robot robot1 base)",
        "    (container-at watering-can1 base)",
        "    (hand-free robot1)",
        "    (home base)",
    ]
    for tap in sorted(data.taps):
        lines.append(f"    (tap {tap})")
    for station in sorted(data.stations):
        lines.append(f"    (charging-station {station})")
    for plant in data.plants:
        lines.append(f"    (plant-at {plant.name} {plant.location})")
    for a, b in sorted(data.edges):
        lines.append(f"    (connected {a} {b}) (connected {b} {a})")
        lines.append(
            f"    (= (move-energy {a} {b}) {data.distances[(a, b)]}) "
            f"(= (move-energy {b} {a}) {data.distances[(a, b)]})"
        )
        lines.append(
            f"    (= (move-time {a} {b}) {data.move_times[(a, b)]}) "
            f"(= (move-time {b} {a}) {data.move_times[(a, b)]})"
        )
    lines.extend(
        [
            f"    (= (battery-capacity robot1) {data.battery_capacity})",
            f"    (= (battery-level robot1) {data.battery_capacity})",
            f"    (= (container-capacity watering-can1) {data.water_capacity})",
            "    (= (water-level watering-can1) 0)",
        ]
    )
    for plant in data.plants:
        lines.append(f"    (= (plant-demand {plant.name}) {plant.demand})")
        lines.append(f"    (= (watered-amount {plant.name}) 0)")
    lines.extend(
        [
            f"    (= (pick-time) {PICK_TIME})",
            f"    (= (drop-time) {DROP_TIME})",
            f"    (= (fill-time) {FILL_TIME})",
            f"    (= (watering-unit-time) {WATERING_UNIT_TIME})",
            f"    (= (charge-time) {CHARGE_TIME})",
            f"    (= (pick-energy) {PICK_ENERGY})",
            f"    (= (drop-energy) {DROP_ENERGY})",
            f"    (= (fill-energy) {FILL_ENERGY})",
            f"    (= (watering-unit-energy) {WATERING_UNIT_ENERGY})",
            "    (= (total-watering-time) 0)",
            "  )",
            "",
            "  (:goal (and",
            "    (at-robot robot1 base)",
            "    (container-at watering-can1 base)",
            "    (hand-free robot1)",
        ]
    )
    for plant in data.plants:
        lines.append(
            f"    (>= (watered-amount {plant.name}) (plant-demand {plant.name}))"
        )
    lines.extend(
        [
            "  ))",
            "",
            "  (:metric minimize (total-watering-time))",
            ")",
            "",
        ]
    )
    return "\n".join(lines)


def render_graph(data: ProblemData, output_path: Path, seed: int) -> None:
    graph = nx.Graph()
    graph.add_nodes_from(data.locations)
    graph.add_edges_from(data.edges)
    positions = nx.spring_layout(graph, seed=seed)

    figure, axis = plt.subplots(figsize=(13, 9))
    node_colors = []
    for location in data.locations:
        if location == "base":
            node_colors.append("#fbbf24")
        elif location in data.taps and location in data.stations:
            node_colors.append("#a78bfa")
        elif location in data.taps:
            node_colors.append("#60a5fa")
        elif location in data.stations:
            node_colors.append("#4ade80")
        else:
            node_colors.append("#e2e8f0")
    nx.draw_networkx_nodes(
        graph, positions, node_color=node_colors, node_size=3000,
        edgecolors="#1e293b", ax=axis
    )
    nx.draw_networkx_edges(graph, positions, width=2.5, edge_color="#64748b", ax=axis)

    labels: dict[str, str] = {}
    for location in data.locations:
        details = [location]
        if location == "base":
            details.append("HOME + CHARGE")
        else:
            if location in data.taps:
                details.append("TAP")
            if location in data.stations:
                details.append("CHARGE")
        located = [f"{plant.name}(d={plant.demand})" for plant in data.plants if plant.location == location]
        details.extend(located)
        labels[location] = "\n".join(details)
    nx.draw_networkx_labels(graph, positions, labels=labels, font_size=8, ax=axis)
    edge_labels = {
        edge: f"e={data.distances[edge]} / t={data.move_times[edge]}"
        for edge in data.edges
    }
    nx.draw_networkx_edge_labels(graph, positions, edge_labels=edge_labels, font_size=7, ax=axis)
    total_demand = sum(plant.demand for plant in data.plants)
    figure.suptitle(
        f"{data.problem_name} | water={data.water_capacity}/{total_demand} "
        f"| battery={data.battery_capacity} | taps={len(data.taps)} "
        f"| chargers={len(data.stations)}",
        fontsize=14,
        fontweight="bold",
    )
    axis.axis("off")
    figure.tight_layout()
    figure.savefig(output_path, dpi=170, bbox_inches="tight")
    plt.close(figure)


def parse_summary(problem_path: Path) -> dict[str, int | str]:
    text = problem_path.read_text(encoding="utf-8")
    objects = text.split("(:objects", 1)[1].split("(:init", 1)[0]
    plants = re.findall(r"\bplant\d+\b", objects)
    locations_match = re.search(r"\n\s+(.+?)\s+- location", objects)
    locations = locations_match.group(1).split() if locations_match else []
    demands = [int(value) for value in re.findall(r"plant-demand [^)]+\) (\d+)\)", text)]
    water = re.search(r"container-capacity [^)]+\) (\d+)\)", text)
    battery = re.search(r"battery-capacity [^)]+\) (\d+)\)", text)
    return {
        "name": problem_path.stem,
        "plants": len(set(plants)),
        "locations": len(locations),
        "taps": len(re.findall(r"^\s*\(tap ", text, re.MULTILINE)),
        "stations": len(re.findall(r"^\s*\(charging-station ", text, re.MULTILINE)),
        "demand": sum(demands),
        "water": int(water.group(1)) if water else 0,
        "battery": int(battery.group(1)) if battery else 0,
    }


def update_readme_summary() -> None:
    rows = [parse_summary(path) for path in sorted(INSTANCE_DIR.glob("p[0-9][0-9][0-9].pddl"))]
    table = [
        SUMMARY_START,
        "## 생성된 문제 요약",
        "",
        "| Problem | Plants | Locations | Taps | Chargers | Total demand | Water capacity | Battery capacity |",
        "|---|---:|---:|---:|---:|---:|---:|---:|",
    ]
    for row in rows:
        table.append(
            f"| `{row['name']}` | {row['plants']} | {row['locations']} | "
            f"{row['taps']} | {row['stations']} | {row['demand']} | "
            f"{row['water']} | {row['battery']} |"
        )
    table.extend(["", SUMMARY_END])
    replacement = "\n".join(table)
    current = README_PATH.read_text(encoding="utf-8")
    if SUMMARY_START in current and SUMMARY_END in current:
        pattern = re.compile(re.escape(SUMMARY_START) + r".*?" + re.escape(SUMMARY_END), re.DOTALL)
        current = pattern.sub(replacement, current)
    else:
        current = current.rstrip() + "\n\n" + replacement + "\n"
    README_PATH.write_text(current, encoding="utf-8")


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--summarize", action="store_true",
        help="parse p001-pNNN and refresh the README summary table",
    )
    args = parser.parse_args()
    if args.summarize:
        update_readme_summary()
        print(f"updated {README_PATH}")
        return

    INSTANCE_DIR.mkdir(parents=True, exist_ok=True)
    IMAGE_DIR.mkdir(parents=True, exist_ok=True)
    for problem_index in range(START_INDEX, START_INDEX + NUM_PROBLEMS):
        if USE_BENCHMARK_PROFILES:
            apply_benchmark_profile(problem_index)
        validate_configuration()
        data = generate_data(problem_index)
        pddl_path = INSTANCE_DIR / f"p{problem_index:03d}.pddl"
        image_path = IMAGE_DIR / f"p{problem_index:03d}.png"
        pddl_path.write_text(render_pddl(data), encoding="utf-8")
        render_graph(data, image_path, RANDOM_SEED + problem_index)
        print(f"generated {pddl_path}")
        print(f"generated {image_path}")


if __name__ == "__main__":
    main()
