#!/usr/bin/env python3
"""Run a locally isolated Unified Planning engine on two PDDL files."""

from __future__ import annotations

import argparse
import sys


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("engine", choices=("tamerlite", "nextflap", "tempest", "tempest-opt"))
    parser.add_argument("domain")
    parser.add_argument("problem")
    args = parser.parse_args()

    from unified_planning.io import PDDLReader

    problem = PDDLReader().parse_problem(args.domain, args.problem)
    if args.engine == "tamerlite":
        from tamerlite.engine import TamerLite

        engine = TamerLite()
    elif args.engine == "nextflap":
        from up_nextflap import NextFLAPImpl

        engine = NextFLAPImpl()
    elif args.engine == "tempest":
        from tempest.engine import TempestEngine

        engine = TempestEngine(incremental=True)
    else:
        from tempest.engine import TempestOptimal

        engine = TempestOptimal(incremental=True, sat_before_opt=True)

    result = engine.solve(problem)
    print(f"status: {result.status}", file=sys.stderr)
    if result.plan is not None:
        print(result.plan)
        return 0
    return 1


if __name__ == "__main__":
    raise SystemExit(main())
