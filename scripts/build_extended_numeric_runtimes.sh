#!/usr/bin/env bash
set -eu

project_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
external_root="$project_root/planners/external"
local_prefix="$project_root/planners/deps/local"
cargo_bin="$project_root/planners/toolchains/cargo/bin/cargo"
log_root="$project_root/planners/download-logs"

mkdir -p "$log_root"
export CMAKE_PREFIX_PATH="$local_prefix"
export PKG_CONFIG_PATH="$local_prefix/lib/pkgconfig"
export LD_LIBRARY_PATH="$local_prefix/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"

build_logged() {
    build_id="$1"
    build_dir="$2"
    shift 2
    printf 'building %s\n' "$build_id"
    (cd "$build_dir" && "$@") >"$log_root/build-extended-$build_id.log" 2>&1
}

# Maintained native temporal planners. COIN-OR and GSL are isolated under
# planners/deps/local and never installed into /usr.
cmake -S "$external_root/popf-maintained" -B "$external_root/popf-maintained/build" \
    -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH="$local_prefix"
cmake --build "$external_root/popf-maintained/build" -j4
cmake -S "$external_root/optic-maintained" -B "$external_root/optic-maintained/build" \
    -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH="$local_prefix"
cmake --build "$external_root/optic-maintained/build" -j4

# Rust planners use the repository-local Rust toolchain.
for planner_id in ferroplan planforge planforge-ipc2026 tempest-numeric-ipc2026; do
    build_logged "$planner_id" "$external_root/$planner_id" "$cargo_bin" build --release
done

# Numeric Fast Downward families. Their Python 3 compatibility patches are
# kept in each source tree and the build driver copies the translator.
for planner_id in numeric-fast-downward count-downward-ipc2026 \
    count-downward-together-ipc2026 lnm-plan-ipc2023; do
    build_logged "$planner_id" "$external_root/$planner_id" python3 build.py -j4
done

# Native SAT bridge plus its local Java PDDL-to-JSON bridge.
build_logged nplanning-ipc2026 "$external_root/nplanning-ipc2026" ./compile

printf 'extended numeric builds complete; logs: %s\n' "$log_root"
