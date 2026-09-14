#!/usr/bin/env python3
"""Generate numeric Barman p001-p004 instances and PNG summaries."""

from __future__ import annotations

import argparse
import math
import os
import random
import re
from collections import Counter
from dataclasses import dataclass
from pathlib import Path

os.environ.setdefault("MPLCONFIGDIR", "/tmp/changmin-barman-matplotlib")

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt


NUM_PROBLEMS = 4
START_INDEX = 1
RANDOM_SEED = 5305
MEASURE_VOLUME = 50

GRASP_TIME = 1
LEAVE_TIME = 1
FILL_TIME = 3
REFILL_TIME = 2
POUR_TIME = 2
EMPTY_TIME = 1
CLEAN_SHOT_TIME = 6
CLEAN_SHAKER_TIME = 10
SHAKE_TIME = 8

# p001-p004 grow symbolically while ingredient stock becomes tighter.
BENCHMARK_PROFILES = {
    1: dict(ingredients=3, cocktails=2, orders=4, shakers=1, stock_ratio=1.50),
    2: dict(ingredients=4, cocktails=3, orders=6, shakers=1, stock_ratio=1.30),
    3: dict(ingredients=5, cocktails=4, orders=8, shakers=2, stock_ratio=1.15),
    4: dict(ingredients=6, cocktails=5, orders=10, shakers=2, stock_ratio=1.00),
}

DOMAIN_DIR = Path(__file__).resolve().parent
INSTANCE_DIR = DOMAIN_DIR / "instances"
IMAGE_DIR = DOMAIN_DIR / "images"
README_PATH = DOMAIN_DIR / "README.md"
SUMMARY_START = "<!-- AUTO-GENERATED-PROBLEM-SUMMARY:START -->"
SUMMARY_END = "<!-- AUTO-GENERATED-PROBLEM-SUMMARY:END -->"


@dataclass(frozen=True)
class Cocktail:
    name: str
    first: str
    second: str


@dataclass
class ProblemData:
    problem_name: str
    ingredients: list[str]
    cocktails: list[Cocktail]
    shots: list[str]
    shakers: list[str]
    dispensers: list[str]
    dispenser_by_ingredient: dict[str, str]
    orders: list[tuple[str, str]]
    stocks: dict[str, int]
    stock_ratio: float


def validate_profiles() -> None:
    for index in range(START_INDEX, START_INDEX + NUM_PROBLEMS):
        if index not in BENCHMARK_PROFILES:
            raise ValueError(f"missing benchmark profile for p{index:03d}")
        profile = BENCHMARK_PROFILES[index]
        if profile["ingredients"] < 2:
            raise ValueError("each profile needs at least two ingredients")
        combinations = profile["ingredients"] * (profile["ingredients"] - 1) // 2
        if not 1 <= profile["cocktails"] <= combinations:
            raise ValueError("cocktail count exceeds unique ingredient pairs")
        if profile["orders"] < 2 or profile["shakers"] < 1:
            raise ValueError("each profile needs at least two orders and one shaker")
        if profile["stock_ratio"] < 1.0:
            raise ValueError("stock_ratio must be at least 1.0 for solvability")


