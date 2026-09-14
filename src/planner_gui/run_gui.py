#!/usr/bin/env python3
"""Launch the single-case planner GUI."""

try:
    from .app import main
except ImportError:
    from app import main


if __name__ == "__main__":
    raise SystemExit(main())
