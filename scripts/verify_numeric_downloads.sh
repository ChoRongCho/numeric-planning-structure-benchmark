#!/usr/bin/env bash
set -u

project_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
archive_root="$project_root/planners/archives"
source_root="$project_root/planners/external"
lock_root="$project_root/planners/locks"
log_root="$project_root/planners/download-logs"
verification_file="$log_root/verification-status.tsv"

mkdir -p "$log_root"
: > "$verification_file"
printf 'kind\tid\tstatus\tdetail\n' >> "$verification_file"
failure_count=0

if (cd "$archive_root" && sha256sum --check "$lock_root/downloaded-archives.sha256") \
    > "$log_root/checksum-verification.log" 2>&1; then
    printf 'manifest\tarchives\tok\tall SHA-256 checksums match\n' >> "$verification_file"
else
    printf 'manifest\tarchives\tfailed\tsee checksum-verification.log\n' >> "$verification_file"
    failure_count=$((failure_count + 1))
fi

while IFS= read -r -d '' archive_file; do
    relative_file="${archive_file#"$archive_root/"}"
    case "$archive_file" in
        *.tar.gz|*.tgz) test_command=(tar -tzf "$archive_file") ;;
        *.tar.bz2) test_command=(tar -tjf "$archive_file") ;;
        *.tar) test_command=(tar -tf "$archive_file") ;;
        *.zip|*.jar|*.whl) test_command=(unzip -tqq "$archive_file") ;;
        *.gz) test_command=(gzip -t "$archive_file") ;;
        *)
            printf 'archive\t%s\tskipped\tnot a container format\n' "$relative_file" >> "$verification_file"
            continue
            ;;
    esac
    if "${test_command[@]}" >/dev/null 2>&1; then
        printf 'archive\t%s\tok\tcontainer readable\n' "$relative_file" >> "$verification_file"
    else
        printf 'archive\t%s\tfailed\tcontainer test failed\n' "$relative_file" >> "$verification_file"
        failure_count=$((failure_count + 1))
    fi
done < <(find "$archive_root" -type f -print0 | sort -z)

while IFS=$'\t' read -r planner_id expected_revision source_url; do
    [ "$planner_id" = id ] && continue
    repo_dir="$source_root/$planner_id"
    if [ ! -d "$repo_dir/.git" ]; then
        printf 'git\t%s\tfailed\trepository missing\n' "$planner_id" >> "$verification_file"
        failure_count=$((failure_count + 1))
        continue
    fi
    actual_revision="$(git -C "$repo_dir" rev-parse HEAD 2>/dev/null || true)"
    if [ "$actual_revision" = "$expected_revision" ]; then
        printf 'git\t%s\tok\t%s\n' "$planner_id" "$actual_revision" >> "$verification_file"
    else
        printf 'git\t%s\tfailed\texpected %s got %s\n' \
            "$planner_id" "$expected_revision" "$actual_revision" >> "$verification_file"
        failure_count=$((failure_count + 1))
    fi
done < "$lock_root/downloaded-revisions.tsv"

printf 'Verification finished with %s failure(s). See %s\n' "$failure_count" "$verification_file"
[ "$failure_count" -eq 0 ]
