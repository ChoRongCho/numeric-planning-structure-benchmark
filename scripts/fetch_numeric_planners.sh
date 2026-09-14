#!/usr/bin/env bash
set -u

project_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source_root="$project_root/planners/external"
archive_root="$project_root/planners/archives"
lock_root="$project_root/planners/locks"
log_root="$project_root/planners/download-logs"

mkdir -p "$source_root" "$archive_root" "$lock_root" "$log_root"

status_file="$log_root/fetch-status.tsv"
revision_file="$lock_root/downloaded-revisions.tsv"
: > "$status_file"
: > "$revision_file"
printf 'id\tstatus\turl\tdetail\n' >> "$status_file"
printf 'id\trevision\turl\n' >> "$revision_file"

clone_repo() {
    planner_id="$1"
    repo_url="$2"
    clone_mode="${3:-plain}"
    destination="$source_root/$planner_id"

    if [ -d "$destination/.git" ] && git -C "$destination" rev-parse --verify HEAD >/dev/null 2>&1; then
        revision="$(git -C "$destination" rev-parse HEAD 2>/dev/null || true)"
        printf '%s\tskipped-existing\t%s\t%s\n' "$planner_id" "$repo_url" "$revision" >> "$status_file"
        printf '%s\t%s\t%s\n' "$planner_id" "$revision" "$repo_url" >> "$revision_file"
        return
    fi

    if [ -e "$destination" ]; then
        incomplete_destination="$destination.incomplete.$(date +%Y%m%dT%H%M%S)"
        mv "$destination" "$incomplete_destination"
    fi

    if [ "$clone_mode" = recursive ]; then
        if timeout 180 git clone --depth 1 --recursive --shallow-submodules "$repo_url" "$destination" >> "$log_root/git-clone.log" 2>&1; then
            clone_status=ok
        else
            clone_status=failed
        fi
    else
        if timeout 180 git clone --depth 1 "$repo_url" "$destination" >> "$log_root/git-clone.log" 2>&1; then
            clone_status=ok
        else
            clone_status=failed
        fi
    fi

    if [ "$clone_status" = ok ]; then
        revision="$(git -C "$destination" rev-parse HEAD 2>/dev/null || true)"
        printf '%s\tok\t%s\t%s\n' "$planner_id" "$repo_url" "$revision" >> "$status_file"
        printf '%s\t%s\t%s\n' "$planner_id" "$revision" "$repo_url" >> "$revision_file"
    else
        printf '%s\tfailed\t%s\tsee git-clone.log\n' "$planner_id" "$repo_url" >> "$status_file"
    fi
}

clone_repo enhsp https://github.com/hstairs/enhsp.git
clone_repo up-enhsp https://github.com/aiplan4eu/up-enhsp.git
clone_repo numeric-fast-downward https://github.com/Kurorororo/numeric-fast-downward.git recursive
clone_repo lnm-plan-ipc2023 https://github.com/ipc2023-numeric/team-1.git
clone_repo patty https://github.com/matteocarde/patty.git
clone_repo patty-ipc2026 https://github.com/ipc2026-numeric/team-2.git
clone_repo omtplan https://github.com/fraleo/OMTPlan.git
clone_repo omtplan-ipc2023 https://github.com/ipc2023-numeric/team-2.git
clone_repo rantanplan https://github.com/JoanEspasa/rantanplan-public.git
clone_repo springroll https://bitbucket.org/enricode/springroll-smt-hybrid-planner.git
clone_repo bitblast https://github.com/LBonassi95/BitBlast.git
clone_repo numce-compiler https://github.com/Plutone/numce-compiler.git
clone_repo panino-ipc2026 https://github.com/ipc2026-numeric/team-3.git
clone_repo tamerlite https://github.com/fbk-pso/tamerlite.git
clone_repo tamerlite-ipc2026 https://github.com/ipc2026-numeric/team-4.git
clone_repo tyr-ipc2026 https://github.com/ipc2026-numeric/team-5.git
clone_repo nplanning-ipc2026 https://github.com/ipc2026-numeric/team-6.git
clone_repo count-downward-ipc2026 https://github.com/ipc2026-numeric/team-7.git
clone_repo planforge https://github.com/mrlab-ai/PlanForge.git
clone_repo planforge-ipc2026 https://github.com/ipc2026-numeric/team-8.git
clone_repo pattint-ipc2026 https://github.com/ipc2026-numeric/team-9.git
clone_repo count-downward-together-ipc2026 https://github.com/ipc2026-numeric/team-11.git
clone_repo tempest-numeric-ipc2026 https://github.com/ipc2026-numeric/team-12.git
clone_repo ferroplan https://github.com/hhh42/ferroplan.git recursive
clone_repo metric-ff-crossplatform https://github.com/Vidminas/metric-ff-crossplatform.git
clone_repo up-lpg https://github.com/aiplan4eu/up-lpg.git
clone_repo shop2 https://github.com/cl-axon/shop2.git
clone_repo popf-maintained https://github.com/fmrico/popf.git recursive
clone_repo optic-maintained https://github.com/KavrakiLab/optic.git recursive
clone_repo optic-alt-fork https://github.com/roveri-marco/optic.git recursive
clone_repo tfd-maintained-mirror https://github.com/neighthan/tfd.git
clone_repo up-tamer https://github.com/aiplan4eu/up-tamer.git
clone_repo nextflap https://github.com/ossaver/NextFLAP.git
clone_repo aries https://github.com/plaans/aries.git recursive
clone_repo tempest-maintained https://github.com/fbk-pso/tempest.git
clone_repo temporal-planning-suite https://github.com/aig-upf/temporal-planning.git recursive
clone_repo temporal-ipc2018-team3 https://bitbucket.org/ipc2018-temporal/team3.git
clone_repo fape https://github.com/laas/fape.git
clone_repo dino https://github.com/KCL-Planning/DiNo.git
clone_repo upmurphi https://github.com/gdellapenna/UPMurphi.git
clone_repo smtplan-plus https://github.com/KCL-Planning/SMTPlan.git
clone_repo z3 https://github.com/Z3Prover/z3.git
clone_repo yices2 https://github.com/SRI-CSL/yices2.git
clone_repo dreal4 https://github.com/dreal/dreal4.git recursive
clone_repo coinor-clp https://github.com/coin-or/Clp.git
clone_repo coinor-cbc https://github.com/coin-or/Cbc.git
clone_repo scip https://github.com/scipopt/scip.git
clone_repo clingo https://github.com/potassco/clingo.git recursive
clone_repo unified-planning https://github.com/aiplan4eu/unified-planning.git
clone_repo planutils https://github.com/AI-Planning/planutils.git
clone_repo val https://github.com/KCL-Planning/VAL.git
clone_repo tarski https://github.com/aig-upf/tarski.git
clone_repo jpddlplus https://github.com/hstairs/jpddlplus.git
clone_repo ppmajal-legacy https://gitlab.com/enricos83/PPMAJAL-Expressive-PDDL-Java-Library.git
clone_repo pddl-solvers-build-harness https://github.com/mokhtarivahid/pddl-solvers.git recursive
clone_repo ipc2023-numeric-dataset https://github.com/ipc2023-numeric/ipc2023-dataset.git
clone_repo ipc2026-numeric-site https://github.com/ipc2026-numeric/ipc2026-numeric.github.io.git
clone_repo ipc2026-numeric-benchmarks https://github.com/ipc2026-numeric/ipc2026-dataset.git
clone_repo ipc-pddl-instances https://github.com/potassco/pddl-instances.git

printf 'Finished. See %s and %s\n' "$status_file" "$revision_file"
