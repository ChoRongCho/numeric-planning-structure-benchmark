#!/usr/bin/env python3
"""Generate numeric robotic-assembly p001-p004 instances and PNG summaries."""

from __future__ import annotations

import argparse
import os
import random
import re
from dataclasses import dataclass
from pathlib import Path

os.environ.setdefault("MPLCONFIGDIR", "/tmp/changmin-assembly-matplotlib")

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt
import networkx as nx


NUM_PROBLEMS = 4
START_INDEX = 1
RANDOM_SEED = 5306

INSPECTION_TIME = 2

BENCHMARK_PROFILES = {
    1: dict(parts=4, products=1, robots=1, tools=3, weight=(2, 8), work=(4, 8)),
    2: dict(parts=6, products=1, robots=1, tools=3, weight=(2, 9), work=(5, 10)),
    3: dict(parts=8, products=2, robots=2, tools=4, weight=(3, 10), work=(6, 12)),
    4: dict(parts=10, products=2, robots=2, tools=4, weight=(3, 12), work=(7, 15)),
}

TOOL_LIBRARY = [
    # name, work per operation, operation time, mount/unmount time
    ("precision-tool", 1, 2, 1),
    ("standard-tool", 3, 3, 2),
    ("power-tool", 5, 4, 3),
    ("high-torque-tool", 7, 5, 4),
]

DOMAIN_DIR = Path(__file__).resolve().parent
INSTANCE_DIR = DOMAIN_DIR / "instances"
IMAGE_DIR = DOMAIN_DIR / "images"
README_PATH = DOMAIN_DIR / "README.md"
SUMMARY_START = "<!-- AUTO-GENERATED-PROBLEM-SUMMARY:START -->"
SUMMARY_END = "<!-- AUTO-GENERATED-PROBLEM-SUMMARY:END -->"


@dataclass(frozen=True)
class Robot:
    name: str
    payload: int


@dataclass(frozen=True)
class Tool:
    name: str
    step: int
    operation_time: int
    change_time: int


@dataclass(frozen=True)
class Part:
    name: str
    product: str
    predecessor: str | None
    weight: int
    required_work: int
    pick_time: int
    place_time: int
    compatible_tools: tuple[str, ...]


@dataclass
class ProblemData:
    problem_name: str
    products: list[str]
    robots: list[Robot]
    tools: list[Tool]
    parts: list[Part]


def validate_profiles() -> None:
    for index in range(START_INDEX, START_INDEX + NUM_PROBLEMS):
        if index not in BENCHMARK_PROFILES:
            raise ValueError(f"missing profile for p{index:03d}")
        profile = BENCHMARK_PROFILES[index]
        if profile["parts"] < profile["products"]:
            raise ValueError("each product needs at least one part")
        if not 1 <= profile["tools"] <= len(TOOL_LIBRARY):
            raise ValueError("invalid tool count")
        if profile["robots"] not in (1, 2):
            raise ValueError("supported robot count is one or two")


def balanced_counts(total: int, groups: int) -> list[int]:
    base, remainder = divmod(total, groups)
    return [base + (1 if index < remainder else 0) for index in range(groups)]


def generate_data(problem_index: int) -> ProblemData:
    profile = BENCHMARK_PROFILES[problem_index]
    rng = random.Random(RANDOM_SEED + problem_index)
    products = [f"product{i + 1}" for i in range(profile["products"])]
    tools = [Tool(*spec) for spec in TOOL_LIBRARY[: profile["tools"]]]

    weight_min, weight_max = profile["weight"]
    if profile["robots"] == 1:
        robots = [Robot("robot1", weight_max)]
    else:
        robots = [
            Robot("robot1", max(weight_min, weight_max - 4)),
            Robot("robot2", weight_max),
        ]

    parts: list[Part] = []
    part_number = 1
    work_min, work_max = profile["work"]
    fast_tools = tools[1:]
    for product, count in zip(products, balanced_counts(profile["parts"], profile["products"])):
        product_parts: list[str] = []
        for local_index in range(count):
            name = f"part{part_number:02d}"
            predecessor = None if local_index == 0 else rng.choice(product_parts)
            fast_tool = rng.choice(fast_tools)
            compatible = (tools[0].name, fast_tool.name)
            parts.append(
                Part(
                    name=name,
                    product=product,
                    predecessor=predecessor,
                    weight=rng.randint(weight_min, weight_max),
                    required_work=rng.randint(work_min, work_max),
                    pick_time=rng.randint(2, 4),
                    place_time=rng.randint(3, 6),
                    compatible_tools=compatible,
                )
            )
            product_parts.append(name)
            part_number += 1

    return ProblemData(
        problem_name=f"numeric-assembly-p{problem_index:03d}",
        products=products,
        robots=robots,
        tools=tools,
        parts=parts,
    )


