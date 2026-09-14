#!/usr/bin/env bash
set -u

project_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
archive_root="$project_root/planners/archives"
log_root="$project_root/planners/download-logs"
lock_root="$project_root/planners/locks"
status_file="$log_root/archive-status.tsv"
checksum_file="$lock_root/downloaded-archives.sha256"

mkdir -p "$archive_root" "$log_root" "$lock_root"
: > "$status_file"
: > "$checksum_file"
printf 'id\tstatus\turl\tfile\tdetail\n' >> "$status_file"

fetch_url() {
    artifact_id="$1"
    source_url="$2"
    relative_file="$3"
    destination="$archive_root/$relative_file"
    partial="$destination.part"

    mkdir -p "$(dirname "$destination")"
    if [ -s "$destination" ]; then
        digest="$(sha256sum "$destination" | cut -d ' ' -f 1)"
        printf '%s  %s\n' "$digest" "$relative_file" >> "$checksum_file"
        printf '%s\tskipped-existing\t%s\t%s\t%s\n' \
            "$artifact_id" "$source_url" "$relative_file" "$digest" >> "$status_file"
        return
    fi

    if timeout 900 curl --location --fail --retry 3 --retry-all-errors \
        --connect-timeout 30 --output "$partial" "$source_url" \
        >> "$log_root/archive-download.log" 2>&1; then
        mv "$partial" "$destination"
        digest="$(sha256sum "$destination" | cut -d ' ' -f 1)"
        printf '%s  %s\n' "$digest" "$relative_file" >> "$checksum_file"
        printf '%s\tok\t%s\t%s\t%s\n' \
            "$artifact_id" "$source_url" "$relative_file" "$digest" >> "$status_file"
    else
        rm -f "$partial"
        printf '%s\tfailed\t%s\t%s\tsee archive-download.log\n' \
            "$artifact_id" "$source_url" "$relative_file" >> "$status_file"
    fi
}

# Metric-FF: all official versions still linked by the original author, plus
# the two executable snapshots used by planutils.
fetch_url metric-ff https://fai.cs.uni-saarland.de/hoffmann/ff/Metric-FF.tgz metric-ff/Metric-FF.tgz
fetch_url metric-ff-2.0 https://fai.cs.uni-saarland.de/hoffmann/ff/Metric-FF-v2.0.tgz metric-ff/Metric-FF-v2.0.tgz
fetch_url metric-ff-2.1 https://fai.cs.uni-saarland.de/hoffmann/ff/Metric-FF-v2.1.tgz metric-ff/Metric-FF-v2.1.tgz
fetch_url metric-ff-planutils https://raw.githubusercontent.com/nilsjor/fast-forward-linux-binaries/main/metric-ff/ff.gz metric-ff/planutils-ff.gz
fetch_url metric-ff-2.0-planutils https://github.com/siftech/metric-ff/releases/download/v2.0.3/metric-ff.gz metric-ff/planutils-metric-ff-v2.0.3.gz

# Historical temporal/numeric distributions.
fetch_url lpg-td-1.4 https://lpg.unibs.it/lpg/lpgtd-1_4-linux.tar.gz lpg/lpgtd-1_4-linux.tar.gz
fetch_url sapa-source https://rakaposhi.eas.asu.edu/Sapa2_stable-src-200406.tar.gz sapa/Sapa2_stable-src-200406.tar.gz
fetch_url sapa-jar https://rakaposhi.eas.asu.edu/SapaReplan.jar sapa/SapaReplan.jar
fetch_url tlplan-c https://www.cs.toronto.edu/tlplan/tlplan.tar.gz tlplan/tlplan.tar.gz
fetch_url tlplan-scheme https://www.cs.toronto.edu/tlplan/tlplan.scm.tar tlplan/tlplan.scm.tar

# IPC-2008 frozen submissions.
ipc08_base=https://ipc08.icaps-conference.org/deterministic/data/planners
fetch_url mips-xxl-seq "$ipc08_base/seq-opt-mips-xxl.tar.bz2" ipc2008/seq-opt-mips-xxl.tar.bz2
fetch_url mips-xxl-netben "$ipc08_base/netben-opt-mips-xxl.tar.bz2" ipc2008/netben-opt-mips-xxl.tar.bz2
fetch_url gamer-netben "$ipc08_base/netben-opt-gamer.tar.bz2" ipc2008/netben-opt-gamer.tar.bz2
fetch_url hspsp-netben "$ipc08_base/netben-opt-hspsp.tar.bz2" ipc2008/netben-opt-hspsp.tar.bz2
fetch_url sgplan6-seq "$ipc08_base/seq-sat-sgplan6.tar.bz2" ipc2008/seq-sat-sgplan6.tar.bz2
fetch_url sgplan6-seq-fixed "$ipc08_base/seq-sat-sgplan6x.tar.bz2" ipc2008/seq-sat-sgplan6x.tar.bz2
fetch_url sgplan6-temporal-fixed "$ipc08_base/tempo-sat-sgplan6x.tar.bz2" ipc2008/tempo-sat-sgplan6x.tar.bz2
fetch_url tfd-ipc2008 "$ipc08_base/tempo-sat-temporal-fast-downward.tar.bz2" ipc2008/tempo-sat-temporal-fast-downward.tar.bz2

