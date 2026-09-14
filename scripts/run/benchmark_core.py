#!/usr/bin/env python3
"""Reproducible benchmark runner for the local numeric planner collection."""

from __future__ import annotations

import argparse
import csv
import hashlib
import json
import os
import re
import shutil
import signal
import subprocess
import sys
import time
from concurrent.futures import ThreadPoolExecutor, as_completed
from datetime import datetime, timezone
from pathlib import Path
from typing import Any, Callable

sys.dont_write_bytecode = True

from planner_adapters import classify, command, extract_plan, metric_value, render_plan


ROOT = Path(__file__).resolve().parents[2]
MANIFEST = ROOT / "benchmarks" / "manifest.yaml"
CAPABILITIES = ROOT / "planners" / "capabilities.json"
PLANNERCTL = ROOT / "planners" / "plannerctl"
VAL_PARSER = ROOT / "planners" / "external" / "dino" / "src" / "VAL-master" / "parser"
VAL_VALIDATE = ROOT / "planners" / "external" / "dino" / "src" / "VAL-master" / "validate"
RESULT_COLUMNS = (
    "planner", "configuration", "heuristic", "search", "benchmark", "instance",
    "status", "compatible", "return_code",
    "wall_seconds", "max_rss_kb", "peak_group_rss_kb", "limit_reason",
    "plan_length", "expanded_nodes", "metric_value", "objective_value",
    "validation", "plan_path", "case_directory",
)


def load_json(path: Path) -> dict[str, Any]:
    try:
        return json.loads(path.read_text())
    except FileNotFoundError as error:
        raise SystemExit(f"Missing {path.relative_to(ROOT)}; run scripts/run/generate_benchmark_manifest.py") from error


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def display_path(path: Path) -> str:
    try:
        return str(path.relative_to(ROOT))
    except ValueError:
        return str(path)


def benchmark_map() -> dict[str, dict[str, Any]]:
    entries = load_json(MANIFEST)["benchmarks"]
    stale = []
    for entry in entries:
        domain = ROOT / entry["domain"]
        instances = sorted(ROOT.glob(entry["instances_glob"]))
        digest = hashlib.sha256()
        for instance in instances:
            digest.update(instance.name.encode())
            digest.update(instance.read_bytes())
        if not domain.is_file() or sha256(domain) != entry["domain_sha256"]:
            stale.append(f"{entry['id']}: domain changed")
        if len(instances) != entry["instance_count"] or digest.hexdigest() != entry["instance_set_sha256"]:
            stale.append(f"{entry['id']}: instances changed")
    if stale:
        raise SystemExit("Stale benchmark manifest; run scripts/run/generate_benchmark_manifest.py\n" + "\n".join(stale))
    return {entry["id"]: entry for entry in entries}


def planner_map() -> dict[str, dict[str, Any]]:
    return load_json(CAPABILITIES)["planners"]


def compatibility(entry: dict[str, Any], capability: dict[str, Any]) -> tuple[bool, list[str]]:
    if not capability.get("batch_enabled"):
        return False, [f"not batch-enabled ({capability.get('kind', 'no adapter')})"]
    missing = []
    features = entry["features"]
    if capability.get("requires_temporal") and not features.get("temporal"):
        missing.append("planner-requires-temporal-domain")
    for feature in ("numeric", "temporal", "derived_predicates", "conditional_effects", "quantified", "disjunctive"):
        if features.get(feature) and not capability.get(feature, False):
            missing.append(feature)
    return not missing, missing


def runtime_status(planner: str) -> str:
    result = subprocess.run(
        [str(PLANNERCTL), "status", planner], text=True, stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT, cwd=ROOT, check=False,
    )
    fields = result.stdout.strip().split("\t")
    return fields[1] if len(fields) > 1 else "unknown"


def unique_run_dir(base: Path, requested: str | None) -> Path:
    stem = requested or datetime.now().strftime("%Y%m%d-%H%M%S")
    candidate = base / stem
    suffix = 2
    while candidate.exists():
        candidate = base / f"{stem}-{suffix}"
        suffix += 1
    candidate.mkdir(parents=True)
    return candidate