def render_pddl(data: ProblemData) -> str:
    lines = [
        f"(define (problem {data.problem_name}) (:domain numeric-robot-assembly)",
        "  (:objects",
        f"    {' '.join(robot.name for robot in data.robots)} - robot",
        f"    {' '.join(part.name for part in data.parts)} - part",
        f"    {' '.join(data.products)} - product",
        f"    {' '.join(tool.name for tool in data.tools)} - tool",
        "  )",
        "",
        "  (:init",
    ]
    for robot in data.robots:
        lines.extend(
            [
                f"    (handempty {robot.name})",
                f"    (tool-slot-empty {robot.name})",
                f"    (= (robot-payload {robot.name}) {robot.payload})",
            ]
        )
    for tool in data.tools:
        lines.extend(
            [
                f"    (tool-available {tool.name})",
                f"    (= (tool-work-step {tool.name}) {tool.step})",
                f"    (= (tool-operation-time {tool.name}) {tool.operation_time})",
                f"    (= (tool-change-time {tool.name}) {tool.change_time})",
            ]
        )
    for part in data.parts:
        lines.extend(
            [
                f"    (part-available {part.name})",
                f"    (unfinished {part.name})",
                f"    (part-of {part.name} {part.product})",
            ]
        )
        if part.predecessor is None:
            lines.append(f"    (first-part {part.name} {part.product})")
        else:
            lines.append(
                f"    (predecessor {part.predecessor} {part.name} {part.product})"
            )
        for tool in part.compatible_tools:
            lines.append(f"    (compatible {tool} {part.name})")
        lines.extend(
            [
                f"    (= (part-weight {part.name}) {part.weight})",
                f"    (= (required-work {part.name}) {part.required_work})",
                f"    (= (completed-work {part.name}) 0)",
                f"    (= (pick-time {part.name}) {part.pick_time})",
                f"    (= (place-time {part.name}) {part.place_time})",
            ]
        )
    lines.extend(
        [
            f"    (= (inspection-time) {INSPECTION_TIME})",
            "    (= (total-assembly-time) 0)",
            "  )",
            "",
            "  (:goal (and",
        ]
    )
    for part in data.parts:
        lines.append(f"    (fastened {part.name} {part.product})")
    for robot in data.robots:
        lines.append(f"    (handempty {robot.name})")
        lines.append(f"    (tool-slot-empty {robot.name})")
    for tool in data.tools:
        lines.append(f"    (tool-available {tool.name})")
    lines.extend(
        [
            "  ))",
            "",
            "  (:metric minimize (total-assembly-time))",
            ")",
            "",
        ]
    )
    return "\n".join(lines)


