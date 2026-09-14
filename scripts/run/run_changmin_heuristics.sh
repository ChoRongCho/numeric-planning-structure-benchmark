#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

if [[ $# -eq 0 ]]; then
    set -- p000
fi

exec python3 "$script_dir/heuristic_matrix.py" "$@"