def parse_metrics(path: Path, fallback_wall: float) -> tuple[str, str]:
    values: dict[str, str] = {}
    if path.exists():
        for line in path.read_text(errors="replace").splitlines():
            key, separator, value = line.partition("=")
            if separator:
                values[key] = value
    # GNU time's %e is normally limited to centiseconds and reports very fast
    # planners as 0.00.  The monotonic runner clock keeps microsecond precision;
    # GNU time remains the source for peak RSS.
    return f"{fallback_wall:.6f}", values.get("max_rss_kb", "")


def process_group_usage(pgid: int) -> tuple[int, int]:
    """Return aggregate RSS in KiB and process count for a Linux process group."""
    total_rss_kb = 0
    process_count = 0
    for entry in Path("/proc").iterdir():
        if not entry.name.isdigit():
            continue
        try:
            stat = (entry / "stat").read_text(errors="replace")
            # After the final ')' the fields begin with state, ppid, pgrp.
            fields = stat[stat.rfind(")") + 2 :].split()
            if len(fields) < 3 or int(fields[2]) != pgid:
                continue
            process_count += 1
            for line in (entry / "status").read_text(errors="replace").splitlines():
                if line.startswith("VmRSS:"):
                    total_rss_kb += int(line.split()[1])
                    break
        except (FileNotFoundError, PermissionError, ProcessLookupError, ValueError):
            continue
    return total_rss_kb, process_count


def terminate_process_group(process: subprocess.Popen[str]) -> None:
    if process.poll() is not None:
        return
    try:
        os.killpg(process.pid, signal.SIGTERM)
    except ProcessLookupError:
        return
    try:
        process.wait(timeout=2)
    except subprocess.TimeoutExpired:
        try:
            os.killpg(process.pid, signal.SIGKILL)
        except ProcessLookupError:
            pass
        process.wait()


def execute(
    argv: list[str], cwd: Path, timeout: float, log: Path, metrics: Path,
    memory_limit_mb: int | None = None,
    process_limit: int | None = None,
    log_limit_mb: int | None = None,
    monitor_interval: float = 0.2,
) -> tuple[int | None, bool, float, str, int]:
    timed = ["/usr/bin/time", "-f", "wall_seconds=%e\\nmax_rss_kb=%M\\nexit_code=%x", "-o", str(metrics), *argv]
    started = time.monotonic()
    timed_out = False
    limit_reason = ""
    peak_group_rss_kb = 0
    memory_limit_kb = memory_limit_mb * 1024 if memory_limit_mb is not None else None
    log_limit_bytes = log_limit_mb * 1024 * 1024 if log_limit_mb is not None else None
    with log.open("w") as output:
        process = subprocess.Popen(
            timed, cwd=cwd, stdout=output, stderr=subprocess.STDOUT, text=True,
            start_new_session=True, env={**os.environ, "LC_ALL": "C"},
        )
        while process.poll() is None:
            elapsed = time.monotonic() - started
            rss_kb, process_count = process_group_usage(process.pid)
            peak_group_rss_kb = max(peak_group_rss_kb, rss_kb)
            if memory_limit_kb is not None and rss_kb > memory_limit_kb:
                limit_reason = "memory-limit"
            elif process_limit is not None and process_count > process_limit:
                limit_reason = "process-limit"
            elif log_limit_bytes is not None and log.stat().st_size > log_limit_bytes:
                limit_reason = "output-limit"
            elif elapsed >= timeout:
                timed_out = True
                limit_reason = "timeout"
            if limit_reason:
                terminate_process_group(process)
                break
            time.sleep(monitor_interval)
        if process.poll() is None:
            process.wait()
        returncode = None if timed_out else process.returncode
    return returncode, timed_out, time.monotonic() - started, limit_reason, peak_group_rss_kb


def validate_plan(domain: Path, problem: Path, plan: Path, log: Path) -> str:
    if not VAL_VALIDATE.is_file():
        return "validator-missing"
    result = subprocess.run(
        [str(VAL_VALIDATE), str(domain), str(problem), str(plan)], text=True,
        stdout=subprocess.PIPE, stderr=subprocess.STDOUT, cwd=plan.parent, check=False,
    )
    log.write_text(result.stdout)
    lower = result.stdout.lower()
    if "plan valid" in lower or "successful plans: 1" in lower:
        return "valid"
    if "plan failed" in lower or "failed plans:" in lower or "bad plan description" in lower or "successful plans: 0" in lower or "invalid" in lower:
        return "invalid"
    return "validator-error" if result.returncode else "unknown"


