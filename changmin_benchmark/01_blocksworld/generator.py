#!/usr/bin/env python3
"""Generate reproducible Blocksworld p001-p004 instances and PNG summaries."""

from __future__ import annotations

import argparse
import os
import random
import re
from dataclasses import dataclass
from pathlib import Path

os.environ.setdefault("MPLCONFIGDIR", "/tmp/changmin-blocksworld-matplotlib")

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.patches import Rectangle


NUM_PROBLEMS = 4
START_INDEX = 1
RANDOM_SEED = 5301

# Number of nonempty stacks in the initial and goal configurations.
BENCHMARK_PROFILES = {
    1: dict(blocks=3, tables=3, initial_stacks=1, goal_stacks=1),
    2: dict(blocks=5, tables=3, initial_stacks=2, goal_stacks=2),
    3: dict(blocks=7, tables=3, initial_stacks=3, goal_stacks=2),
    4: dict(blocks=9, tables=3, initial_stacks=3, goal_stacks=3),
}

DOMAIN_DIR = Path(__file__).resolve().parent
INSTANCE_DIR = DOMAIN_DIR / "instances"
IMAGE_DIR = DOMAIN_DIR / "images"
README_PATH = DOMAIN_DIR / "README.md"
SUMMARY_START = "<!-- AUTO-GENERATED-PROBLEM-SUMMARY:START -->"
SUMMARY_END = "<!-- AUTO-GENERATED-PROBLEM-SUMMARY:END -->"


@dataclass
class ProblemData:
    problem_name: str
    blocks: list[str]
    tables: list[str]
    initial: dict[str, list[str]]
    goal: dict[str, list[str]]


def validate_profiles() -> None:
    for index in range(START_INDEX, START_INDEX + NUM_PROBLEMS):
        if index not in BENCHMARK_PROFILES:
            raise ValueError(f"missing benchmark profile for p{index:03d}")
        profile = BENCHMARK_PROFILES[index]
        if profile["blocks"] < 2 or profile["tables"] < 2:
            raise ValueError("each problem needs at least two blocks and tables")
        for key in ("initial_stacks", "goal_stacks"):
            if not 1 <= profile[key] <= min(profile["blocks"], profile["tables"]):
                raise ValueError(f"invalid {key} in p{index:03d}")


def random_configuration(
    blocks: list[str], tables: list[str], stack_count: int, rng: random.Random
) -> dict[str, list[str]]:
    shuffled_blocks = blocks.copy()
    rng.shuffle(shuffled_blocks)
    selected_tables = rng.sample(tables, stack_count)

    # Positive composition of len(blocks) into stack_count parts.
    if stack_count == 1:
        sizes = [len(blocks)]
    else:
        cuts = sorted(rng.sample(range(1, len(blocks)), stack_count - 1))
        boundaries = [0, *cuts, len(blocks)]
        sizes = [boundaries[index + 1] - boundaries[index] for index in range(stack_count)]

    configuration = {table: [] for table in tables}
    offset = 0
    for table, size in zip(selected_tables, sizes):
        # A stack is stored bottom-to-top.
        configuration[table] = shuffled_blocks[offset : offset + size]
        offset += size
    return configuration


def signature(configuration: dict[str, list[str]], tables: list[str]) -> tuple[tuple[str, ...], ...]:
    return tuple(tuple(configuration[table]) for table in tables)


def generate_data(problem_index: int) -> ProblemData:
    profile = BENCHMARK_PROFILES[problem_index]
    rng = random.Random(RANDOM_SEED + problem_index)
    blocks = [f"b{i + 1}" for i in range(profile["blocks"])]
    tables = [f"table{i + 1}" for i in range(profile["tables"])]
    initial = random_configuration(blocks, tables, profile["initial_stacks"], rng)

    for _ in range(100):
        goal = random_configuration(blocks, tables, profile["goal_stacks"], rng)
        if signature(goal, tables) != signature(initial, tables):
            break
    else:
        raise RuntimeError("could not sample a goal different from the initial state")

    return ProblemData(
        problem_name=f"blocksworld-p{problem_index:03d}",
        blocks=blocks,
        tables=tables,
        initial=initial,
        goal=goal,
    )


def configuration_facts(configuration: dict[str, list[str]], tables: list[str]) -> list[str]:
    facts: list[str] = []
    for table in tables:
        stack = configuration[table]
        if not stack:
            facts.append(f"(clear {table})")
            continue
        facts.append(f"(on-table {stack[0]} {table})")
        for lower, upper in zip(stack, stack[1:]):
            facts.append(f"(on {upper} {lower})")
        facts.append(f"(clear {stack[-1]})")
    return facts