def render_image(data: ProblemData, output_path: Path, seed: int) -> None:
    figure, (graph_axis, table_axis) = plt.subplots(
        1, 2, figsize=(16, 9), gridspec_kw={"width_ratios": [1.15, 1.0]}
    )
    figure.suptitle(
        f"{data.problem_name} | parts={len(data.parts)} | "
        f"robots={len(data.robots)} | tools={len(data.tools)}",
        fontsize=16,
        fontweight="bold",
    )

    graph = nx.DiGraph()
    for part in data.parts:
        graph.add_node(part.name)
        if part.predecessor:
            graph.add_edge(part.predecessor, part.name)
    positions = nx.spring_layout(graph, seed=seed)
    product_colors = {
        product: color
        for product, color in zip(data.products, ["#93c5fd", "#fca5a5", "#86efac"])
    }
    part_by_name = {part.name: part for part in data.parts}
    colors = [product_colors[part_by_name[name].product] for name in graph.nodes]
    labels = {
        part.name: f"{part.name}\nw={part.weight}, work={part.required_work}"
        for part in data.parts
    }
    nx.draw_networkx_nodes(
        graph, positions, node_color=colors, node_size=2800,
        edgecolors="#1e293b", ax=graph_axis,
    )
    nx.draw_networkx_edges(
        graph, positions, arrows=True, arrowsize=22, width=2.3,
        edge_color="#64748b", ax=graph_axis,
    )
    nx.draw_networkx_labels(graph, positions, labels=labels, font_size=8, ax=graph_axis)
    graph_axis.set_title("Assembly precedence graph")
    graph_axis.axis("off")

    table_axis.axis("off")
    table_axis.set_title("Robots, tools, and compatibility")
    robot_lines = [f"{robot.name}: payload={robot.payload}" for robot in data.robots]
    tool_lines = [
        f"{tool.name}: step={tool.step}, op={tool.operation_time}, change={tool.change_time}"
        for tool in data.tools
    ]
    part_lines = [
        f"{part.name}: {','.join(part.compatible_tools)}"
        for part in data.parts
    ]
    table_axis.text(
        0.02, 0.96,
        "ROBOTS\n" + "\n".join(robot_lines)
        + "\n\nTOOLS\n" + "\n".join(tool_lines)
        + "\n\nPART -> COMPATIBLE TOOLS\n" + "\n".join(part_lines),
        va="top", fontsize=9.5, family="monospace", transform=table_axis.transAxes,
        bbox=dict(boxstyle="round,pad=0.7", facecolor="#f8fafc", edgecolor="#475569"),
    )
    figure.tight_layout()
    figure.savefig(output_path, dpi=170, bbox_inches="tight")
    plt.close(figure)


def parse_problem(path: Path) -> dict[str, int | str]:
    text = path.read_text(encoding="utf-8")
    objects = text.split("(:objects", 1)[1].split("(:init", 1)[0]

    def count_type(type_name: str) -> int:
        match = re.search(rf"\n\s+(.+?)\s+- {type_name}\b", objects)
        return len(match.group(1).split()) if match else 0

    weights = [int(value) for value in re.findall(r"part-weight [^)]+\) (\d+)\)", text)]
    works = [int(value) for value in re.findall(r"required-work [^)]+\) (\d+)\)", text)]
    payloads = [int(value) for value in re.findall(r"robot-payload [^)]+\) (\d+)\)", text)]
    return {
        "name": path.stem,
        "parts": count_type("part"),
        "products": count_type("product"),
        "robots": count_type("robot"),
        "tools": count_type("tool"),
        "weight": f"{min(weights)}–{max(weights)}" if weights else "-",
        "work": f"{min(works)}–{max(works)}" if works else "-",
        "payload": f"{min(payloads)}–{max(payloads)}" if payloads else "-",
    }


def update_readme_summary() -> None:
    rows = [parse_problem(path) for path in sorted(INSTANCE_DIR.glob("p[0-9][0-9][0-9].pddl"))]
    lines = [
        SUMMARY_START,
        "## 생성된 문제 요약",
        "",
        "| Problem | Parts | Products | Robots | Tools | Part weight | Required work | Payload |",
        "|---|---:|---:|---:|---:|---:|---:|---:|",
    ]
    for row in rows:
        lines.append(
            f"| `{row['name']}` | {row['parts']} | {row['products']} | "
            f"{row['robots']} | {row['tools']} | {row['weight']} | "
            f"{row['work']} | {row['payload']} |"
        )
    lines.extend(["", SUMMARY_END])
    replacement = "\n".join(lines)
    current = README_PATH.read_text(encoding="utf-8")
    pattern = re.compile(re.escape(SUMMARY_START) + r".*?" + re.escape(SUMMARY_END), re.DOTALL)
    if pattern.search(current):
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

    validate_profiles()
    INSTANCE_DIR.mkdir(parents=True, exist_ok=True)
    IMAGE_DIR.mkdir(parents=True, exist_ok=True)
    for problem_index in range(START_INDEX, START_INDEX + NUM_PROBLEMS):
        data = generate_data(problem_index)
        problem_path = INSTANCE_DIR / f"p{problem_index:03d}.pddl"
        image_path = IMAGE_DIR / f"p{problem_index:03d}.png"
        problem_path.write_text(render_pddl(data), encoding="utf-8")
        render_image(data, image_path, RANDOM_SEED + problem_index)
        print(f"generated {problem_path}")
        print(f"generated {image_path}")


if __name__ == "__main__":
    main()