def val_objective_value(validation_log: Path) -> str:
    """Read the PDDL metric value calculated independently by VAL."""
    if not validation_log.is_file():
        return ""
    matches = re.findall(
        r"(?:Final value|Value):\s*([-+]?(?:\d+(?:\.\d*)?|\.\d+)(?:[eE][-+]?\d+)?)",
        validation_log.read_text(errors="replace"),
    )
    return matches[0] if matches else ""


def expanded_nodes(output: str) -> str:
    """Normalize an expanded-state counter when a planner reports one."""
    patterns = (
        r"Expanded Nodes:\s*(\d+)",
        r"Expanded\s+(\d+)\s+state\(s\)\.",
        r"\b(\d+)\s+expanded\b",
        r"expanded nodes?\s*[:=]\s*(\d+)",
    )
    for pattern in patterns:
        matches = re.findall(pattern, output, flags=re.IGNORECASE)
        if matches:
            return matches[-1]
    return ""


def run_case(
    run_dir: Path, planner: str, entry: dict[str, Any], problem: Path,
    capability: dict[str, Any], timeout: float, force: bool, dry_run: bool,
    validate_plans: bool = True, extra_args: list[str] | None = None,
    memory_limit_mb: int | None = None, process_limit: int | None = None,
    log_limit_mb: int | None = None, monitor_interval: float = 0.2,
    configuration_id: str = "", heuristic: str = "", search: str = "",
    command_builder: Callable[[Path, Path], list[str]] | None = None,
) -> dict[str, str]:
    benchmark = entry["id"]
    case_root = run_dir / "cases" / planner
    if configuration_id:
        case_root /= configuration_id
    case_dir = case_root / benchmark / problem.stem
    case_dir.mkdir(parents=True, exist_ok=True)
    work = case_dir / "work"
    work.mkdir()
    domain_copy = work / "domain.pddl"
    problem_copy = work / "problem.pddl"
    shutil.copy2(ROOT / entry["domain"], domain_copy)
    shutil.copy2(problem, problem_copy)
    if planner == "crikey2":
        for path in (domain_copy, problem_copy):
            path.write_text(re.sub(r";[^\n]*", "", path.read_text(errors="replace")))
    compatible, reasons = compatibility(entry, capability)
    argv = (
        command_builder(domain_copy.resolve(), problem_copy.resolve())
        if command_builder is not None
        else command(ROOT, planner, domain_copy.resolve(), problem_copy.resolve())
    )
    if command_builder is not None:
        if extra_args:
            argv.extend(extra_args)
    elif extra_args and planner in {"popf", "popf-static-v2", "optic", "optic-cplex"}:
        # These native planners require options before DOMAIN and PROBLEM.
        argv[3:3] = extra_args
    else:
        argv.extend(extra_args or [])
    (case_dir / "command.json").write_text(json.dumps(argv, indent=2) + "\n")
    base = {
        "planner": planner, "configuration": configuration_id,
        "heuristic": heuristic, "search": search,
        "benchmark": benchmark, "instance": problem.name,
        "compatible": str(compatible).lower(), "return_code": "", "wall_seconds": "0",
        "max_rss_kb": "", "peak_group_rss_kb": "", "limit_reason": "",
        "plan_length": "", "expanded_nodes": "", "metric_value": "",
        "objective_value": "", "validation": "not-run", "plan_path": "",
        "case_directory": display_path(case_dir),
    }
    if not compatible and not force:
        (case_dir / "runner.log").write_text("unsupported features: " + ", ".join(reasons) + "\n")
        return {**base, "status": "unsupported"}
    if dry_run:
        (case_dir / "runner.log").write_text("dry run\n")
        return {**base, "status": "dry-run"}
    log, metrics = case_dir / "planner.log", case_dir / "resource.txt"
    returncode, timed_out, measured_wall, limit_reason, peak_group_rss_kb = execute(
        argv, work, timeout, log, metrics, memory_limit_mb, process_limit,
        log_limit_mb, monitor_interval,
    )
    output = log.read_text(errors="replace")
    status = limit_reason or classify(returncode, timed_out, output)
    if timed_out and planner in {"optic", "optic-cplex", "popf", "popf-static-v2"}:
        # These planners may emit a valid incumbent and then continue searching
        # for a better solution until the outer limit stops them.  Preserve the
        # incumbent; limit_reason still records that optimality was not proved.
        incumbent = extract_plan(planner, output, domain_copy.read_text(errors="replace"))
        if incumbent:
            status = "solved"
    if timed_out and planner == "panino-lnp-sat" and "Found Plan:" in output:
        # The official SAT entry is an anytime process.  Preserve and validate
        # its incumbent when the experiment time limit stops the process.
        status = "solved"
    actions = extract_plan(planner, output, domain_copy.read_text(errors="replace")) if status == "solved" else []
    if planner == "pattint-bitwuzla" and returncode == 0 and (work / "pattint.plan").is_file():
        status = "solved"
        actions = [
            line.strip() for line in (work / "pattint.plan").read_text(errors="replace").splitlines()
            if line.strip().startswith("(") and line.strip().endswith(")")
        ]
    if planner.startswith("tamerlite-ipc2026-") and (work / "tamerlite.plan").is_file():
        # IPC anytime entries are normally stopped by the outer experiment
        # timeout; a complete incumbent written before that point is usable.
        actions = [
            line.strip() for line in (work / "tamerlite.plan").read_text(errors="replace").splitlines()
            if line.strip().startswith("(") and line.strip().endswith(")")
        ]
        if actions:
            status = "solved"
    if status == "solved" and (planner in {"numeric-fast-downward", "numeric-fast-downward-local"} or planner.startswith("count-downward-") or planner.startswith("lnm-plan-")):
        plan_candidates = list(work.glob("sas_plan*"))
        if plan_candidates:
            # Iterated Fast Downward configurations write sas_plan.1,
            # sas_plan.2, ...; the newest file is the final incumbent.
            sas_plan = max(plan_candidates, key=lambda path: path.stat().st_mtime_ns)
            actions = [
                line.strip() for line in sas_plan.read_text(errors="replace").splitlines()
                if line.strip().startswith("(") and line.strip().endswith(")")
            ]
    validation = "not-extracted" if status == "solved" else "not-run"
    plan: Path | None = None
    validation_log = case_dir / "validation.log"
    if actions and validate_plans:
        plan = case_dir / "plan.val"
        plan.write_text(render_plan(actions))
        validation = validate_plan(domain_copy, problem_copy, plan, validation_log)
    elif actions:
        validation = "disabled"
    wall, rss = parse_metrics(metrics, measured_wall)
    measured_rss_kb = int(rss) if rss.isdigit() else 0
    max_rss_kb = max(measured_rss_kb, peak_group_rss_kb)
    result = {
        **base, "status": status, "return_code": "timeout" if timed_out else str(returncode),
        "wall_seconds": wall, "max_rss_kb": str(max_rss_kb) if max_rss_kb else rss,
        "peak_group_rss_kb": str(peak_group_rss_kb), "limit_reason": limit_reason,
        "plan_length": str(len(actions)) if actions else "",
        "expanded_nodes": expanded_nodes(output),
        "metric_value": metric_value(output),
        "objective_value": val_objective_value(validation_log) if validation == "valid" else "",
        "validation": validation,
        "plan_path": display_path(plan) if plan is not None else "",
    }
    (case_dir / "result.json").write_text(json.dumps(result, indent=2) + "\n")
    return result


