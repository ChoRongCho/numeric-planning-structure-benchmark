#!/usr/bin/env python3
"""Generate library rearrangement PDDL instances and PNG summaries."""

from __future__ import annotations

import argparse
import math
import os
import random
import re
from dataclasses import dataclass
from pathlib import Path

os.environ.setdefault("MPLCONFIGDIR", "/tmp/changmin-books-matplotlib")

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt
import networkx as nx
from matplotlib.lines import Line2D


# ---------------------------------------------------------------------------
# Global generator configuration: edit these values.
# ---------------------------------------------------------------------------

NUM_PROBLEMS = 1
START_INDEX = 1  # p001 is the hand-designed reference instance.

NUM_BOOKS = 5
NUM_SHELVES = 2
NUM_ROOMS = 3  # Includes one return room.
NUM_CARTS = 1

RANDOM_SEED = 5303
BOOK_WEIGHT_MIN = 1
BOOK_WEIGHT_MAX = 5
BOOK_THICKNESS_MIN = 1
BOOK_THICKNESS_MAX = 4

CART_CAPACITY_RATIO = 0.45
MISORDERED_SHELF_RATIO = 0.67
HIGH_SHELF_RATIO = 0.34

ROBOT_REACH = 180
LOW_SHELF_HEIGHT_MIN = 120
LOW_SHELF_HEIGHT_MAX = 175
HIGH_SHELF_HEIGHT_MIN = 200
HIGH_SHELF_HEIGHT_MAX = 235
STEP_BOOST = 60

MOVE_ALONE_TIME = 8
MOVE_CART_TIME = 10
CART_HANDLING_TIME = 2
BOOK_HANDLING_TIME = 1
SHELF_HANDLING_TIME = 2
STEP_HANDLING_TIME = 5

DOMAIN_DIR = Path(__file__).resolve().parent
INSTANCE_DIR = DOMAIN_DIR / "instances"
IMAGE_DIR = DOMAIN_DIR / "images"
README_PATH = DOMAIN_DIR / "README.md"
SUMMARY_START = "<!-- AUTO-GENERATED-PROBLEM-SUMMARY:START -->"
SUMMARY_END = "<!-- AUTO-GENERATED-PROBLEM-SUMMARY:END -->"


@dataclass(frozen=True)
class Book:
    name: str
    weight: int
    thickness: int
    shelf: str
    target_slot: str


@dataclass(frozen=True)
class Shelf:
    name: str
    room: str
    slots: tuple[str, ...]
    end_marker: str
    height: int
    capacity: int
    initially_placed: tuple[tuple[str, str], ...]
    next_to_fill: str


@dataclass
class ProblemData:
    problem_name: str
    rooms: list[str]
    connections: set[tuple[str, str]]
    carts: list[str]
    books: list[Book]
    shelves: list[Shelf]
    high_rooms: set[str]
    cart_capacity: int


def canonical_edge(a: str, b: str) -> tuple[str, str]:
    return (a, b) if a < b else (b, a)


def validate_configuration() -> None:
    if NUM_PROBLEMS < 1:
        raise ValueError("NUM_PROBLEMS must be at least 1")
    if NUM_BOOKS < 3:
        raise ValueError("NUM_BOOKS must be at least 3")
    if not 1 <= NUM_SHELVES <= NUM_BOOKS:
        raise ValueError("NUM_SHELVES must be between 1 and NUM_BOOKS")
    if NUM_ROOMS < 2:
        raise ValueError("NUM_ROOMS must be at least 2")
    if NUM_CARTS < 1:
        raise ValueError("NUM_CARTS must be at least 1")
    if NUM_BOOKS < 2 * NUM_SHELVES + 1:
        raise ValueError(
            "NUM_BOOKS must be at least 2 * NUM_SHELVES + 1 so at least "
            "one shelf can contain a forced misordering"
        )
    for name, ratio in (
        ("CART_CAPACITY_RATIO", CART_CAPACITY_RATIO),
        ("MISORDERED_SHELF_RATIO", MISORDERED_SHELF_RATIO),
        ("HIGH_SHELF_RATIO", HIGH_SHELF_RATIO),
    ):
        if not 0.0 < ratio <= 1.0:
            raise ValueError(f"{name} must be in (0, 1]")
    if BOOK_WEIGHT_MIN < 1 or BOOK_WEIGHT_MAX < BOOK_WEIGHT_MIN:
        raise ValueError("book weight range is invalid")
    if BOOK_THICKNESS_MIN < 1 or BOOK_THICKNESS_MAX < BOOK_THICKNESS_MIN:
        raise ValueError("book thickness range is invalid")
    if LOW_SHELF_HEIGHT_MAX > ROBOT_REACH:
        raise ValueError("low shelves must be reachable without a step")
    if HIGH_SHELF_HEIGHT_MAX > ROBOT_REACH + STEP_BOOST:
        raise ValueError("the step must make every high shelf reachable")


