#!/usr/bin/env python3
"""Combine controlled Barman runs and render a status/time heatmap."""

from __future__ import annotations

import argparse
import csv
import math
from pathlib import Path

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.colors import LogNorm


PLANNERS = [
    ("metric-ff-cross-v1", "numeric-hff", "Metric-FF hFF"),
    ("count-downward-agile", "irhff", "Count Downward irhff"),
    ("numeric-fast-downward-local", "irhadd", "NFD irhadd"),
    ("enhsp", "hadd", "ENHSP hadd"),
    ("enhsp", "hradd", "ENHSP hradd"),
]
REGIMES = ["abundant", "boundary", "one-short", "blocked-zero"]
REGIME_LABELS = ["Abundant\n(3x)", "Boundary\n(exact)", "One short\n(delayed no)", "Zero\n(immediate no)"]
STATUS = {"solved": "V", "unsolved": "U", "timeout": "T", "crash": "C"}


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("--run", action="append", required=True, type=Path)
    parser.add_argument("--output", required=True, type=Path)
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    rows = []
    for path in args.run:
        with path.open(newline="", encoding="utf-8") as handle:
            rows.extend(csv.DictReader(handle))
    rows.sort(key=lambda row: (row["source_instance"], row["planner"], row["stock_regime"]))
    args.output.mkdir(parents=True, exist_ok=True)
    with (args.output / "combined.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=rows[0].keys())
        writer.writeheader()
        writer.writerows(rows)

    instances = [instance for instance in ("p001", "p002", "p004") if any(r["source_instance"] == instance for r in rows)]
    lookup = {
        (row["source_instance"], row["planner"], row["heuristic"], row["stock_regime"]): row
        for row in rows
    }
    figure, axes = plt.subplots(1, len(instances), figsize=(6.1 * len(instances), 5.2), squeeze=False)
    for panel_index, (axis, instance) in enumerate(zip(axes[0], instances)):
        values = []
        for planner, heuristic, _ in PLANNERS:
            values.append([
                max(0.18, float(lookup[(instance, planner, heuristic, regime)]["wall_seconds"]))
                for regime in REGIMES
            ])
        image = axis.imshow(values, cmap="YlOrRd", norm=LogNorm(vmin=0.18, vmax=60), aspect="auto")
        for y, (planner, heuristic, _) in enumerate(PLANNERS):
            for x, regime in enumerate(REGIMES):
                row = lookup[(instance, planner, heuristic, regime)]
                seconds = float(row["wall_seconds"])
                mark = STATUS.get(row["status"], "?")
                color = "white" if seconds >= 15 else "black"
                axis.text(x, y, f"{mark}\n{seconds:.1f}s", ha="center", va="center", color=color, fontsize=10)
        axis.set_title(f"{instance}: " + {"p001": "4", "p002": "6", "p004": "10"}[instance] + " orders")
        axis.set_xticks(range(len(REGIMES)), REGIME_LABELS)
        axis.set_yticks(range(len(PLANNERS)))
        axis.set_yticklabels([label for _, _, label in PLANNERS] if panel_index == 0 else [])
        axis.set_xlabel("Initial stock regime")
    figure.colorbar(image, ax=axes.ravel().tolist(), label="Wall time (seconds, log scale)", fraction=0.025, pad=0.02)
    figure.suptitle("Barman: feasibility boundary and horizon (60 s timeout)\nV=valid plan, U=proved unsolvable, T=timeout", fontsize=14, y=1.02)
    figure.savefig(args.output / "status_time_heatmap.png", dpi=180, bbox_inches="tight")
    plt.close(figure)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