# Original Planning at King's releases. SourceForge's /download endpoint is
# retained because it resolves to the currently selected project mirror.
sf_base=https://sourceforge.net/projects/tsgp/files
fetch_url optic-gcc8 "$sf_base/OPTIC/optic-patched-for-gcc8.tar.bz2/download" optic/optic-patched-for-gcc8.tar.bz2
fetch_url optic-clp "$sf_base/OPTIC/optic-clp.tar.bz2/download" optic/optic-clp.tar.bz2
fetch_url optic-original "$sf_base/OPTIC/optic.tar.bz2/download" optic/optic.tar.bz2
fetch_url optic-domains "$sf_base/OPTIC/time-dependent-cost-domains.tar.gz/download" optic/time-dependent-cost-domains.tar.gz
fetch_url popf2 "$sf_base/POPF/popf2-11jun2011.tar.bz2/download" popf/popf2-11jun2011.tar.bz2
fetch_url popf-1.1 "$sf_base/POPF/popf-1.1.tar.gz/download" popf/popf-1.1.tar.gz
fetch_url colin2 "$sf_base/COLIN/colin2.tar.bz2/download" colin/colin2.tar.bz2
fetch_url lprpgp-ipc2011 "$sf_base/LPRPG/LPRPG-P%20-%20ICAPS%202011/lprpgp-ipc2011.tar.bz2/download" lprpg/lprpgp-ipc2011.tar.bz2
fetch_url lprpg-0.2 "$sf_base/LPRPG/Public%20Release%202/lprpg-0.2.tar.bz2/download" lprpg/lprpg-0.2.tar.bz2
fetch_url lprpg-icaps2008 "$sf_base/LPRPG/Public%20Release%201%20%28ICAPS08%29/lprpg.tar.gz/download" lprpg/lprpg-icaps2008.tar.gz
fetch_url crikey-3.1 "$sf_base/CRIKEY/CRIKEY3.1/crikey3.1.tar.gz/download" crikey/crikey3.1.tar.gz
fetch_url crikey-3.1-static "$sf_base/CRIKEY/CRIKEY3.1/crikey3.1-static.gz/download" crikey/crikey3.1-static.gz
fetch_url crikey-2 "$sf_base/CRIKEY/CRIKEY%202/CRIKEY.jar/download" crikey/CRIKEY2.jar
fetch_url tsgp-source "$sf_base/tsgp/Public%20Release%201/tsgp-public1.tar.gz/download" tsgp/tsgp-public1.tar.gz
fetch_url tsgp-static "$sf_base/tsgp/Public%20Release%201/tsgp-static.gz/download" tsgp/tsgp-static.gz
fetch_url temporal-domains "$sf_base/temporaldomains.tar.gz/download" planning-at-kings/temporaldomains.tar.gz
fetch_url temporal-domains-deprecated "$sf_base/Deprecated/temporaldomains.tar.gz/download" planning-at-kings/temporaldomains-deprecated.tar.gz

# HSP* historical series. TP4 is distributed as the hsp0 time/resource mode
# in this collection, so all upstream releases are retained.
hsp_base=https://users.cecs.anu.edu.au/~patrik
fetch_url hsp-star-current "$hsp_base/tmp/hsps.tar.gz" hsp-star/hsps.tar.gz
for version in 2015-10-30 2014-01-17 2012-05-24 2012-01-29 2012-01-23 2009-11-26 2008-10-07 2008-04-01; do
    fetch_url "hsp-star-$version" "$hsp_base/tmp/hsps-$version.tar.gz" "hsp-star/hsps-$version.tar.gz"
done
fetch_url hsp-star-bison-plus "$hsp_base/tmp/bison++-1.21-8.tar.gz" hsp-star/bison++-1.21-8.tar.gz
fetch_url hsp-star-flex-plus "$hsp_base/tmp/flex++-2.3.8-7.tar.gz" hsp-star/flex++-2.3.8-7.tar.gz

# CPT 1.0 source, historical binaries, and its PDDL corpus.
cpt_base=https://www.cril.univ-artois.fr/~vidal/cpt
fetch_url cpt-source "$cpt_base/cpt-1.0.tar.gz" cpt/cpt-1.0.tar.gz
fetch_url cpt-linux-x86 "$cpt_base/cpt-1.0.linux.x86.gz" cpt/cpt-1.0.linux.x86.gz
fetch_url cpt-linux-sparc "$cpt_base/cpt-1.0.linux.sparc.gz" cpt/cpt-1.0.linux.sparc.gz
fetch_url cpt-windows "$cpt_base/cpt-1.0.windows.zip" cpt/cpt-1.0.windows.zip
fetch_url cpt-domains "$cpt_base/pddl.tar.gz" cpt/pddl.tar.gz