def sample_connected_rooms(
    rooms: list[str], rng: random.Random
) -> set[tuple[str, str]]:
    order = rooms.copy()
    rng.shuffle(order)
    edges: set[tuple[str, str]] = set()
    for index in range(1, len(order)):
        edges.add(canonical_edge(order[index], rng.choice(order[:index])))
    return edges


def balanced_book_counts() -> list[int]:
    base, remainder = divmod(NUM_BOOKS, NUM_SHELVES)
    return [base + (1 if index < remainder else 0) for index in range(NUM_SHELVES)]


def generate_data(problem_index: int) -> ProblemData:
    rng = random.Random(RANDOM_SEED + problem_index)
    rooms = ["return-room"] + [f"aisle{i}" for i in range(1, NUM_ROOMS)]
    connections = sample_connected_rooms(rooms, rng)
    shelf_rooms = [rooms[1 + index % (NUM_ROOMS - 1)] for index in range(NUM_SHELVES)]

    high_count = max(1, round(NUM_SHELVES * HIGH_SHELF_RATIO))
    high_indices = set(rng.sample(range(NUM_SHELVES), high_count))
    eligible_misordered = [
        index for index, count in enumerate(balanced_book_counts()) if count >= 3
    ]
    misordered_count = max(
        1, round(len(eligible_misordered) * MISORDERED_SHELF_RATIO)
    )
    misordered_indices = set(
        rng.sample(eligible_misordered, min(misordered_count, len(eligible_misordered)))
    )

    books: list[Book] = []
    shelf_specs: list[dict[str, object]] = []
    book_number = 1
    for shelf_index, count in enumerate(balanced_book_counts()):
        shelf_name = f"shelf{shelf_index + 1}"
        slots = tuple(
            f"s{shelf_index + 1}-slot{slot_index + 1}" for slot_index in range(count)
        )
        end_marker = f"s{shelf_index + 1}-end"
        shelf_books: list[Book] = []
        for local_index in range(count):
            book = Book(
                name=f"book{book_number:03d}",
                weight=rng.randint(BOOK_WEIGHT_MIN, BOOK_WEIGHT_MAX),
                thickness=rng.randint(BOOK_THICKNESS_MIN, BOOK_THICKNESS_MAX),
                shelf=shelf_name,
                target_slot=slots[local_index],
            )
            books.append(book)
            shelf_books.append(book)
            book_number += 1

        initially_placed: list[tuple[str, str]] = []
        if shelf_index in misordered_indices:
            # Correct first book, then place the third book in the second slot.
            initially_placed = [
                (shelf_books[0].name, slots[0]),
                (shelf_books[2].name, slots[1]),
            ]
            next_to_fill = slots[2]
        else:
            initially_placed = [(shelf_books[0].name, slots[0])]
            next_to_fill = slots[1] if count > 1 else end_marker

        height = (
            rng.randint(HIGH_SHELF_HEIGHT_MIN, HIGH_SHELF_HEIGHT_MAX)
            if shelf_index in high_indices
            else rng.randint(LOW_SHELF_HEIGHT_MIN, LOW_SHELF_HEIGHT_MAX)
        )
        shelf_specs.append(
            {
                "name": shelf_name,
                "room": shelf_rooms[shelf_index],
                "slots": slots,
                "end_marker": end_marker,
                "height": height,
                "capacity": sum(book.thickness for book in shelf_books),
                "initially_placed": tuple(initially_placed),
                "next_to_fill": next_to_fill,
            }
        )

    shelves = [Shelf(**spec) for spec in shelf_specs]
    initially_shelved = {
        book_name for shelf in shelves for book_name, _ in shelf.initially_placed
    }
    return_books = [book for book in books if book.name not in initially_shelved]
    return_weight = sum(book.weight for book in return_books)
    cart_capacity = max(
        max(book.weight for book in books),
        math.ceil(return_weight * CART_CAPACITY_RATIO),
    )
    # Keep batching active whenever at least two books are waiting.
    if len(return_books) > 1:
        cart_capacity = min(cart_capacity, return_weight - 1)

    high_rooms = {
        shelf.room for shelf in shelves if shelf.height > ROBOT_REACH
    }
    return ProblemData(
        problem_name=f"library-rearrangement-p{problem_index:03d}",
        rooms=rooms,
        connections=connections,
        carts=[f"cart{index + 1}" for index in range(NUM_CARTS)],
        books=books,
        shelves=shelves,
        high_rooms=high_rooms,
        cart_capacity=cart_capacity,
    )


