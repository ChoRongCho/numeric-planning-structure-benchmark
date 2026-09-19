#!/usr/bin/env python3
"""Run a controlled Barman horizon x stock-feasibility experiment.

For each selected source problem, the symbolic problem is held fixed and only
initial dispenser stocks change.  Four regimes distinguish abundant stock,
the exact solvability boundary, a one-dose delayed contradiction, and an
immediately blocked required ingredient.
"""

from __future__ import annotations

import argparse
import csv
import json
import math
import re
import sys
import time
from collections import Counter
from datetime import datetime, timezone
from pathlib import Path

sys.dont_write_bytecode = True

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(HERE))
sys.path.insert(0, str(ROOT / "src" / "planner_gui"))

import benchmark_core as core
from controlled_resource_experiment import CONFIGURATIONS, Configuration
from profiles import build_command


DOSE = 50


def required_doses(text: str) -> Counter[str]:
    recipes = {
        cocktail: (first, second)
        for cocktail, first, second in re.findall(
            r"\(cocktail-part1\s+(\S+)\s+(\S+)\)\s*\n\s*"
            r"\(cocktail-part2\s+\1\s+(\S+)\)",
            text,
        )
    }
    goals = re.findall(r"\(contains\s+shot\d+\s+(\S+)\)", text.split("(:goal", 1)[1])
    counts: Counter[str] = Counter()
    cocktail_counts = Counter(goal for goal in goals if goal in recipes)
    for cocktail, count in cocktail_counts.items():
        first, second = recipes[cocktail]
        batches = math.ceil(count / 2)
        counts[first] += batches
        counts[second] += batches
    for goal in goals:
        if goal not in recipes:
            counts[goal] += 1
    return counts


def dispenser_map(text: str) -> dict[str, str]:
    return {
        ingredient: dispenser
        for dispenser, ingredient in re.findall(r"\(dispenses\s+(\S+)\s+(\S+)\)", text)
    }


def replace_stock(text: str, dispenser: str, value: int) -> str:
    pattern = rf"(\(=\s+\(dispenser-stock\s+{re.escape(dispenser)}\)\s+)[-+]?\d+(?:\.\d+)?(\s*\))"
    result, count = re.subn(pattern, rf"\g<1>{value}\g<2>", text)
    if count != 1:
        raise ValueError(f"expected one stock assignment for {dispenser}, found {count}")
    return result


