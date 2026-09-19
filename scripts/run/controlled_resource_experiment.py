#!/usr/bin/env python3
"""Run matched 2x2 resource experiments on Changmin Watering and Logistics.

The script copies an existing problem and changes only the selected numeric
initial values.  Topology, objects, goals, action schemas, and every other
numeric value remain fixed within each four-instance block.
"""

from __future__ import annotations

import argparse
import csv
import json
import re
import sys
import time
from dataclasses import dataclass
from datetime import datetime, timezone
from pathlib import Path

sys.dont_write_bytecode = True

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(HERE))
sys.path.insert(0, str(ROOT / "src" / "planner_gui"))

import benchmark_core as core
from profiles import build_command


@dataclass(frozen=True)
class Configuration:
    planner: str
    heuristic: str
    search: str
    options: dict[str, str]

    @property
    def identifier(self) -> str:
        return f"h-{self.heuristic}__s-{self.search}".lower()


CONFIGURATIONS = (
    Configuration("metric-ff-cross-v1", "numeric-hff", "default", {"helpful": "true"}),
    Configuration("count-downward-agile", "irhff", "alias", {}),
    Configuration("numeric-fast-downward-local", "irhadd", "astar", {}),
    Configuration("enhsp", "hadd", "WAStar", {"helpful": "default", "ties": "arbitrary"}),
    Configuration("enhsp", "hradd", "WAStar", {"helpful": "default", "ties": "arbitrary"}),
)


def replace_scalar(text: str, fluent: str, value: int) -> str:
    pattern = rf"(\(=\s+\({re.escape(fluent)}\)\s+)[-+]?\d+(?:\.\d+)?(\s*\))"
    result, count = re.subn(pattern, rf"\g<1>{value}\g<2>", text)
    if count != 1:
        raise ValueError(f"expected one scalar assignment for {fluent}, found {count}")
    return result


def replace_object_fluent(text: str, fluent: str, value: int) -> str:
    pattern = rf"(\(=\s+\({re.escape(fluent)}\s+[^()\s]+\)\s+)[-+]?\d+(?:\.\d+)?(\s*\))"
    result, count = re.subn(pattern, rf"\g<1>{value}\g<2>", text)
    if count < 1:
        raise ValueError(f"no assignments found for {fluent}")
    return result


def assigned_values(text: str, fluent: str) -> list[int]:
    return [
        int(float(value))
        for value in re.findall(
            rf"\(=\s+\({re.escape(fluent)}(?:\s+[^()\s]+)?\)\s+([-+]?\d+(?:\.\d+)?)\s*\)",
            text,
        )
    ]


def watering_variants(source: Path, destination: Path) -> list[dict[str, str]]:
    text = source.read_text()
    demand = sum(assigned_values(text, "plant-demand"))
    tight_water = assigned_values(text, "container-capacity")[0]
    tight_battery = assigned_values(text, "battery-capacity")[0]
    loose_water = demand
    loose_battery = tight_battery * 3
    rows = []
    for water_label, water in (("loose", loose_water), ("tight", tight_water)):
        for battery_label, battery in (("loose", loose_battery), ("tight", tight_battery)):
            variant = replace_object_fluent(text, "container-capacity", water)
            variant = replace_object_fluent(variant, "battery-capacity", battery)
            variant = replace_object_fluent(variant, "battery-level", battery)
            name = f"watering__water-{water_label}__battery-{battery_label}"
            path = destination / f"{name}.pddl"
            path.write_text(variant)
            rows.append({
                "domain_group": "watering",
                "variant": name,
                "factor_a": water_label,
                "factor_b": battery_label,
                "water_capacity": str(water),
                "battery_capacity": str(battery),
                "source": str(source.relative_to(ROOT)),
                "path": str(path),
            })
    return rows


