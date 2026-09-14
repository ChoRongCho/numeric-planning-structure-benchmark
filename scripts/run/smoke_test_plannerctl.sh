#!/usr/bin/env bash
set -u

project_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
plannerctl="$project_root/planners/plannerctl"
log_root="$project_root/planners/download-logs"
status_file="$log_root/runtime-status.tsv"
numeric_domain="$project_root/planners/external/ipc2023-numeric-dataset/counters/domain.pddl"
numeric_problem="$project_root/planners/external/ipc2023-numeric-dataset/counters/instances/pfile1.pddl"
metric_domain="$project_root/planners/external/ipc2023-numeric-dataset/zenotravel/domain.pddl"
metric_problem="$project_root/planners/external/ipc2023-numeric-dataset/zenotravel/instances/pfile1.pddl"
temporal_domain="$project_root/domains/smoke/temporal/domain.pddl"
temporal_problem="$project_root/domains/smoke/temporal/problem.pddl"
omt_domain="$project_root/planners/external/omtplan/pddl_examples/benchmarks_IJCAI20/simple/counters/domain.pddl"
omt_problem="$project_root/planners/external/omtplan/pddl_examples/benchmarks_IJCAI20/simple/counters/instances/instance_2.pddl"
lpg_domain="$project_root/planners/runtime/lpg-td/LPG-td-1.4/FlawTIL-UMTS/domain.pddl"
lpg_problem="$project_root/planners/runtime/lpg-td/LPG-td-1.4/FlawTIL-UMTS/p10.pddl"

mkdir -p "$log_root"
: > "$status_file"
printf 'id\tstatus\tevidence\n' >> "$status_file"

solve_test() {
    planner_id="$1"
    shift
    if timeout 60 "$plannerctl" run "$planner_id" "$@" \
        > "$log_root/smoke-$planner_id.log" 2>&1; then
        printf '%s\tverified-plan\tsee smoke-%s.log\n' "$planner_id" "$planner_id" >> "$status_file"
    else
        rc=$?
        printf '%s\tfailed\texit %s; see smoke-%s.log\n' "$planner_id" "$rc" "$planner_id" >> "$status_file"
    fi
}

compiler_test() {
    planner_id="$1"
    shift
    if timeout 60 "$plannerctl" run "$planner_id" "$@" \
        > "$log_root/smoke-$planner_id.log" 2>&1; then
        printf '%s\tverified-compiler\tsee smoke-%s.log\n' "$planner_id" "$planner_id" >> "$status_file"
    else
        rc=$?
        printf '%s\tfailed\texit %s; see smoke-%s.log\n' "$planner_id" "$rc" "$planner_id" >> "$status_file"
    fi
}

start_test() {
    planner_id="$1"
    expected_text="$2"
    shift 2
    timeout 15 "$plannerctl" run "$planner_id" "$@" \
        > "$log_root/smoke-$planner_id.log" 2>&1 || true
    if grep -q "$expected_text" "$log_root/smoke-$planner_id.log"; then
        printf '%s\tverified-cli\tsee smoke-%s.log\n' "$planner_id" "$planner_id" >> "$status_file"
    else
        printf '%s\tfailed\texpected CLI output absent; see smoke-%s.log\n' "$planner_id" "$planner_id" >> "$status_file"
    fi
}

solve_test metric-ff -o "$metric_domain" -f "$metric_problem"
solve_test metric-ff-2.0 -o "$metric_domain" -f "$metric_problem"
solve_test enhsp -o "$numeric_domain" -f "$numeric_problem"
solve_test tamerlite "$numeric_domain" "$numeric_problem"
solve_test nextflap "$numeric_domain" "$numeric_problem"
solve_test lpg-td -o "$lpg_domain" -f "$lpg_problem" -n 1
solve_test crikey2 "$temporal_domain" "$temporal_problem"
solve_test omtplan -omt -parallel -domain "$omt_domain" "$omt_problem"
solve_test patty -o "$numeric_domain" -f "$numeric_problem"
solve_test springroll -o "$numeric_domain" -f "$numeric_problem"

mkdir -p "$project_root/planners/runtime/bitblast/smoke-output"
compiler_test bitblast "$numeric_domain" "$numeric_problem" \
    "$project_root/planners/runtime/bitblast/smoke-output" --bits 8 --base

start_test aries 'Aries, unified-planning server' --help
start_test fape 'Usage:' --help
start_test fape-1.0 'Usage:' --help
start_test sapa 'Need at least two arguments'

for planner_id in cpt crikey tsgp; do
    printf '%s\thost-blocked\t32-bit binary blocked by current sandbox seccomp\n' "$planner_id" >> "$status_file"
done
for planner_id in mips-xxl-seq mips-xxl-netben gamer-netben hspsp-netben sgplan6-seq sgplan6-seq-fixed sgplan6-temporal-fixed; do
    printf '%s\tbuild-blocked\tlegacy compiler/32-bit ABI incompatibility\n' "$planner_id" >> "$status_file"
done
printf 'tfd-ipc2008\truntime-blocked\tC++ core builds; bundled Python 2.5 lacks select module\n' >> "$status_file"

printf 'Smoke tests finished. See %s\n' "$status_file"