def generate_data(problem_index: int) -> ProblemData:
    profile = BENCHMARK_PROFILES[problem_index]
    rng = random.Random(RANDOM_SEED + problem_index)
    ingredients = [f"ingredient{i + 1}" for i in range(profile["ingredients"])]
    dispensers = [f"dispenser{i + 1}" for i in range(profile["ingredients"])]
    dispenser_by_ingredient = dict(zip(ingredients, dispensers))

    pairs = [
        (first, second)
        for first_index, first in enumerate(ingredients)
        for second in ingredients[first_index + 1 :]
    ]
    rng.shuffle(pairs)
    cocktails = [
        Cocktail(f"cocktail{index + 1}", first, second)
        for index, (first, second) in enumerate(pairs[: profile["cocktails"]])
    ]

    # Roughly one third are direct ingredient orders; the rest are cocktails.
    order_beverages: list[str] = []
    direct_count = max(1, profile["orders"] // 3)
    order_beverages.extend(ingredients[index % len(ingredients)] for index in range(direct_count))
    cocktail_order_count = profile["orders"] - direct_count
    order_beverages.extend(
        cocktails[index % len(cocktails)].name for index in range(cocktail_order_count)
    )
    rng.shuffle(order_beverages)
    shots = [f"shot{i + 1}" for i in range(profile["orders"])]
    orders = list(zip(shots, order_beverages))
    shakers = [f"shaker{i + 1}" for i in range(profile["shakers"])]

    # A two-ingredient cocktail batch fills two shot servings. Repeated orders
    # for the same cocktail can share a batch.
    required_doses: Counter[str] = Counter()
    cocktail_counts = Counter(beverage for _, beverage in orders if beverage.startswith("cocktail"))
    cocktail_by_name = {cocktail.name: cocktail for cocktail in cocktails}
    for beverage, count in cocktail_counts.items():
        batches = math.ceil(count / 2)
        cocktail = cocktail_by_name[beverage]
        required_doses[cocktail.first] += batches
        required_doses[cocktail.second] += batches
    for _, beverage in orders:
        if beverage.startswith("ingredient"):
            required_doses[beverage] += 1

    stocks = {}
    for ingredient in ingredients:
        required_volume = required_doses[ingredient] * MEASURE_VOLUME
        doses = max(required_doses[ingredient], math.ceil(required_doses[ingredient] * profile["stock_ratio"]))
        stocks[dispenser_by_ingredient[ingredient]] = max(MEASURE_VOLUME, doses * MEASURE_VOLUME)
        if stocks[dispenser_by_ingredient[ingredient]] < required_volume:
            raise AssertionError("generated stock cannot satisfy the orders")

    return ProblemData(
        problem_name=f"numeric-barman-p{problem_index:03d}",
        ingredients=ingredients,
        cocktails=cocktails,
        shots=shots,
        shakers=shakers,
        dispensers=dispensers,
        dispenser_by_ingredient=dispenser_by_ingredient,
        orders=orders,
        stocks=stocks,
        stock_ratio=profile["stock_ratio"],
    )


def render_pddl(data: ProblemData) -> str:
    lines = [
        f"(define (problem {data.problem_name}) (:domain numeric-barman)",
        "  (:objects",
        "    left right - hand",
        "    level0 level1 level2 - level",
        f"    {' '.join(data.ingredients)} - ingredient",
        f"    {' '.join(cocktail.name for cocktail in data.cocktails)} - cocktail",
        f"    {' '.join(data.dispensers)} - dispenser",
        f"    {' '.join(data.shots)} - shot",
        f"    {' '.join(data.shakers)} - shaker",
        "  )",
        "",
        "  (:init",
        "    (handempty left)",
        "    (handempty right)",
        "    (next level0 level1)",
        "    (next level1 level2)",
    ]
    for shot in data.shots:
        lines.extend(
            [
                f"    (ontable {shot})",
                f"    (empty {shot})",
                f"    (clean {shot})",
                f"    (= (container-capacity {shot}) {MEASURE_VOLUME})",
                f"    (= (liquid-volume {shot}) 0)",
            ]
        )
    for shaker in data.shakers:
        lines.extend(
            [
                f"    (ontable {shaker})",
                f"    (empty {shaker})",
                f"    (clean {shaker})",
                f"    (shaker-empty-level {shaker} level0)",
                f"    (shaker-level {shaker} level0)",
                f"    (= (container-capacity {shaker}) {2 * MEASURE_VOLUME})",
                f"    (= (liquid-volume {shaker}) 0)",
            ]
        )
    for ingredient, dispenser in data.dispenser_by_ingredient.items():
        lines.extend(
            [
                f"    (dispenses {dispenser} {ingredient})",
                f"    (= (dispense-amount {dispenser}) {MEASURE_VOLUME})",
                f"    (= (dispenser-stock {dispenser}) {data.stocks[dispenser]})",
            ]
        )
    for cocktail in data.cocktails:
        lines.append(f"    (cocktail-part1 {cocktail.name} {cocktail.first})")
        lines.append(f"    (cocktail-part2 {cocktail.name} {cocktail.second})")
    lines.extend(
        [
            f"    (= (grasp-time) {GRASP_TIME})",
            f"    (= (leave-time) {LEAVE_TIME})",
            f"    (= (fill-time) {FILL_TIME})",
            f"    (= (refill-time) {REFILL_TIME})",
            f"    (= (pour-time) {POUR_TIME})",
            f"    (= (empty-time) {EMPTY_TIME})",
            f"    (= (clean-shot-time) {CLEAN_SHOT_TIME})",
            f"    (= (clean-shaker-time) {CLEAN_SHAKER_TIME})",
            f"    (= (shake-time) {SHAKE_TIME})",
            "    (= (total-barman-time) 0)",
            "  )",
            "",
            "  (:goal (and",
            "    (handempty left)",
            "    (handempty right)",
        ]
    )
    for shot, beverage in data.orders:
        lines.append(f"    (contains {shot} {beverage})")
        lines.append(f"    (ontable {shot})")
    for shaker in data.shakers:
        lines.append(f"    (ontable {shaker})")
    lines.extend(
        [
            "  ))",
            "",
            "  (:metric minimize (total-barman-time))",
            ")",
            "",
        ]
    )
    return "\n".join(lines)


def render_image(data: ProblemData, output_path: Path) -> None:
    figure, (recipe_axis, order_axis) = plt.subplots(1, 2, figsize=(15, 8))
    figure.suptitle(
        f"{data.problem_name} | stock ratio={data.stock_ratio:.2f} | "
        f"shots={len(data.shots)} | shakers={len(data.shakers)}",
        fontsize=15,
        fontweight="bold",
    )
    recipe_axis.axis("off")
    recipe_axis.set_title("Recipes and finite dispenser stock")
    recipe_lines = []
    for cocktail in data.cocktails:
        recipe_lines.append(f"{cocktail.name}: {cocktail.first} + {cocktail.second}")
    recipe_lines.append("")
    for ingredient in data.ingredients:
        dispenser = data.dispenser_by_ingredient[ingredient]
        recipe_lines.append(
            f"{dispenser} -> {ingredient}: {data.stocks[dispenser]} ml "
            f"({data.stocks[dispenser] // MEASURE_VOLUME} doses)"
        )
    recipe_axis.text(
        0.03, 0.95, "\n".join(recipe_lines), va="top", fontsize=11,
        family="monospace", transform=recipe_axis.transAxes,
        bbox=dict(boxstyle="round,pad=0.7", facecolor="#eff6ff", edgecolor="#2563eb"),
    )

    order_axis.axis("off")
    order_axis.set_title("Required served shots")
    order_lines = [f"{shot}  <-  {beverage}" for shot, beverage in data.orders]
    order_axis.text(
        0.03, 0.95, "\n".join(order_lines), va="top", fontsize=12,
        family="monospace", transform=order_axis.transAxes,
        bbox=dict(boxstyle="round,pad=0.7", facecolor="#fef3c7", edgecolor="#d97706"),
    )
    order_axis.text(
        0.03, 0.10,
        f"shot capacity: {MEASURE_VOLUME} ml\n"
        f"shaker capacity: {2 * MEASURE_VOLUME} ml\n"
        "goal: serve all shots and leave both hands empty",
        fontsize=10, transform=order_axis.transAxes,
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

    stocks = [int(value) for value in re.findall(r"dispenser-stock [^)]+\) (\d+)\)", text)]
    return {
        "name": path.stem,
        "ingredients": count_type("ingredient"),
        "cocktails": count_type("cocktail"),
        "shots": count_type("shot"),
        "shakers": count_type("shaker"),
        "stock_min": min(stocks) if stocks else 0,
        "stock_max": max(stocks) if stocks else 0,
    }


def update_readme_summary() -> None:
    rows = [parse_problem(path) for path in sorted(INSTANCE_DIR.glob("p[0-9][0-9][0-9].pddl"))]
    lines = [
        SUMMARY_START,
        "## 생성된 문제 요약",
        "",
        "| Problem | Ingredients | Cocktails | Orders/shots | Shakers | Dispenser stock |",
        "|---|---:|---:|---:|---:|---:|",
    ]
    for row in rows:
        lines.append(
            f"| `{row['name']}` | {row['ingredients']} | {row['cocktails']} | "
            f"{row['shots']} | {row['shakers']} | "
            f"{row['stock_min']}–{row['stock_max']} ml |"
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
