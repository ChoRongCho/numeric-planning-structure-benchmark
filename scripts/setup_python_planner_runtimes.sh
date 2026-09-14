#!/usr/bin/env bash
set -eu

project_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
archive_root="$project_root/planners/archives"
runtime_root="$project_root/planners/runtime"
log_root="$project_root/planners/download-logs"

mkdir -p "$runtime_root" "$log_root"

make_runtime() {
    planner_id="$1"
    package_file="$2"
    site_dir="$runtime_root/$planner_id/site-packages"
    rm -rf "$runtime_root/$planner_id/venv"
    mkdir -p "$site_dir"
    python3 -m pip install --disable-pip-version-check --upgrade \
        --target "$site_dir" "$package_file" unified-planning >> "$log_root/python-runtime-install.log" 2>&1
}

make_runtime tamerlite "$archive_root/pypi/tamerlite/tamerlite-0.1.1-py3-none-any.whl"
rm -rf "$runtime_root/tamerlite/site-packages/pddl" \
    "$runtime_root/tamerlite/site-packages/pddl-0.4.10.dist-info"
python3 -m pip install --disable-pip-version-check --upgrade \
    --target "$runtime_root/tamerlite/site-packages" \
    'pyparsing>=3.0.0' 'networkx>=3.0' 'ConfigSpace>=1.2.2' \
    'pddl>=0.4.8' 'pysmt>=0.9.6' 'z3-solver>=4.13.0' \
    >> "$log_root/python-runtime-install.log" 2>&1
# pddl 0.4.10 duplicates grammar.lark through wheel .data; pip --target can
# leave only that data file. Overlay the wheel payload to retain its modules.
mkdir -p "$runtime_root/tamerlite/wheels"
python3 -m pip download --disable-pip-version-check --no-deps \
    --dest "$runtime_root/tamerlite/wheels" 'pddl==0.4.10' \
    >> "$log_root/python-runtime-install.log" 2>&1
unzip -oq "$runtime_root/tamerlite/wheels/pddl-0.4.10-py2.py3-none-any.whl" \
    -d "$runtime_root/tamerlite/site-packages"
make_runtime nextflap "$archive_root/pypi/up-nextflap/up_nextflap-0.2.0-py3-none-manylinux1_x86_64.whl"

install_source_dependencies() {
    planner_id="$1"
    shift
    site_dir="$runtime_root/$planner_id/site-packages"
    mkdir -p "$site_dir"
    python3 -m pip install --disable-pip-version-check --upgrade \
        --target "$site_dir" "$@" >> "$log_root/python-runtime-install.log" 2>&1
}

install_source_dependencies omtplan unified-planning networkx z3-solver
install_source_dependencies bitblast unified-planning click sympy
install_source_dependencies patty 'antlr4-python3-runtime==4.12.0' func-timeout mpmath \
    natsort ordered-set pylatex pysmt sympy boto3 z3-solver

printf 'Python planner runtimes prepared under %s\n' "$runtime_root"