def logistics_variants(source: Path, destination: Path) -> list[dict[str, str]]:
    text = source.read_text()
    tight_fuel = max(assigned_values(text, "fuel-capacity"))
    tight_budget = assigned_values(text, "budget")[0]
    # A huge sentinel such as 1000 changes the interval range enough to become
    # a separate heuristic treatment.  Three times the original value removes
    # the intended binding constraint while keeping the numeric scale close.
    loose_fuel = tight_fuel * 3
    loose_budget = tight_budget * 3
    rows = []
    for fuel_label, fuel in (("loose", loose_fuel), ("tight", tight_fuel)):
        for budget_label, budget in (("loose", loose_budget), ("tight", tight_budget)):
            variant = replace_object_fluent(text, "fuel-capacity", fuel)
            variant = replace_object_fluent(variant, "fuel-level", fuel)
            variant = replace_scalar(variant, "budget", budget)
            name = f"logistics__fuel-{fuel_label}__budget-{budget_label}"
            path = destination / f"{name}.pddl"
            path.write_text(variant)
            rows.append({
                "domain_group": "logistics",
                "variant": name,
                "factor_a": fuel_label,
                "factor_b": budget_label,
                "fuel_capacity": str(fuel),
                "budget": str(budget),
                "source": str(source.relative_to(ROOT)),
                "path": str(path),
            })
    return rows


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("--timeout", type=float, default=60.0)
    parser.add_argument("--memory-mb", type=int, default=12288)
    parser.add_argument("--source-instance", default="p004", choices=("p001", "p002", "p003", "p004"))
    parser.add_argument("--domain-group", default="both", choices=("both", "watering", "logistics"))
    parser.add_argument("--output", default="results/controlled-resource")
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    stamp = datetime.now().strftime("%Y%m%d-%H%M%S-%f")
    output_root = Path(args.output)
    if not output_root.is_absolute():
        output_root = ROOT / output_root
    run_dir = core.unique_run_dir(output_root.resolve(), f"matched-2x2-{args.source_instance}-{stamp}")
    input_dir = run_dir / "inputs"
    input_dir.mkdir(parents=True)

    source_name = f"{args.source_instance}.pddl"
    variant_rows = []
    if args.domain_group in {"both", "watering"}:
        variant_rows.extend(watering_variants(
            ROOT / "changmin_benchmark" / "04_watering" / "instances" / source_name,
            input_dir,
        ))
    if args.domain_group in {"both", "logistics"}:
        variant_rows.extend(logistics_variants(
            ROOT / "changmin_benchmark" / "02_logistics" / "instances" / source_name,
            input_dir,
        ))
    with (run_dir / "variants.csv").open("w", newline="") as handle:
        fields = sorted({key for row in variant_rows for key in row})
        writer = csv.DictWriter(handle, fieldnames=fields)
        writer.writeheader()
        writer.writerows(variant_rows)

    benchmark_map = core.benchmark_map()
    capability_map = core.planner_map()
    domain_entries = {
        "watering": dict(benchmark_map["changmin_04_watering"]),
        "logistics": dict(benchmark_map["changmin_02_logistics"]),
    }
    results = []
    work = [(config, row) for config in CONFIGURATIONS for row in variant_rows]
    print(f"results: {run_dir.relative_to(ROOT)}", flush=True)
    print("progress\tplanner\theuristic\tvariant\tstatus\tvalidation\twall\texpanded\tobjective", flush=True)
    started = time.monotonic()
    for index, (config, variant) in enumerate(work, start=1):
        group = variant["domain_group"]
        entry = dict(domain_entries[group])
        entry["id"] = f"controlled_{group}"

        def builder(domain: Path, problem: Path, selected: Configuration = config) -> list[str]:
            return build_command(
                ROOT, selected.planner, domain, problem,
                selected.heuristic, selected.search, selected.options,
            )

        row = core.run_case(
            run_dir=run_dir,
            planner=config.planner,
            entry=entry,
            problem=Path(variant["path"]),
            capability=capability_map[config.planner],
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
        row["factor_a"] = variant["factor_a"]
        row["factor_b"] = variant["factor_b"]
        results.append(row)
        print(
            f"[{index}/{len(work)}]\t{config.planner}\t{config.heuristic}\t{variant['variant']}\t"
            f"{row['status']}\t{row['validation']}\t{row['wall_seconds']}\t"
            f"{row['expanded_nodes']}\t{row['objective_value']}",
            flush=True,
        )

    fields = list(core.RESULT_COLUMNS) + ["factor_a", "factor_b"]
    with (run_dir / "results.csv").open("w", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=fields)
        writer.writeheader()
        writer.writerows(results)
    metadata = {
        "created_at": datetime.now(timezone.utc).isoformat(),
        "source_instance": args.source_instance,
        "timeout_seconds": args.timeout,
        "memory_limit_mb": args.memory_mb,
        "case_count": len(work),
        "runner_wall_seconds": round(time.monotonic() - started, 6),
        "controlled_variables": {
            "watering": ["container-capacity", "battery-capacity", "battery-level"],
            "logistics": ["fuel-capacity", "fuel-level", "budget"],
        },
    }
    (run_dir / "manifest.json").write_text(json.dumps(metadata, indent=2) + "\n")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
