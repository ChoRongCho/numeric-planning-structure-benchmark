#!/usr/bin/env bash
set -u

project_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
runtime_root="$project_root/planners/runtime"
external_root="$project_root/planners/external"
log_root="$project_root/planners/download-logs"
status_file="$log_root/build-status.tsv"

mkdir -p "$log_root"
: > "$status_file"
printf 'id\tstatus\tdetail\n' >> "$status_file"

run_build() {
    planner_id="$1"
    working_dir="$2"
    shift 2
    if (cd "$working_dir" && timeout 600 "$@") \
        > "$log_root/build-$planner_id.log" 2>&1; then
        printf '%s\tbuilt\tsee build-%s.log\n' "$planner_id" "$planner_id" >> "$status_file"
    else
        rc=$?
        printf '%s\tblocked\texit %s; see build-%s.log\n' "$planner_id" "$rc" "$planner_id" >> "$status_file"
    fi
}

run_build enhsp "$external_root/enhsp" ./compile
run_build tfd-ipc2008 \
    "$runtime_root/tempo-sat-temporal-fast-downward/tempo-sat-temporal-fast-downward" \
    bash build

# Copy freshly built ENHSP and create TFD's expected Python alias.
bash "$project_root/scripts/setup_numeric_runtimes.sh"

printf 'Build pass finished. See %s\n' "$status_file"
