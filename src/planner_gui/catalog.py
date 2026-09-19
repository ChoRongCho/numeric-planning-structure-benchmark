"""Discover selectable PDDL domains and instances from project collections."""

from __future__ import annotations

from dataclasses import dataclass
from pathlib import Path
import re


@dataclass(frozen=True)
class DomainEntry:
    label: str
    domain: Path
    problems: tuple[Path, ...]
    collection: str


def natural_key(path: Path) -> tuple[object, ...]:
    return tuple(int(part) if part.isdigit() else part.lower()
                 for part in re.split(r"(\d+)", path.name))


def problems_for(domain: Path) -> tuple[Path, ...]:
    instances = domain.parent / "instances"
    if not instances.is_dir():
        instances = domain.parent
    return tuple(sorted(
        (path for path in instances.glob("p*.pddl") if path.is_file()),
        key=natural_key,
    ))


def discover_catalog(root: Path) -> tuple[DomainEntry, ...]:
    """Merge the benchmark and changmin benchmark domain collections."""
    entries: list[DomainEntry] = []
    collections = (
        ("benchmarks", root / "benchmarks"),
        ("changmin", root / "changmin_benchmark"),
        ("numeric-cegar-paper", root / "benchmarks-oo"),
    )
    for collection, directory in collections:
        for domain in sorted(directory.glob("*/domain.pddl"), key=lambda path: natural_key(path.parent)):
            problems = problems_for(domain)
            label = f"[{collection}] {domain.parent.name} — {len(problems)} instance(s)"
            entries.append(DomainEntry(label, domain.resolve(), problems, collection))
    return tuple(entries)

