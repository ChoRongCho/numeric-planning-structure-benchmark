#!/usr/bin/env python3
"""Run the Changmin benchmark over every locally exposed heuristic.

This driver deliberately varies one factor: the heuristic.  Each planner's
search algorithm and auxiliary options are held at the baseline declared in
CONFIG_BASELINES below.  Planners without a selectable state heuristic get a
single fixed configuration.
"""

from __future__ import annotations

import argparse
import csv
import json
import os
import re
import sys
import time
from concurrent.futures import ThreadPoolExecutor, as_completed
from dataclasses import dataclass
from datetime import datetime, timezone
from pathlib import Path

sys.dont_write_bytecode = True

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(HERE))
sys.path.insert(0, str(ROOT / "src" / "planner_gui"))

import benchmark_core as core
from profiles import PROFILE_BY_ID, build_command


PLANNERS = (
    "enhsp",
    "metric-ff-cross-v1",
    "count-downward-agile",
    "planforge-ipc2026",
    "patty-ipc2026-agile-1",
    "panino-lnp-agile",
    "tamerlite-ipc2026-agile-1",
    "pattint-bitwuzla",
    "tempest-numeric-ipc2026",
    "optic",
    "optic-cplex",
    "popf-static-v2",
    "numeric-fast-downward-local",
)

BENCHMARKS = tuple(f"changmin_0{index}_{name}" for index, name in (
    (1, "blocksworld"),
    (2, "logistics"),
    (3, "books"),
    (4, "watering"),
    (5, "barman"),
    (6, "assembly"),
))

# Domain-specific exclusions confirmed by the p000 compatibility smoke.
# These cases never enter search, so they are N/A rather than performance
# failures. Keep this matrix in sync with
# docs/11_다음_작업/07_도메인별_Planner_Heuristic_실험_여부.md.
PLANFORGE_BARMAN_UNSUPPORTED = frozenset({
    "greedy_numeric_pdb",
    "canonical_numeric_pdb",
    "domain_abstraction",
    "canonical_domain_abstractions",
    "multi_domain_abstractions",
    "scp_online",
    "fill_scp",
})

PARSER_INCOMPATIBLE = frozenset({
    ("patty-ipc2026-agile-1", "changmin_01_blocksworld"),
    ("patty-ipc2026-agile-1", "changmin_02_logistics"),
    ("pattint-bitwuzla", "changmin_01_blocksworld"),
    ("pattint-bitwuzla", "changmin_02_logistics"),
})

# Search and non-heuristic options remain fixed so that comparisons within a
# planner measure the selected heuristic rather than a full Cartesian product.
CONFIG_BASELINES: dict[str, tuple[str, dict[str, str]]] = {
    "enhsp": ("WAStar", {"helpful": "default", "ties": "arbitrary"}),
    "metric-ff-cross-v1": ("default", {"helpful": "true"}),
    "count-downward-agile": ("alias", {}),
    "planforge-ipc2026": ("astar", {}),
    "patty-ipc2026-agile-1": (
        "jair", {"pattern": "enhanced", "solver": "z3", "quality": "none"}
    ),
    "panino-lnp-agile": ("fixed", {}),
    "tamerlite-ipc2026-agile-1": ("gbfs", {"weight": "1"}),
    "pattint-bitwuzla": ("fixed", {"pattern": "arpg", "encoding": "non-linear"}),
    "tempest-numeric-ipc2026": ("fixed", {}),
    # No -N: OPTIC is allowed to optimize the PDDL metric.
    "optic": ("default", {"helpful": "true"}),
    "optic-cplex": ("default", {"helpful": "true", "optimize": "true"}),
    # -n: preserve the best incumbent when the outer timeout stops POPF.
    "popf-static-v2": ("default", {"helpful": "true", "optimize": "true"}),
    "numeric-fast-downward-local": ("astar", {}),
}


@dataclass(frozen=True)
class Configuration:
    planner: str
    configuration_id: str
    heuristic: str
    search: str
    options: dict[str, str]


def safe_id(value: str) -> str:
    return re.sub(r"[^A-Za-z0-9._-]+", "-", value).strip("-_").lower()


def configurations() -> list[Configuration]:
    result = []
    for planner in PLANNERS:
        profile = PROFILE_BY_ID[planner]
        search, options = CONFIG_BASELINES[planner]
        for heuristic in profile.heuristics:
            config_id = safe_id(f"h-{heuristic.value}__s-{search}")
            result.append(Configuration(planner, config_id, heuristic.value, search, options))
    return result


