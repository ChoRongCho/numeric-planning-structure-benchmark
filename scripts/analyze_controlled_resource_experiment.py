#!/usr/bin/env python3
"""Combine controlled-resource runs and render report figures."""

from __future__ import annotations

import argparse
import csv
from pathlib import Path

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt


PLANNER_LABELS = {
    ("count-downward-agile", "irhff"): "Count Downward irhff",
    ("numeric-fast-downward-local", "irhadd"): "NFD irhadd",
    ("enhsp", "hadd"): "ENHSP hadd",
    ("enhsp", "hradd"): "ENHSP hradd",
    ("metric-ff-cross-v1", "numeric-hff"): "Metric-FF numeric-hff",
}
CONDITION_ORDER = (("loose", "loose"), ("loose", "tight"), ("tight", "loose"), ("tight", "tight"))
CONDITION_LABELS = {
    ("loose", "loose"): "L/L",
    ("loose", "tight"): "L/T",
    ("tight", "loose"): "T/L",
    ("tight", "tight"): "T/T",
}
COLORS = {"L/L": "#4daf4a", "L/T": "#377eb8", "T/L": "#ff7f00", "T/T": "#e41a1c"}


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--run", action="append", required=True, metavar="INSTANCE=CSV",
        help="May be repeated; later rows replace duplicate earlier rows.",
    )
    parser.add_argument("--output", type=Path, required=True)
    return parser.parse_args()


def load(specifications: list[str]) -> list[dict[str, str]]:
    rows: dict[tuple[str, ...], dict[str, str]] = {}
    for specification in specifications:
        instance, filename = specification.split("=", 1)
        with Path(filename).open(newline="") as handle:
            for row in csv.DictReader(handle):
                row["source_instance"] = instance
                group = row["benchmark"].removeprefix("controlled_")
                key = (
                    instance, group, row["planner"], row["heuristic"],
                    row["factor_a"], row["factor_b"],
                )
                rows[key] = row
    return sorted(rows.values(), key=lambda row: (
        row["source_instance"], row["benchmark"], row["planner"],
        row["heuristic"], row["factor_a"], row["factor_b"],
    ))


def write_combined(rows: list[dict[str, str]], destination: Path) -> None:
    fields = list(rows[0])
    with destination.open("w", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=fields)
        writer.writeheader()
        writer.writerows(rows)


def plot_expanded(rows: list[dict[str, str]], group: str, destination: Path) -> None:
    configurations = [
        ("count-downward-agile", "irhff"),
        ("numeric-fast-downward-local", "irhadd"),
        ("enhsp", "hadd"),
        ("enhsp", "hradd"),
    ]
    instances = ["p001", "p002", "p003", "p004"]
    fig, axes = plt.subplots(2, 2, figsize=(11, 7), sharex=True)
    lookup = {
        (row["source_instance"], row["planner"], row["heuristic"], row["factor_a"], row["factor_b"]): row
        for row in rows if row["benchmark"] == f"controlled_{group}"
    }
    for axis, configuration in zip(axes.flat, configurations):
        for condition in CONDITION_ORDER:
            selected = [lookup[(instance, *configuration, *condition)] for instance in instances]
            values = [max(1, int(row["expanded_nodes"])) for row in selected]
            label = CONDITION_LABELS[condition]
            axis.plot(instances, values, marker="o", linewidth=2, label=label, color=COLORS[label])
            for x, value, row in zip(instances, values, selected):
                if row["status"] == "timeout":
                    axis.scatter(x, value, marker="x", s=90, linewidth=2.5, color="black", zorder=5)
        axis.set_yscale("log")
        axis.set_title(PLANNER_LABELS[configuration])
        axis.grid(True, which="both", alpha=0.25)
        axis.set_ylabel("Expanded states (log scale)")
    handles, labels = axes.flat[0].get_legend_handles_labels()
    fig.legend(
        handles, labels, loc="upper center", bbox_to_anchor=(0.5, 1.035),
        ncol=4, title="Factors: first/second",
    )
    factor_names = "water/battery" if group == "watering" else "fuel/budget"
    fig.suptitle(f"{group.title()}: matched 2x2 search effort ({factor_names}; x = timeout)", y=1.09)
    fig.tight_layout(rect=(0, 0, 1, 0.98))
    fig.savefig(destination, dpi=180, bbox_inches="tight")
    plt.close(fig)


def plot_p004_objective(rows: list[dict[str, str]], group: str, destination: Path) -> None:
    configurations = list(PLANNER_LABELS)
    lookup = {
        (row["planner"], row["heuristic"], row["factor_a"], row["factor_b"]): row
        for row in rows
        if row["benchmark"] == f"controlled_{group}" and row["source_instance"] == "p004"
    }
    x = list(range(len(CONDITION_ORDER)))
    width = 0.15
    fig, axis = plt.subplots(figsize=(11, 5.5))
    for index, configuration in enumerate(configurations):
        heights = []
        positions = [value + (index - 2) * width for value in x]
        for condition in CONDITION_ORDER:
            row = lookup[(*configuration, *condition)]
            heights.append(float(row["objective_value"]) if row["objective_value"] else 0.0)
        bars = axis.bar(positions, heights, width, label=PLANNER_LABELS[configuration])
        for bar, condition in zip(bars, CONDITION_ORDER):
            row = lookup[(*configuration, *condition)]
            if row["status"] == "timeout":
                axis.text(bar.get_x() + bar.get_width() / 2, 5, "T", ha="center", va="bottom", fontweight="bold")
    axis.set_xticks(x, [CONDITION_LABELS[condition] for condition in CONDITION_ORDER])
    axis.set_ylabel("VAL objective (lower is better; T = timeout)")
    axis.set_xlabel("Factors: first/second")
    axis.set_title(f"{group.title()} p004: first-plan objective under matched conditions")
    axis.grid(True, axis="y", alpha=0.25)
    axis.legend(ncol=2, fontsize=8)
    fig.tight_layout()
    fig.savefig(destination, dpi=180, bbox_inches="tight")
    plt.close(fig)


def main() -> int:
    args = parse_args()
    args.output.mkdir(parents=True, exist_ok=True)
    rows = load(args.run)
    write_combined(rows, args.output / "combined.csv")
    plot_expanded(rows, "watering", args.output / "watering_expanded.png")
    plot_expanded(rows, "logistics", args.output / "logistics_expanded.png")
    plot_p004_objective(rows, "watering", args.output / "watering_p004_objective.png")
    plot_p004_objective(rows, "logistics", args.output / "logistics_p004_objective.png")
    print(f"rows={len(rows)} output={args.output}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
