#!/usr/bin/env python3
"""Run the published Numeric CEGAR configurations locally, without Slurm or Lab."""

import argparse
import ast
import csv
from datetime import datetime
import hashlib
import json
import re
from pathlib import Path

from benchmark_core import ROOT, RESULT_COLUMNS, planner_map, run_case
from generate_benchmark_manifest import features


def literal_assignment(path, name):
    for node in ast.parse(path.read_text()).body:
        if isinstance(node, ast.Assign) and any(
            isinstance(target, ast.Name) and target.id == name for target in node.targets
        ):
            return ast.literal_eval(node.value)
    raise ValueError(f"Missing {name} in {path}")


def main():
    original = ROOT / "experiment-scripts"
    configs = dict(literal_assignment(original / "experiment.py", "CONFIG_NICKS"))
    suite = literal_assignment(original / "common_setup.py", "DEFAULT_NUMERIC_SUITE")
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--configs", nargs="+", default=["cegar-min"],
                        choices=[*configs, "all"])
    parser.add_argument("--domains", nargs="+", default=["counters"])
    parser.add_argument("--suite", action="store_true", help="Use the author's full domain suite")
    parser.add_argument("--problems", default="pfile1.pddl", help="Filename glob, e.g. '*.pddl'")
    parser.add_argument("--timeout", type=float, default=1800, help="Wall seconds per case")
    parser.add_argument("--memory-mb", type=int, default=3947)
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args()
    if args.timeout <= 0 or args.memory_mb <= 0:
        parser.error("timeout and memory must be positive")
    selected = list(configs) if "all" in args.configs else list(dict.fromkeys(args.configs))
    tasks = []
    for name in dict.fromkeys(suite if args.suite else args.domains):
        directory = ROOT / "benchmarks-oo" / name
        domain = directory / "domain.pddl"
        if not domain.is_file():
            parser.error(f"Domain not found: {domain}")
        problems = sorted(p for p in directory.glob(args.problems)
                          if p.is_file() and p.suffix == ".pddl" and p != domain
                          and re.search(r"\(\s*problem\s", p.read_text(), re.I))
        if not problems:
            parser.error(f"No problems matching {args.problems} in {directory}")
        entry = {"id": name, "domain": str(domain.relative_to(ROOT)),
                 "features": features(domain.read_text())}
        tasks.extend((entry, problem) for problem in problems)
    if not args.dry_run and not (ROOT / "numeric-fast-downward/builds/release64/bin/downward").is_file():
        parser.error("Build first: python3 numeric-fast-downward/build.py release64 -j4")
    run_dir = ROOT / "results/raw" / datetime.now().strftime("numeric-cegar-%Y%m%d-%H%M%S-%f")
    run_dir.mkdir(parents=True)
    manifest = {
        "artifact": "https://zenodo.org/records/18999077", "arguments": vars(args),
        "configurations": {key: configs[key] for key in selected},
        "experiment_sha256": hashlib.sha256((original / "experiment.py").read_bytes()).hexdigest(),
        "tasks": [{"domain": entry["domain"], "problem": str(problem.relative_to(ROOT)),
                   "domain_sha256": hashlib.sha256((ROOT / entry["domain"]).read_bytes()).hexdigest(),
                   "problem_sha256": hashlib.sha256(problem.read_bytes()).hexdigest()}
                  for entry, problem in tasks],
        "note": "Original search settings; local wall timeout and memory monitoring, not Slurm CPU limits",
    }
    (run_dir / "manifest.json").write_text(json.dumps(manifest, indent=2) + "\n")
    print(run_dir, flush=True)
    failed = False
    with (run_dir / "results.csv").open("w", newline="") as stream:
        writer = csv.DictWriter(stream, fieldnames=RESULT_COLUMNS)
        writer.writeheader()
        for config in selected:
            for entry, problem in tasks:
                def build(domain, instance):
                    return [str(ROOT / "planners/plannerctl"), "run", "numeric-cegar",
                            str(domain), str(instance), *configs[config]]
                result = run_case(
                    run_dir, "numeric-cegar", entry, problem, planner_map()["numeric-cegar"],
                    args.timeout, False, args.dry_run, memory_limit_mb=args.memory_mb,
                    configuration_id=config, heuristic=config, search="astar", command_builder=build,
                )
                writer.writerow(result)
                stream.flush()
                print(config, entry["id"], problem.name, result["status"], result["validation"], flush=True)
                if not args.dry_run and (result["status"] != "solved" or result["validation"] != "valid"):
                    failed = True
    return int(failed)


if __name__ == "__main__":
    raise SystemExit(main())