def exclusion_reason(config: Configuration, benchmark: str) -> str | None:
    if (config.planner, benchmark) in PARSER_INCOMPATIBLE:
        return "parser-incompatible"
    if (
        benchmark == "changmin_05_barman"
        and config.planner == "numeric-fast-downward-local"
        and config.heuristic == "numeric_pdb"
    ):
        return "unsupported-numeric-effect"
    if (
        benchmark == "changmin_05_barman"
        and config.planner == "planforge-ipc2026"
        and config.heuristic in PLANFORGE_BARMAN_UNSUPPORTED
    ):
        return "unsupported-numeric-effect"
    return None


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="13 planners x supported heuristics x 6 Changmin domains"
    )
    parser.add_argument(
        "scope", choices=("p000", "all", "p001", "p002", "p003", "p004"),
        help="p000 is the compatibility smoke; all selects p000 through p004",
    )
    parser.add_argument("--timeout", type=float, default=300.0)
    parser.add_argument("--jobs", type=int, default=1)
    parser.add_argument("--cpu-cores", type=int, default=2)
    parser.add_argument("--memory-mb", type=int, default=12288)
    parser.add_argument("--minimum-free-memory-mb", type=int, default=14336)
    parser.add_argument("--dry-run", action="store_true")
    parser.add_argument("--output", default="results/raw")
    parser.add_argument(
        "--planner", action="append", choices=PLANNERS,
        help="limit to one planner; repeat the option to select several",
    )
    parser.add_argument(
        "--heuristic", action="append",
        help="limit to a heuristic value; repeat the option to select several",
    )
    return parser.parse_args()


def available_memory_mb() -> int:
    for line in Path("/proc/meminfo").read_text().splitlines():
        if line.startswith("MemAvailable:"):
            return int(line.split()[1]) // 1024
    raise SystemExit("Could not read MemAvailable from /proc/meminfo")