def make_variants(source: Path, destination: Path) -> list[dict[str, str]]:
    text = source.read_text(encoding="utf-8")
    needs = required_doses(text)
    dispensers = dispenser_map(text)
    if not needs:
        raise ValueError(f"no required ingredients parsed from {source}")
    critical = max(needs, key=lambda ingredient: (needs[ingredient], ingredient))
    regimes: dict[str, dict[str, int]] = {}
    exact = {ingredient: max(DOSE, needs[ingredient] * DOSE) for ingredient in dispensers}
    regimes["abundant"] = {
        ingredient: max(DOSE, exact[ingredient] * 3) for ingredient in dispensers
    }
    regimes["boundary"] = dict(exact)
    delayed = dict(exact)
    delayed[critical] = max(0, delayed[critical] - DOSE)
    regimes["one-short"] = delayed
    blocked = dict(exact)
    blocked[critical] = 0
    regimes["blocked-zero"] = blocked

    rows = []
    for regime, stocks in regimes.items():
        variant = text
        for ingredient, dispenser in dispensers.items():
            variant = replace_stock(variant, dispenser, stocks[ingredient])
        name = f"barman__{source.stem}__stock-{regime}"
        path = destination / f"{name}.pddl"
        path.write_text(variant, encoding="utf-8")
        rows.append({
            "variant": name,
            "source_instance": source.stem,
            "horizon": {
                "p001": "very-short",
                "p002": "short",
                "p003": "medium",
                "p004": "long",
            }[source.stem],
            "stock_regime": regime,
            "critical_ingredient": critical,
            "critical_required_doses": str(needs[critical]),
            "critical_stock": str(stocks[critical]),
            "path": str(path),
        })
    return rows


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("--timeout", type=float, default=60.0)
    parser.add_argument("--memory-mb", type=int, default=12288)
    parser.add_argument("--instances", nargs="+", default=["p002", "p004"])
    parser.add_argument("--output", default="results/controlled-barman")
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    for instance in args.instances:
        if instance not in {"p001", "p002", "p003", "p004"}:
            raise SystemExit(f"unsupported instance: {instance}")
    stamp = datetime.now().strftime("%Y%m%d-%H%M%S-%f")
    output_root = Path(args.output)
    if not output_root.is_absolute():
        output_root = ROOT / output_root
    label = "-".join(args.instances)
    run_dir = core.unique_run_dir(output_root.resolve(), f"horizon-stock-{label}-{stamp}")
    input_dir = run_dir / "inputs"
    input_dir.mkdir(parents=True)

    variants = []
    for instance in args.instances:
        variants.extend(make_variants(
            ROOT / "changmin_benchmark" / "05_barman" / "instances" / f"{instance}.pddl",
            input_dir,
        ))
    with (run_dir / "variants.csv").open("w", newline="", encoding="utf-8") as handle:
        fields = list(variants[0])
        writer = csv.DictWriter(handle, fieldnames=fields)
        writer.writeheader()
        writer.writerows(variants)

    benchmark = dict(core.benchmark_map()["changmin_05_barman"])
    benchmark["id"] = "controlled_barman"
    capabilities = core.planner_map()
    results = []
    work = [(config, variant) for config in CONFIGURATIONS for variant in variants]
    print(f"results: {run_dir.relative_to(ROOT)}", flush=True)
    print("progress\tplanner\theuristic\tvariant\tstatus\tvalidation\twall\texpanded\tobjective", flush=True)
    started = time.monotonic()
    for index, (config, variant) in enumerate(work, start=1):
        def builder(domain: Path, problem: Path, selected: Configuration = config) -> list[str]:
            return build_command(
                ROOT, selected.planner, domain, problem,
                selected.heuristic, selected.search, selected.options,
            )

        row = core.run_case(
            run_dir=run_dir,
            planner=config.planner,
            entry=benchmark,
            problem=Path(variant["path"]),
            capability=capabilities[config.planner],
            timeout=args.timeout,
            force=False,
            dry_run=False,
            validate_plans=True,
            memory_limit_mb=args.memory_mb,
            process_limit=256,
            log_limit_mb=64,
            monitor_interval=0.2,
            configuration_id=config.identifier,
            heuristic=config.heuristic,
            search=config.search,
            command_builder=builder,
        )
        row["instance"] = variant["variant"]
        row["source_instance"] = variant["source_instance"]
        row["horizon"] = variant["horizon"]
        row["stock_regime"] = variant["stock_regime"]
        row["critical_ingredient"] = variant["critical_ingredient"]
        row["critical_required_doses"] = variant["critical_required_doses"]
        row["critical_stock"] = variant["critical_stock"]
        results.append(row)
        print(
            f"[{index}/{len(work)}]\t{config.planner}\t{config.heuristic}\t{variant['variant']}\t"
            f"{row['status']}\t{row['validation']}\t{row['wall_seconds']}\t"
            f"{row['expanded_nodes']}\t{row['objective_value']}",
            flush=True,
        )

    extras = [
        "source_instance", "horizon", "stock_regime", "critical_ingredient",
        "critical_required_doses", "critical_stock",
    ]
    with (run_dir / "results.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(core.RESULT_COLUMNS) + extras)
        writer.writeheader()
        writer.writerows(results)
    metadata = {
        "created_at": datetime.now(timezone.utc).isoformat(),
        "source_instances": args.instances,
        "timeout_seconds": args.timeout,
        "memory_limit_mb": args.memory_mb,
        "case_count": len(work),
        "runner_wall_seconds": round(time.monotonic() - started, 6),
        "stock_regimes": {
            "abundant": "three times the minimum required stock",
            "boundary": "exact minimum required stock",
            "one-short": "one dose below minimum for the busiest ingredient",
            "blocked-zero": "zero stock for the busiest required ingredient",
        },
    }
    (run_dir / "manifest.json").write_text(json.dumps(metadata, indent=2) + "\n", encoding="utf-8")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
