#!/usr/bin/env bash
set -u

project_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
archive_root="$project_root/planners/archives"
runtime_root="$project_root/planners/runtime"
log_root="$project_root/planners/download-logs"

mkdir -p "$runtime_root" "$log_root"

install_gzip_binary() {
    source_file="$1"
    destination="$2"
    mkdir -p "$(dirname "$destination")"
    gzip -dc "$source_file" > "$destination.tmp"
    chmod 0755 "$destination.tmp"
    mv "$destination.tmp" "$destination"
}

install_file() {
    source_file="$1"
    destination="$2"
    mode="${3:-0755}"
    mkdir -p "$(dirname "$destination")"
    cp "$source_file" "$destination.tmp"
    chmod "$mode" "$destination.tmp"
    mv "$destination.tmp" "$destination"
}

extract_tar() {
    source_file="$1"
    destination="$2"
    marker="$destination/.source.sha256"
    digest="$(sha256sum "$source_file" | cut -d ' ' -f 1)"
    if [ -f "$marker" ] && [ "$(sed -n '1p' "$marker")" = "$digest" ]; then
        return
    fi
    staging="$destination.staging"
    rm -rf "$staging"
    mkdir -p "$staging"
    tar -xf "$source_file" -C "$staging"
    rm -rf "$destination"
    mv "$staging" "$destination"
    printf '%s\n' "$digest" > "$marker"
}

# Ready-to-run Linux releases, each copied into an independent runtime tree.
install_gzip_binary "$archive_root/metric-ff/planutils-ff.gz" "$runtime_root/metric-ff/bin/metric-ff"
install_gzip_binary "$archive_root/metric-ff/planutils-metric-ff-v2.0.3.gz" "$runtime_root/metric-ff-2.0/bin/metric-ff"
install_file "$archive_root/sapa/SapaReplan.jar" "$runtime_root/sapa/bin/SapaReplan.jar" 0644
install_file "$archive_root/aries/latest/up-aries_linux_amd64" "$runtime_root/aries/bin/up-aries"
install_file "$archive_root/fape/fape-1.0.4.jar" "$runtime_root/fape/bin/fape.jar" 0644
install_file "$archive_root/fape/fape-planning-assembly-1.0.jar" "$runtime_root/fape-1.0/bin/fape.jar" 0644
if [ -f "$project_root/planners/external/enhsp/enhsp-dist/enhsp.jar" ]; then
    install_file "$project_root/planners/external/enhsp/enhsp-dist/enhsp.jar" "$runtime_root/enhsp/bin/enhsp.jar" 0644
    mkdir -p "$runtime_root/enhsp/bin/libs"
    cp -R "$project_root/planners/external/enhsp/enhsp-dist/libs/." "$runtime_root/enhsp/bin/libs/"
fi
install_gzip_binary "$archive_root/cpt/cpt-1.0.linux.x86.gz" "$runtime_root/cpt/bin/cpt"
install_gzip_binary "$archive_root/crikey/crikey3.1-static.gz" "$runtime_root/crikey/bin/crikey"
install_gzip_binary "$archive_root/tsgp/tsgp-static.gz" "$runtime_root/tsgp/bin/tsgp"
install_file "$archive_root/crikey/CRIKEY2.jar" "$runtime_root/crikey2/bin/CRIKEY.jar" 0644

extract_tar "$archive_root/lpg/lpgtd-1_4-linux.tar.gz" "$runtime_root/lpg-td"
if [ -f "$runtime_root/lpg-td/LPG-td-1.4/lpg-td" ]; then
    chmod 0755 "$runtime_root/lpg-td/LPG-td-1.4/lpg-td"
fi

# Frozen IPC submissions are staged separately. Their own plan/build/solve
# scripts are retained without installing anything into the host OS.
for archive_file in "$archive_root"/ipc2008/*.tar.bz2; do
    archive_name="$(basename "$archive_file" .tar.bz2)"
    extract_tar "$archive_file" "$runtime_root/$archive_name"
done

tfd_python_dir="$runtime_root/tempo-sat-temporal-fast-downward/tempo-sat-temporal-fast-downward/py2.5/bin"
if [ -x "$tfd_python_dir/python2.5" ]; then
    ln -sfn python2.5 "$tfd_python_dir/python"
fi

printf 'Runtime trees prepared under %s\n' "$runtime_root"