def main() -> int:
    args = parse_args()
    if args.timeout <= 0 or args.jobs <= 0 or args.cpu_cores <= 0 or args.memory_mb <= 0:
        raise SystemExit("timeout, jobs, cpu-cores, and memory-mb must be positive")

    allowed_cpus = sorted(os.sched_getaffinity(0))
    selected_cpus = allowed_cpus[: args.cpu_cores]
    os.sched_setaffinity(0, selected_cpus)
    current_nice = os.getpriority(os.PRIO_PROCESS, 0)
    if current_nice < 10:
        os.nice(10 - current_nice)

    available = available_memory_mb()
    if not args.dry_run and available < args.minimum_free_memory_mb:
        raise SystemExit(
            f"Only {available} MiB available; need {args.minimum_free_memory_mb} MiB to start"
        )

    benchmark_map = core.benchmark_map()
    capability_map = core.planner_map()
    missing_benchmarks = [name for name in BENCHMARKS if name not in benchmark_map]
    if missing_benchmarks:
        raise SystemExit(f"Benchmarks missing from manifest: {missing_benchmarks}")

    wanted = ["p000"] if args.scope == "p000" else (
        [args.scope] if args.scope != "all" else [f"p{i:03d}" for i in range(5)]
    )
    cases = []
    for benchmark in BENCHMARKS:
        entry = benchmark_map[benchmark]
        available_problems = {path.stem: path for path in sorted(ROOT.glob(entry["instances_glob"]))}
        absent = [problem for problem in wanted if problem not in available_problems]
        if absent:
            raise SystemExit(f"{benchmark} is missing instances: {absent}")
        cases.extend((entry, available_problems[problem]) for problem in wanted)

    configs = configurations()
    if args.planner:
        configs = [config for config in configs if config.planner in args.planner]
    if args.heuristic:
        configs = [config for config in configs if config.heuristic in args.heuristic]
    if not configs:
        raise SystemExit("No planner/heuristic configurations matched the filters")
    selected_planners = tuple(dict.fromkeys(config.planner for config in configs))
    statuses = {planner: core.runtime_status(planner) for planner in selected_planners}
    unavailable = {planner: status for planner, status in statuses.items() if status != "verified-plan"}
    if unavailable and not args.dry_run:
        raise SystemExit("Non-runnable planners: " + ", ".join(f"{p}={s}" for p, s in unavailable.items()))

    output_root = Path(args.output)
    if not output_root.is_absolute():
        output_root = ROOT / output_root
    stamp = datetime.now().strftime("%Y%m%d-%H%M%S-%f")
    run_dir = core.unique_run_dir(output_root.resolve(), f"changmin-heuristics-{args.scope}-{stamp}")
    candidate_work = [
        (config, entry, problem)
        for config in configs
        for entry, problem in cases
    ]
    excluded_work = [
        (config, entry, problem, reason)
        for config, entry, problem in candidate_work
        if (reason := exclusion_reason(config, entry["id"])) is not None
    ]
    work = [
        (config, entry, problem)
        for config, entry, problem in candidate_work
        if exclusion_reason(config, entry["id"]) is None
    ]
    metadata = {
        "schema_version": 1,
        "created_at": datetime.now(timezone.utc).isoformat(),
        "experiment_name": f"changmin-heuristics-{args.scope}",
        "scope": args.scope,
        "timeout_seconds": args.timeout,
        "jobs": args.jobs,
        "max_cpu_cores": args.cpu_cores,
        "cpu_affinity": selected_cpus,
        "nice_level": os.getpriority(os.PRIO_PROCESS, 0),
        "memory_limit_mb": args.memory_mb,
        "minimum_available_memory_mb": args.minimum_free_memory_mb,
        "available_memory_mb_at_start": available,
        "planners": list(selected_planners),
        "configuration_count": len(configs),
        "case_count": len(work),
        "candidate_case_count": len(candidate_work),
        "excluded_case_count": len(excluded_work),
        "exclusion_policy": {
            "parser-incompatible": "N/A",
            "unsupported-numeric-effect": "N/A",
        },
        "runtime_status": statuses,
        "dry_run": args.dry_run,
        "benchmark_manifest_sha256": core.sha256(core.MANIFEST),
    }
    (run_dir / "configurations.csv").parent.mkdir(parents=True, exist_ok=True)
    with (run_dir / "configurations.csv").open("w", newline="") as handle:
        writer = csv.DictWriter(
            handle, fieldnames=("planner", "configuration", "heuristic", "search", "options")
        )
        writer.writeheader()
        for config in configs:
            writer.writerow({
                "planner": config.planner,
                "configuration": config.configuration_id,
                "heuristic": config.heuristic,
                "search": config.search,
                "options": json.dumps(config.options, sort_keys=True),
            })

    with (run_dir / "excluded.csv").open("w", newline="") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=(
                "planner", "configuration", "heuristic", "search",
                "benchmark", "instance", "status", "reason",
            ),
        )
        writer.writeheader()
        for config, entry, problem, reason in excluded_work:
            writer.writerow({
                "planner": config.planner,
                "configuration": config.configuration_id,
                "heuristic": config.heuristic,
                "search": config.search,
                "benchmark": entry["id"],
                "instance": problem.name,
                "status": "N/A",
                "reason": reason,
            })

    def run_one(config: Configuration, entry: dict, problem: Path) -> dict[str, str]:
        def builder(domain: Path, instance: Path) -> list[str]:
            return build_command(
                ROOT, config.planner, domain, instance,
                config.heuristic, config.search, config.options,
            )

        return core.run_case(
            run_dir, config.planner, entry, problem, capability_map[config.planner],
            args.timeout, False, args.dry_run, True, None,
            args.memory_mb, 256, 64, 0.2,
            config.configuration_id, config.heuristic, config.search, builder,
        )

    results = []
    started = time.monotonic()
    terminal_path = run_dir / "terminal.log"
    with terminal_path.open("w", buffering=1) as terminal:
        def emit(message: str) -> None:
            print(message, flush=True)
            terminal.write(message + "\n")

        emit(f"experiment: changmin-heuristics-{args.scope}")
        emit(
            f"configurations: {len(configs)}; candidates: {len(candidate_work)}; "
            f"excluded_n/a: {len(excluded_work)}; cases: {len(work)}"
        )
        emit(
            f"resources: jobs={args.jobs}, cpu_affinity={selected_cpus}, "
            f"memory_limit_mb={args.memory_mb}, timeout_seconds={args.timeout}"
        )
        emit(f"results: {core.display_path(run_dir)}")
        emit("progress\tplanner\tconfiguration\tdomain\tproblem\tstatus\tvalidation\twall_seconds")
        with ThreadPoolExecutor(max_workers=args.jobs) as executor:
            futures = {
                executor.submit(run_one, config, entry, problem):
                    (config, entry["id"], problem.name)
                for config, entry, problem in work
            }
            for completed, future in enumerate(as_completed(futures), start=1):
                row = future.result()
                results.append(row)
                emit(
                    f"[{completed}/{len(work)}]\t{row['planner']}\t{row['configuration']}\t"
                    f"{row['benchmark']}\t{row['instance']}\t{row['status']}\t"
                    f"{row['validation']}\t{float(row['wall_seconds']):.3f}"
                )

    metadata["runner_wall_seconds"] = round(time.monotonic() - started, 6)
    core.write_results(run_dir, results, metadata)
    print(f"summary_csv: {core.display_path(run_dir / 'results.csv')}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