def select_cases(args: argparse.Namespace) -> tuple[list[str], list[dict[str, Any]], list[tuple[dict[str, Any], Path]]]:
    benchmarks, planners = benchmark_map(), planner_map()
    selected_planners = args.planners if hasattr(args, "planners") and args.planners else [args.planner]
    selected_benchmarks = args.benchmarks if hasattr(args, "benchmarks") and args.benchmarks else [args.benchmark]
    unknown_p = [name for name in selected_planners if name not in planners]
    unknown_b = [name for name in selected_benchmarks if name not in benchmarks]
    if unknown_p or unknown_b:
        raise SystemExit(f"Unknown selection: planners={unknown_p}, benchmarks={unknown_b}")
    cases = []
    for name in selected_benchmarks:
        entry = benchmarks[name]
        paths = sorted(ROOT.glob(entry["instances_glob"]))
        if getattr(args, "instance", None):
            paths = [path for path in paths if path.name == args.instance or path.stem == args.instance]
            if not paths:
                raise SystemExit(f"Instance not found in {name}: {args.instance}")
        elif getattr(args, "smoke", False):
            paths = paths[:1]
        cases.extend((entry, path) for path in paths)
    return selected_planners, [benchmarks[name] for name in selected_benchmarks], cases


def write_results(run_dir: Path, results: list[dict[str, str]], metadata: dict[str, Any]) -> None:
    results.sort(key=lambda row: (row["planner"], row["benchmark"], row["instance"]))
    with (run_dir / "results.csv").open("w", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=RESULT_COLUMNS)
        writer.writeheader()
        writer.writerows(results)
    metadata["status_counts"] = dict(collections_counter(row["status"] for row in results))
    metadata["completed_at"] = datetime.now(timezone.utc).isoformat()
    (run_dir / "manifest.json").write_text(json.dumps(metadata, indent=2) + "\n")


