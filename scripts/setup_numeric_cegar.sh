#!/usr/bin/env bash
set -euo pipefail
project_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
for artifact_dir in numeric-fast-downward benchmarks-oo experiment-scripts; do
    if [ ! -d "$project_root/$artifact_dir" ]; then
        printf 'Missing %s. Extract the ICAPS 2026 artifact: https://zenodo.org/records/18999077\n' "$artifact_dir" >&2
        exit 1
    fi
done
python3 "$project_root/numeric-fast-downward/build.py" release64 "-j${BUILD_JOBS:-4}"
python3 "$project_root/scripts/run/numeric_cegar.py" --timeout 60
python3 - "$project_root" <<'PY'
from pathlib import Path
import sys

status = Path(sys.argv[1]) / "planners/download-logs/runtime-status.tsv"
status.parent.mkdir(parents=True, exist_ok=True)
rows = status.read_text().splitlines() if status.exists() else []
rows = [row for row in rows if row.split("\t")[0] != "numeric-cegar"]
rows.append("numeric-cegar\tverified-plan\tICAPS 2026 CEGAR; counters/pfile1 VAL-valid")
status.write_text("\n".join(rows) + "\n")
PY