def render_pddl(data: ProblemData) -> str:
    lines = [
        f"(define (problem {data.problem_name})",
        "  (:domain blocksworld)",
        "",
        "  (:objects",
        f"    {' '.join(data.blocks)}",
        f"    {' '.join(data.tables)}",
        "  )",
        "",
        "  (:init",
    ]
    lines.extend(f"    (block {block})" for block in data.blocks)
    lines.extend(f"    (table {table})" for table in data.tables)
    lines.append("    (handempty)")
    lines.extend(f"    {fact}" for fact in configuration_facts(data.initial, data.tables))
    lines.extend(
        [
            "    (= (total-cost) 0)",
            "  )",
            "",
            "  (:goal (and",
            "    (handempty)",
        ]
    )
    lines.extend(f"    {fact}" for fact in configuration_facts(data.goal, data.tables))
    lines.extend(
        [
            "  ))",
            "",
            "  (:metric minimize (total-cost))",
            ")",
            "",
        ]
    )
    return "\n".join(lines)


def draw_configuration(
    axis: plt.Axes,
    configuration: dict[str, list[str]],
    tables: list[str],
    title: str,
) -> None:
    axis.set_title(title, fontsize=14, fontweight="bold")
    max_height = max(len(stack) for stack in configuration.values())
    colors = plt.cm.Set3.colors
    for table_index, table in enumerate(tables):
        x = table_index * 2.2
        axis.plot([x - 0.75, x + 0.75], [0, 0], color="#334155", linewidth=5)
        axis.text(x, -0.35, table, ha="center", va="top", fontsize=10)
        for level, block in enumerate(configuration[table]):
            rectangle = Rectangle(
                (x - 0.6, level * 0.72 + 0.08), 1.2, 0.58,
                facecolor=colors[(int(block[1:]) - 1) % len(colors)],
                edgecolor="#1e293b", linewidth=1.5,
            )
            axis.add_patch(rectangle)
            axis.text(x, level * 0.72 + 0.37, block, ha="center", va="center", fontsize=10)
    axis.set_xlim(-1.2, (len(tables) - 1) * 2.2 + 1.2)
    axis.set_ylim(-0.7, max_height * 0.72 + 1.0)
    axis.axis("off")


def render_image(data: ProblemData, output_path: Path) -> None:
    figure, (initial_axis, goal_axis) = plt.subplots(1, 2, figsize=(14, 7))
    figure.suptitle(
        f"{data.problem_name} | blocks={len(data.blocks)} | tables={len(data.tables)}",
        fontsize=16,
        fontweight="bold",
    )
    draw_configuration(initial_axis, data.initial, data.tables, "Initial configuration")
    draw_configuration(goal_axis, data.goal, data.tables, "Goal configuration")
    figure.tight_layout()
    figure.savefig(output_path, dpi=170, bbox_inches="tight")
    plt.close(figure)


def parse_problem(path: Path) -> dict[str, int | str]:
    text = path.read_text(encoding="utf-8")
    init_text = text.split("(:init", 1)[1].split("(:goal", 1)[0]
    goal_text = text.split("(:goal", 1)[1].split("(:metric", 1)[0]
    return {
        "name": path.stem,
        "blocks": len(re.findall(r"^\s*\(block ", init_text, re.MULTILINE)),
        "tables": len(re.findall(r"^\s*\(table ", init_text, re.MULTILINE)),
        "initial_stacks": len(re.findall(r"^\s*\(on-table ", init_text, re.MULTILINE)),
        "goal_stacks": len(re.findall(r"^\s*\(on-table ", goal_text, re.MULTILINE)),
    }


def update_readme_summary() -> None:
    rows = [parse_problem(path) for path in sorted(INSTANCE_DIR.glob("p[0-9][0-9][0-9].pddl"))]
    lines = [
        SUMMARY_START,
        "## 생성된 문제 요약",
        "",
        "| Problem | Blocks | Tables | Initial stacks | Goal stacks |",
        "|---|---:|---:|---:|---:|",
    ]
    for row in rows:
        lines.append(
            f"| `{row['name']}` | {row['blocks']} | {row['tables']} | "
            f"{row['initial_stacks']} | {row['goal_stacks']} |"
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
        render_image(data, image_path)
        print(f"generated {problem_path}")
        print(f"generated {image_path}")


if __name__ == "__main__":
    main()