def collections_counter(values: Any) -> dict[str, int]:
    result: dict[str, int] = {}
    for value in values:
        result[value] = result.get(value, 0) + 1
    return result


def run_command(args: argparse.Namespace) -> int:
    selected_planners, selected_benchmarks, cases = select_cases(args)
    capabilities = planner_map()
    statuses = {planner: runtime_status(planner) for planner in selected_planners}
    unavailable = {p: s for p, s in statuses.items() if s != "verified-plan"}
    if unavailable and not args.dry_run:
        raise SystemExit("Non-runnable planner status: " + ", ".join(f"{p}={s}" for p, s in unavailable.items()))
    run_dir = unique_run_dir((ROOT / args.output).resolve(), args.run_id)
    metadata = {
        "schema_version": 1, "created_at": datetime.now(timezone.utc).isoformat(),
        "timeout_seconds": args.timeout, "jobs": args.jobs, "planners": selected_planners,
        "benchmarks": [entry["id"] for entry in selected_benchmarks], "runtime_status": statuses,
        "force_unsupported": args.force_unsupported, "dry_run": args.dry_run,
        "benchmark_manifest_sha256": sha256(MANIFEST),
    }
    tasks = [(planner, entry, problem) for planner in selected_planners for entry, problem in cases]
    results = []
    with ThreadPoolExecutor(max_workers=args.jobs) as executor:
        futures = {
            executor.submit(run_case, run_dir, planner, entry, problem, capabilities[planner], args.timeout, args.force_unsupported, args.dry_run): (planner, entry["id"], problem.name)
            for planner, entry, problem in tasks
        }
        for future in as_completed(futures):
            result = future.result()
            results.append(result)
            print(f"{result['planner']}\t{result['benchmark']}\t{result['instance']}\t{result['status']}\t{result['validation']}", flush=True)
    write_results(run_dir, results, metadata)
    print(f"results: {display_path(run_dir)}")
    bad = {"crash", "parse-error", "invalid", "unknown"}
    return 1 if any(row["status"] in bad or row["validation"] == "invalid" for row in results) else 0


def validate_pddl() -> int:
    if not VAL_PARSER.is_file():
        raise SystemExit(f"VAL parser missing: {VAL_PARSER}")
    bad = []
    total = 0
    for entry in benchmark_map().values():
        domain = ROOT / entry["domain"]
        for problem in sorted(ROOT.glob(entry["instances_glob"])):
            total += 1
            result = subprocess.run([str(VAL_PARSER), str(domain), str(problem)], text=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, check=False)
            match = re.search(r"Errors:\s*(\d+),\s*warnings:\s*(\d+)", result.stdout)
            errors, warnings = (int(match.group(1)), int(match.group(2))) if match else (-1, -1)
            if result.returncode or errors or warnings:
                bad.append((problem, result.returncode, errors, warnings))
    print(f"PDDL validation: {total - len(bad)}/{total} clean")
    for problem, rc, errors, warnings in bad:
        print(f"FAIL\t{problem.relative_to(ROOT)}\trc={rc}\terrors={errors}\twarnings={warnings}")
    return 1 if bad else 0


