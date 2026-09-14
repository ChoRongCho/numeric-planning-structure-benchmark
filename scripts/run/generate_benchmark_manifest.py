#!/usr/bin/env python3
"""Generate the deterministic benchmark catalog used by benchmarkctl."""

from __future__ import annotations

import hashlib
import json
import re
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
BENCHMARKS = ROOT / "benchmarks"
CHANGMIN_BENCHMARKS = ROOT / "changmin_benchmark"
OUTPUT = BENCHMARKS / "manifest.yaml"


def uncommented(text: str) -> str:
    return re.sub(r";[^\n]*", "", text)


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def source_for(number: int) -> str:
    if number <= 16:
        return "internal"
    if number in (17, 38, 39):
        return "IPC-2004"
    return "IPC-2023"


def features(text: str) -> dict[str, bool | list[str]]:
    clean = uncommented(text).lower()
    requirement_match = re.search(r"\(\s*:requirements\s+([^)]*)\)", clean, re.S)
    requirements = re.findall(r":[a-z0-9_-]+", requirement_match.group(1)) if requirement_match else []
    requirement_set = set(requirements)
    adl = ":adl" in requirement_set
    return {
        "requirements": requirements,
        "numeric": bool(requirement_set & {":fluents", ":numeric-fluents", ":action-costs"}) or bool(re.search(r"\(\s*:functions\b|\(\s*(?:increase|decrease|assign|scale-up|scale-down)\b", clean)),
        "temporal": ":durative-actions" in requirement_set or bool(re.search(r"\(\s*:durative-action\b", clean)),
        "derived_predicates": ":derived-predicates" in requirement_set or bool(re.search(r"\(\s*:derived\b", clean)),
        "conditional_effects": adl or ":conditional-effects" in requirement_set or bool(re.search(r"\(\s*when\b", clean)),
        "quantified": adl or bool(requirement_set & {":quantified-preconditions", ":existential-preconditions", ":universal-preconditions"}) or bool(re.search(r"\(\s*(?:forall|exists)\b", clean)),
        "disjunctive": adl or ":disjunctive-preconditions" in requirement_set or bool(re.search(r"\(\s*or\b", clean)),
        "action_costs": ":action-costs" in requirements,
    }


def main() -> int:
    entries = []
    collections = (
        (BENCHMARKS, "", None),
        (CHANGMIN_BENCHMARKS, "changmin_", "changmin-robot-benchmark"),
    )
    for collection_root, id_prefix, fixed_source in collections:
        for directory in sorted(path for path in collection_root.iterdir() if path.is_dir()):
            match = re.match(r"(\d+)_", directory.name)
            if not match:
                continue
            domain = directory / "domain.pddl"
            if not domain.is_file():
                # 07_laboratory is intentionally outside the active scope.
                continue
            instances = sorted((directory / "instances").glob("*.pddl"))
            if not instances:
                continue
            instance_digest = hashlib.sha256()
            for instance in instances:
                instance_digest.update(instance.name.encode())
                instance_digest.update(instance.read_bytes())
            entries.append(
                {
                    "id": id_prefix + directory.name,
                    "source": fixed_source or source_for(int(match.group(1))),
                    "domain": str(domain.relative_to(ROOT)),
                    "instances_glob": str((directory / "instances" / "*.pddl").relative_to(ROOT)),
                    "instance_count": len(instances),
                    "domain_sha256": sha256(domain),
                    "instance_set_sha256": instance_digest.hexdigest(),
                    "features": features(domain.read_text()),
                }
            )
    payload = {
        "schema_version": 1,
        "benchmark_count": len(entries),
        "problem_count": sum(entry["instance_count"] for entry in entries),
        "benchmarks": entries,
    }
    # JSON is valid YAML 1.2 and keeps the runtime dependency-free.
    OUTPUT.write_text(json.dumps(payload, indent=2, ensure_ascii=False) + "\n")
    print(f"wrote {OUTPUT.relative_to(ROOT)}: {payload['benchmark_count']} domains, {payload['problem_count']} problems")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