def render_pddl(data: ProblemData) -> str:
    slots = [slot for shelf in data.shelves for slot in shelf.slots]
    ends = [shelf.end_marker for shelf in data.shelves]
    steps = [f"step{index + 1}" for index in range(len(data.high_rooms))]
    step_by_room = dict(zip(sorted(data.high_rooms), steps))
    initially_shelved = {
        book_name for shelf in data.shelves for book_name, _ in shelf.initially_placed
    }

    lines = [
        f"(define (problem {data.problem_name}) (:domain library-books)",
        "  (:objects",
        "    robot1 - robot",
        f"    {' '.join(book.name for book in data.books)} - book",
        f"    {' '.join(data.carts)} - cart",
        f"    {' '.join(data.rooms)} - room",
        f"    {' '.join(shelf.name for shelf in data.shelves)} - shelf",
    ]
    if steps:
        lines.append(f"    {' '.join(steps)} - step")
    lines.extend(
        [
            f"    {' '.join(slots)} - slot",
            f"    {' '.join(ends)} - end-marker",
            "  )",
            "",
            "  (:init",
            "    (at-robot robot1 return-room)",
            "    (hand-free robot1)",
            "    (without-cart robot1)",
            "    (grounded robot1)",
        ]
    )
    for cart in data.carts:
        lines.append(f"    (cart-at {cart} return-room)")
    for room in data.rooms:
        lines.append(f"    (staging-area {room})")
    for a, b in sorted(data.connections):
        lines.append(f"    (connected {a} {b}) (connected {b} {a})")
    for shelf in data.shelves:
        lines.append(f"    (shelf-at {shelf.name} {shelf.room})")
    for room, step in sorted(step_by_room.items()):
        lines.append(f"    (step-at {step} {room})")
        lines.append(f"    (step-ready {step})")

    lines.append("")
    for shelf in data.shelves:
        for book_name, slot in shelf.initially_placed:
            lines.append(f"    (on-shelf {book_name} {shelf.name} {slot})")
        lines.append(f"    (next-to-fill {shelf.name} {shelf.next_to_fill})")
        positions = list(shelf.slots) + [shelf.end_marker]
        for current, following in zip(positions, positions[1:]):
            lines.append(
                f"    (successor {current} {following} {shelf.name})"
            )
    for book in data.books:
        if book.name not in initially_shelved:
            lines.append(f"    (book-at {book.name} return-room)")
        lines.append(
            f"    (assigned {book.name} {book.shelf} {book.target_slot})"
        )

    lines.append("")
    for book in data.books:
        lines.append(f"    (= (book-weight {book.name}) {book.weight})")
        lines.append(f"    (= (book-thickness {book.name}) {book.thickness})")
    for cart in data.carts:
        lines.append(f"    (= (cart-capacity {cart}) {data.cart_capacity})")
        lines.append(f"    (= (cart-load {cart}) 0)")
    for shelf in data.shelves:
        book_by_name = {book.name: book for book in data.books}
        used = sum(
            book_by_name[book_name].thickness
            for book_name, _ in shelf.initially_placed
        )
        lines.append(f"    (= (shelf-capacity {shelf.name}) {shelf.capacity})")
        lines.append(f"    (= (shelf-used-space {shelf.name}) {used})")
        lines.append(f"    (= (shelf-height {shelf.name}) {shelf.height})")
    lines.append(f"    (= (current-reach robot1) {ROBOT_REACH})")
    for step in steps:
        lines.append(f"    (= (step-boost {step}) {STEP_BOOST})")

    lines.extend(
        [
            f"    (= (move-alone-time) {MOVE_ALONE_TIME})",
            f"    (= (move-cart-time) {MOVE_CART_TIME})",
            f"    (= (cart-handling-time) {CART_HANDLING_TIME})",
            f"    (= (book-handling-time) {BOOK_HANDLING_TIME})",
            f"    (= (shelf-handling-time) {SHELF_HANDLING_TIME})",
            f"    (= (step-handling-time) {STEP_HANDLING_TIME})",
            "    (= (total-library-time) 0)",
        ]
    )

    lines.extend(["  )", "", "  (:goal (and"])
    for book in data.books:
        lines.append(
            f"    (on-shelf {book.name} {book.shelf} {book.target_slot})"
        )
    for shelf in data.shelves:
        lines.append(f"    (next-to-fill {shelf.name} {shelf.end_marker})")
    lines.extend(
        ["  ))", "", "  (:metric minimize (total-library-time))", ")", ""]
    )
    return "\n".join(lines)