def list_benchmarks() -> None:
    for entry in benchmark_map().values():
        enabled = [name for name, cap in planner_map().items() if compatibility(entry, cap)[0]]
        flags = [name for name, value in entry["features"].items() if value is True]
        print(f"{entry['id']}\t{entry['instance_count']}\t{','.join(flags) or 'classical'}\t{','.join(enabled)}")


def list_planners() -> None:
    benchmarks = benchmark_map()
    capabilities = planner_map()
    result = subprocess.run(
        [str(PLANNERCTL), "list"], text=True, stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT, cwd=ROOT, check=True,
    )
    seen: set[str] = set()
    for line in result.stdout.splitlines():
        fields = line.split("\t")
        if len(fields) < 3:
            continue
        name, status, kind = fields[:3]
        capability = capabilities.get(name)
        compatible_count = (
            sum(compatibility(entry, capability)[0] for entry in benchmarks.values())
            if capability else 0
        )
        batch = bool(capability and capability.get("batch_enabled"))
        print(
            f"{name}\t{status}\t{kind}\tbatch={str(batch).lower()}"
            f"\tcompatible_domains={compatible_count}"
        )
        seen.add(name)
    # capabilities.json에 먼저 추가됐지만 plannerctl runtime에 아직 등록되지 않은
    # adapter도 목록에서 조용히 사라지지 않게 한다.
    for name, capability in capabilities.items():
        if name in seen:
            continue
        compatible_count = sum(compatibility(entry, capability)[0] for entry in benchmarks.values())
        print(
            f"{name}\tunregistered\t{capability.get('kind', 'unknown')}"
            f"\tbatch={str(bool(capability.get('batch_enabled'))).lower()}"
            f"\tcompatible_domains={compatible_count}"
        )


def list_sources() -> int:
    """List every acquired Git source, including libraries and datasets."""
    return subprocess.run([str(PLANNERCTL), "sources"], cwd=ROOT, check=False).returncode


def add_run_arguments(parser: argparse.ArgumentParser) -> None:
    parser.add_argument("--timeout", type=float, default=300)
    parser.add_argument("--jobs", type=int, default=1)
    parser.add_argument("--output", default="results/raw")
    parser.add_argument("--run-id")
    parser.add_argument("--force-unsupported", action="store_true")
    parser.add_argument("--dry-run", action="store_true")


def main() -> int:
    parser = argparse.ArgumentParser(prog="benchmarkctl")
    sub = parser.add_subparsers(dest="command", required=True)
    sub.add_parser("list", help="list benchmarks and compatible planners")
    sub.add_parser("planners", help="list all registered runtimes and batch status")
    sub.add_parser("sources", help="list all acquired Git sources")
    sub.add_parser("validate-pddl", help="parse every domain/problem pair with VAL")
    one = sub.add_parser("run", help="run one planner on one benchmark")
    one.add_argument("--planner", required=True)
    one.add_argument("--benchmark", required=True)
    one.add_argument("--instance")
    add_run_arguments(one)
    all_parser = sub.add_parser("run-all", help="run a planner/benchmark matrix")
    all_parser.add_argument("--planners", nargs="+", required=True)
    all_parser.add_argument("--benchmarks", nargs="+", required=True)
    all_parser.add_argument("--smoke", action="store_true", help="run only the first instance of each benchmark")
    add_run_arguments(all_parser)
    if len(sys.argv) == 1:
        parser.print_help()
        print("\nQuick start:")
        print("  ./benchmarkctl planners")
        print("  ./benchmarkctl sources")
        print("  ./benchmarkctl list")
        print("  ./benchmarkctl validate-pddl")
        print("  ./benchmarkctl run --planner enhsp --benchmark 19_COUNTERS --instance p001")
        return 0
    args = parser.parse_args()
    if args.command == "list":
        list_benchmarks(); return 0
    if args.command == "planners":
        list_planners(); return 0
    if args.command == "sources":
        return list_sources()
    if args.command == "validate-pddl":
        return validate_pddl()
    return run_command(args)


if __name__ == "__main__":
    raise SystemExit(main())
