#!/usr/bin/env bash
set -euo pipefail

project_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
archive="$project_root/planners/archives/lprpg/lprpg-0.2.tar.bz2"
source_root="$project_root/planners/external/lprpg-0.2"
runtime_root="$project_root/planners/runtime/lprpg"
lpsolve_so="${LPSOLVE_SO:-/usr/lib/lp_solve/liblpsolve55.so}"

expected_sha256=aaefab79fe995ad7877baf5625d0d01ac2dd853e1b6efc2363b2caadcdab6716

if [ ! -f "$archive" ]; then
    echo "Missing $archive; run scripts/fetch_numeric_archives.sh first." >&2
    exit 2
fi
actual_sha256="$(sha256sum "$archive" | cut -d ' ' -f 1)"
if [ "$actual_sha256" != "$expected_sha256" ]; then
    echo "Unexpected LPRPG archive checksum: $actual_sha256" >&2
    exit 3
fi
if [ ! -f "$lpsolve_so" ]; then
    echo "Missing 64-bit LP Solve library: $lpsolve_so" >&2
    exit 4
fi

if [ ! -f "$source_root/README" ]; then
    mkdir -p "$source_root"
    tar -xf "$archive" -C "$source_root" --strip-components=1
fi
mkdir -p "$runtime_root/bin" "$runtime_root/lib"
cp "$lpsolve_so" "$runtime_root/lib/liblpsolve55.so"

python3 - "$source_root" <<'PY'
from pathlib import Path
import sys

root = Path(sys.argv[1])
ptree = root / "VALfiles" / "ptree.h"
text = ptree.read_text()
text = text.replace("\n\t\tinsert(std::make_pair(name,sym));", "\n\t\tthis->insert(std::make_pair(name,sym));")
ptree.write_text(text)

main = root / "lprpg" / "lprpgMain.cpp"
text = main.read_text()
if "#include <unistd.h>" not in text:
    text = text.replace("#include <sys/times.h>", "#include <sys/times.h>\n#include <unistd.h>")
main.write_text(text)

makefile = root / "lprpg" / "Makefile"
text = makefile.read_text()
old = "../lpsolve55/liblpsolve55.a -ldl"
new = "-Wl,-rpath,'$$ORIGIN/../lib' -L../../../runtime/lprpg/lib -llpsolve55 -ldl"
if old in text:
    text = text.replace(old, new)
makefile.write_text(text)
PY

(
    cd "$source_root/VALfiles"
    flex++ pddl+.lex
    bison pddl+.yacc -o pddl+.cpp
    sed -i 's/yyerror(char/yyerror(const char/' pddl+.cpp
    if ! grep -q 'fixyywrap.h' pddl+.cpp; then
        printf '\n#include "fixyywrap.h"\n' >> pddl+.cpp
    fi
)

make -C "$source_root/lprpg" -j"$(nproc)" lprpg
install -m 0755 "$source_root/lprpg/lprpg" "$runtime_root/bin/lprpg"

echo "Installed LPRPG to $runtime_root/bin/lprpg"