def render_graph(data: ProblemData, output_path: Path, seed: int) -> None:
    graph = nx.Graph()
    graph.add_nodes_from(data.rooms)
    graph.add_edges_from(data.connections)
    positions = nx.spring_layout(graph, seed=seed)

    figure, (map_axis, shelf_axis) = plt.subplots(
        1, 2, figsize=(16, 9), gridspec_kw={"width_ratios": [1.0, 1.35]}
    )
    figure.suptitle(data.problem_name, fontsize=17, fontweight="bold")

    nx.draw_networkx_edges(
        graph, positions, edge_color="#64748b", width=3, ax=map_axis
    )
    node_colors = [
        "#fde68a" if room == "return-room" else "#dbeafe" for room in data.rooms
    ]
    nx.draw_networkx_nodes(
        graph,
        positions,
        node_color=node_colors,
        node_size=3000,
        edgecolors="#1e293b",
        ax=map_axis,
    )
    room_labels: dict[str, str] = {}
    for room in data.rooms:
        details = [room]
        room_shelves = [shelf.name for shelf in data.shelves if shelf.room == room]
        if room_shelves:
            details.append("shelves: " + ",".join(room_shelves))
        if room in data.high_rooms:
            details.append("STEP")
        if room == "return-room":
            waiting = sum(
                1
                for book in data.books
                if all(
                    book.name != placed
                    for shelf in data.shelves
                    for placed, _ in shelf.initially_placed
                )
            )
            details.append(f"robot + {len(data.carts)} cart")
            details.append(f"waiting books: {waiting}")
        room_labels[room] = "\n".join(details)
    nx.draw_networkx_labels(
        graph, positions, labels=room_labels, font_size=8, ax=map_axis
    )
    map_axis.set_title("Library room graph")
    map_axis.axis("off")

    shelf_axis.set_title("Shelf sequence and numeric gates")
    shelf_axis.axis("off")
    y = 0.94
    book_by_name = {book.name: book for book in data.books}
    for shelf in data.shelves:
        target_books = sorted(
            (book for book in data.books if book.shelf == shelf.name),
            key=lambda book: shelf.slots.index(book.target_slot),
        )
        initial_by_slot = {
            slot: book_name for book_name, slot in shelf.initially_placed
        }
        initial = [
            initial_by_slot.get(slot, "empty") for slot in shelf.slots
        ]
        target = [book.name for book in target_books]
        used = sum(book_by_name[name].thickness for name in initial if name != "empty")
        is_high = shelf.height > ROBOT_REACH
        color = "#dc2626" if is_high else "#2563eb"
        shelf_axis.text(
            0.02,
            y,
            f"{shelf.name} @ {shelf.room} | height={shelf.height} "
            f"| space={used}/{shelf.capacity}"
            + (" | STEP REQUIRED" if is_high else ""),
            fontsize=11,
            fontweight="bold",
            color=color,
            transform=shelf_axis.transAxes,
        )
        shelf_axis.text(
            0.04,
            y - 0.055,
            "initial: " + " | ".join(initial),
            fontsize=9,
            family="monospace",
            transform=shelf_axis.transAxes,
        )
        shelf_axis.text(
            0.04,
            y - 0.100,
            "target : " + " | ".join(target),
            fontsize=9,
            family="monospace",
            transform=shelf_axis.transAxes,
        )
        y -= 0.25

    waiting_books = [
        book
        for book in data.books
        if all(
            book.name != placed
            for shelf in data.shelves
            for placed, _ in shelf.initially_placed
        )
    ]
    summary = ", ".join(
        f"{book.name}(w={book.weight},th={book.thickness})"
        for book in waiting_books
    )
    figure.text(
        0.02,
        0.025,
        f"cart capacity={data.cart_capacity}; robot reach={ROBOT_REACH}; "
        f"step boost={STEP_BOOST}\nreturn books: {summary}",
        fontsize=8,
        family="monospace",
    )
    map_axis.legend(
        handles=[
            Line2D(
                [0], [0], marker="o", color="w", markerfacecolor="#fde68a",
                markeredgecolor="#1e293b", markersize=12, label="Return room"
            ),
            Line2D(
                [0], [0], marker="o", color="w", markerfacecolor="#dbeafe",
                markeredgecolor="#1e293b", markersize=12, label="Aisle"
            ),
        ],
        loc="upper left",
    )
    figure.tight_layout(rect=(0, 0.10, 1, 0.96))
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