# IPC3 complete and regeneration-only benchmark archives.
ipc3_base=https://ipc02.icaps-conference.org/CompoDomains
fetch_url ipc2002-domains "$ipc3_base/IPC3.tgz" ipc2002/IPC3.tgz
fetch_url ipc2002-domains-small "$ipc3_base/IPC3small.tgz" ipc2002/IPC3small.tgz

# Current pre-built Aries release for every platform, and every published FAPE
# binary/JAR. Source repositories are acquired separately by the git script.
aries_base=https://github.com/plaans/aries/releases/download/latest
fetch_url aries-linux "$aries_base/up-aries_linux_amd64" aries/latest/up-aries_linux_amd64
fetch_url aries-macos-amd64 "$aries_base/up-aries_macos_amd64" aries/latest/up-aries_macos_amd64
fetch_url aries-macos-arm64 "$aries_base/up-aries_macos_arm64" aries/latest/up-aries_macos_arm64
fetch_url aries-windows-amd64 "$aries_base/up-aries_windows_amd64.exe" aries/latest/up-aries_windows_amd64.exe
fetch_url aries-windows-arm64 "$aries_base/up-aries_windows_arm64.exe" aries/latest/up-aries_windows_arm64.exe
fetch_url aries-python "$aries_base/up_aries.tar.gz" aries/latest/up_aries.tar.gz
fetch_url fape-1.0.4 https://github.com/arbimo/fape/releases/download/v1.0.4/fape-1.0.4.jar fape/fape-1.0.4.jar
fetch_url fape-1.0 https://github.com/arbimo/fape/releases/download/v1.0/fape-1.0 fape/fape-1.0
fetch_url fape-assembly-1.0 https://github.com/arbimo/fape/releases/download/v1.0/fape-planning-assembly-1.0.jar fape/fape-planning-assembly-1.0.jar

# Python release artifacts. pip chooses every compatible wheel plus the sdist
# only when --no-binary is varied, so perform the two acquisitions separately.
fetch_pypi() {
    package_id="$1"
    package_name="$2"
    package_dir="$archive_root/pypi/$package_id"
    mkdir -p "$package_dir"
    if timeout 900 python3 -m pip download --no-deps --dest "$package_dir" "$package_name" \
        >> "$log_root/archive-download.log" 2>&1 && \
       timeout 900 python3 -m pip download --no-deps --no-binary :all: --dest "$package_dir" "$package_name" \
        >> "$log_root/archive-download.log" 2>&1; then
        found=0
        for package_file in "$package_dir"/*; do
            [ -f "$package_file" ] || continue
            found=1
            relative_file="${package_file#"$archive_root/"}"
            digest="$(sha256sum "$package_file" | cut -d ' ' -f 1)"
            printf '%s  %s\n' "$digest" "$relative_file" >> "$checksum_file"
        done
        if [ "$found" -eq 1 ]; then
            printf '%s\tok\thttps://pypi.org/project/%s/\tpypi/%s\twheel/sdist\n' \
                "$package_id" "$package_name" "$package_id" >> "$status_file"
        else
            printf '%s\tfailed\thttps://pypi.org/project/%s/\tpypi/%s\tno files\n' \
                "$package_id" "$package_name" "$package_id" >> "$status_file"
        fi
    else
        printf '%s\tfailed\thttps://pypi.org/project/%s/\tpypi/%s\tsee archive-download.log\n' \
            "$package_id" "$package_name" "$package_id" >> "$status_file"
    fi
}

# Preserve the sdist directly from the PyPI JSON URL; asking pip to prepare its
# metadata unnecessarily builds hatchling and fails on older host toolchains.
fetch_url tamerlite-wheel https://files.pythonhosted.org/packages/70/ed/9b86f3d15678db599772c238a60be1045fbf73c8d145e5044cb1baaa6913/tamerlite-0.1.1-py3-none-any.whl pypi/tamerlite/tamerlite-0.1.1-py3-none-any.whl
fetch_url tamerlite-sdist https://files.pythonhosted.org/packages/17/3e/8cc07c3cbd10da4a2c20d9f4e1b271a884407b8fa7d57f772208fd457683/tamerlite-0.1.1.tar.gz pypi/tamerlite/tamerlite-0.1.1.tar.gz
fetch_pypi up-nextflap up-nextflap

sort -u "$checksum_file" -o "$checksum_file"
printf 'Finished. See %s and %s\n' "$status_file" "$checksum_file"