def facts(text: str, predicate: str, arity: int) -> list[tuple[str, ...]]:
    arguments = r"\s+([^\s()]+)" * arity
    pattern = re.compile(rf"\(\s*{re.escape(predicate)}{arguments}\s*\)", re.I)
    return [tuple(match.groups()) for match in pattern.finditer(text)]


def numeric_entries(text: str) -> dict[str, list[tuple[list[str], float]]]:
    pattern = re.compile(
        r"\(=\s*\(\s*([\w-]+)((?:\s+[^()]*)?)\)\s*"
        r"([-+]?\d+(?:\.\d+)?)\s*\)",
        re.I,
    )
    result: dict[str, list[tuple[list[str], float]]] = {}
    for function, raw_args, raw_value in pattern.findall(text):
        result.setdefault(function.lower(), []).append(
            (raw_args.split(), float(raw_value))
        )
    return result


def number(value: float) -> str:
    return str(int(value)) if value.is_integer() else f"{value:g}"


def value_range(entries: list[tuple[list[str], float]]) -> str:
    if not entries:
        return "-"
    values = [value for _, value in entries]
    low, high = min(values), max(values)
    return number(low) if low == high else f"{number(low)}–{number(high)}"


def parse_problem(problem_path: Path) -> dict[str, str | int]:
    text = problem_path.read_text(encoding="utf-8")
    init, _, _ = text.partition("(:goal")
    numeric = numeric_entries(init)
    books = {entry[0] for entry in facts(init, "assigned", 3)}
    shelves = {entry[1] for entry in facts(init, "assigned", 3)}
    rooms = {entry[0] for entry in facts(init, "staging-area", 1)}
    carts = {
        args[0]
        for function in ("cart-capacity",)
        for args, _ in numeric.get(function, [])
    }
    placed = {book: (shelf, slot) for book, shelf, slot in facts(init, "on-shelf", 3)}
    assigned = {
        book: (shelf, slot) for book, shelf, slot in facts(init, "assigned", 3)
    }
    misordered = {
        shelf
        for book, (shelf, slot) in placed.items()
        if assigned.get(book) != (shelf, slot)
    }
    reach_values = [value for _, value in numeric.get("current-reach", [])]
    reach = max(reach_values) if reach_values else 0
    high_shelves = sum(
        1 for _, height in numeric.get("shelf-height", []) if height > reach
    )
    return {
        "problem": problem_path.stem,
        "books": len(books),
        "shelves": len(shelves),
        "rooms": len(rooms),
        "carts": len(carts),
        "misordered": len(misordered),
        "high": high_shelves,
        "weight": value_range(numeric.get("book-weight", [])),
        "thickness": value_range(numeric.get("book-thickness", [])),
        "cart_capacity": value_range(numeric.get("cart-capacity", [])),
        "shelf_capacity": value_range(numeric.get("shelf-capacity", [])),
        "shelf_used": value_range(numeric.get("shelf-used-space", [])),
        "shelf_height": value_range(numeric.get("shelf-height", [])),
        "reach": value_range(numeric.get("current-reach", [])),
    }


def render_readme_summary(rows: list[dict[str, str | int]]) -> str:
    lines = [
        SUMMARY_START,
        "## Problem 설정 요약",
        "",
        "> 이 구간은 generate_problem.py --summarize가 instances의 problem을",
        "> 직접 파싱해 갱신한다.",
        "",
        "| Problem | Books | Shelves | Rooms | Carts | Misordered shelves | High shelves |",
        "|---|---:|---:|---:|---:|---:|---:|",
    ]
    for row in rows:
        lines.append(
            f"| {row['problem']} | {row['books']} | {row['shelves']} | "
            f"{row['rooms']} | {row['carts']} | {row['misordered']} | "
            f"{row['high']} |"
        )
    lines.extend(
        [
            "",
            "| Problem | Book weight | Thickness | Cart capacity | Shelf capacity | Initial shelf use | Shelf height | Robot reach |",
            "|---|---:|---:|---:|---:|---:|---:|---:|",
        ]
    )
    for row in rows:
        lines.append(
            f"| {row['problem']} | {row['weight']} | {row['thickness']} | "
            f"{row['cart_capacity']} | {row['shelf_capacity']} | "
            f"{row['shelf_used']} | {row['shelf_height']} | {row['reach']} |"
        )
    lines.extend(["", SUMMARY_END])
    return "\n".join(lines)


def summarize_problems() -> list[Path]:
    def problem_number(path: Path) -> int:
        match = re.fullmatch(r"p(\d+)\.pddl", path.name, re.I)
        return int(match.group(1)) if match else 10**9

    paths = sorted(INSTANCE_DIR.glob("p*.pddl"), key=problem_number)
    if not paths:
        raise FileNotFoundError(f"no pNNN.pddl files found in {INSTANCE_DIR}")
    generated = render_readme_summary([parse_problem(path) for path in paths])
    readme = README_PATH.read_text(encoding="utf-8") if README_PATH.exists() else "# 03 Books\n"
    if SUMMARY_START in readme and SUMMARY_END in readme:
        before = readme.split(SUMMARY_START, 1)[0].rstrip()
        after = readme.split(SUMMARY_END, 1)[1].lstrip()
        readme = f"{before}\n\n{generated}\n"
        if after:
            readme += f"\n{after.rstrip()}\n"
    else:
        readme = f"{readme.rstrip()}\n\n{generated}\n"
    README_PATH.write_text(readme, encoding="utf-8")
    print(f"summarized {len(paths)} problems: {README_PATH}")
    return paths


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Generate Books problems or summarize existing instances."
    )
    parser.add_argument(
        "--summarize",
        action="store_true",
        help="parse p001-pNNN and update the README summary",
    )
    args = parser.parse_args()
    if args.summarize:
        summarize_problems()
    else:
        generate_problems()


if __name__ == "__main__":
    main()
