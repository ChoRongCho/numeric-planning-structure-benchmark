#!/usr/bin/env python3
"""Aggregate cross-domain evidence relevant to delayed numeric conflicts.

The existing controlled experiments manipulate different things:

* Barman compares an immediately blocked resource with a one-dose-short stock.
* Watering compares loose water with refill-requiring water (battery held loose).
* Logistics compares loose/loose resources with tight/tight resources.

Only the Barman contrast is an early-versus-late failure approximation.  The
other two are consistency checks for persistent search and early pruning.  The
generated report preserves that distinction.
"""

from __future__ import annotations

import argparse
import csv
import json
import re
from dataclasses import dataclass
from datetime import datetime
from pathlib import Path


HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


@dataclass(frozen=True)
class Contrast:
    name: str
    domain: str
    baseline: tuple[str, str]
    treatment: tuple[str, str]
    interpretation: str
    causal_role: str


CONTRASTS = (
    Contrast(
        "one-short / blocked-zero",
        "barman",
        ("stock_regime", "blocked-zero"),
        ("stock_regime", "one-short"),
        "늦게 드러나는 재고 부족과 처음부터 차단된 재고 부족 비교",
        "early/deep 근사",
    ),
    Contrast(
        "water-tight / water-loose (battery loose)",
        "watering",
        ("resource_pair", "loose/loose"),
        ("resource_pair", "tight/loose"),
        "배터리를 loose로 고정하고 반복 refill이 필요한 물 제약만 추가",
        "지속 탐색 일관성 검사",
    ),
    Contrast(
        "tight/tight / loose/loose",
        "logistics",
        ("resource_pair", "loose/loose"),
        ("resource_pair", "tight/tight"),
        "연료와 예산 제약이 선택지를 일찍 제거하는지 검사",
        "조기 pruning 일관성 검사",
    ),
)


def parse_metric_ff_evaluated(log_path: Path) -> int | None:
    if not log_path.exists():
        return None
    matches = re.findall(r"evaluating\s+([0-9]+)\s+states", log_path.read_text(errors="replace"))
    return int(matches[-1]) if matches else None


def source_instance(csv_path: Path, row: dict[str, str]) -> str:
    if row.get("source_instance"):
        return row["source_instance"]
    manifest = csv_path.with_name("manifest.json")
    if manifest.exists():
        value = json.loads(manifest.read_text()).get("source_instance")
        if value:
            return str(value)
    match = re.search(r"p00[1-4]", csv_path.parent.name)
    if not match:
        raise ValueError(f"cannot infer source instance from {csv_path}")
    return match.group(0)


def normalize_row(csv_path: Path, row: dict[str, str]) -> dict[str, object] | None:
    benchmark = row.get("benchmark", "")
    if benchmark == "controlled_barman":
        domain = "barman"
        condition = row["stock_regime"]
    elif benchmark in {"controlled_watering", "controlled_logistics"}:
        domain = benchmark.removeprefix("controlled_")
        condition = f"{row['factor_a']}/{row['factor_b']}"
    else:
        return None

    case_dir = Path(row.get("case_directory", ""))
    if not case_dir.is_absolute():
        case_dir = ROOT / case_dir
    evaluated = parse_metric_ff_evaluated(case_dir / "planner.log")
    expanded = int(row["expanded_nodes"]) if row.get("expanded_nodes") else None
    search_states = expanded if expanded is not None else evaluated
    return {
        "domain": domain,
        "instance": source_instance(csv_path, row),
        "planner": row["planner"],
        "heuristic": row["heuristic"],
        "condition": condition,
        "status": row["status"],
        "validation": row["validation"],
        "wall_seconds": float(row["wall_seconds"]),
        "expanded_nodes": expanded,
        "evaluated_states": evaluated,
        "search_states": search_states,
        "objective": float(row["objective_value"]) if row.get("objective_value") else None,
        "csv_path": str(csv_path.relative_to(ROOT)),
    }


def discover_rows() -> list[dict[str, object]]:
    paths = sorted((ROOT / "results" / "controlled-barman").glob("*/results.csv"))
    paths += sorted((ROOT / "results" / "controlled-resource").glob("*/results.csv"))
    selected: dict[tuple[object, ...], dict[str, object]] = {}
    for path in paths:
        with path.open(newline="", encoding="utf-8") as handle:
            for raw in csv.DictReader(handle):
                row = normalize_row(path, raw)
                if row is None:
                    continue
                key = (row["domain"], row["instance"], row["planner"], row["heuristic"], row["condition"])
                # Lexicographically later timestamped directory wins duplicate runs.
                if key not in selected or row["csv_path"] > selected[key]["csv_path"]:
                    selected[key] = row
    return sorted(selected.values(), key=lambda r: (
        r["domain"], r["instance"], r["planner"], r["heuristic"], r["condition"]
    ))


def discover_micro_rows() -> list[dict[str, object]]:
    selected: dict[tuple[str, str, str, str, str], dict[str, object]] = {}
    paths = sorted((ROOT / "results" / "delayed-conflict-domain-micro").glob("*/results.csv"))
    for path in paths:
        with path.open(newline="", encoding="utf-8") as handle:
            for raw in csv.DictReader(handle):
                states = raw.get("expanded_nodes") or raw.get("evaluated_states")
                row: dict[str, object] = {
                    "domain": raw["source_domain"],
                    "planner": raw["planner"],
                    "heuristic": raw["heuristic"],
                    "depth": raw["depth_condition"],
                    "branching": raw["branching_condition"],
                    "manifestation_edge": int(raw["manifestation_edge"]),
                    "search_states": int(states) if states else None,
                    "status": raw["status"],
                    "wall_seconds": float(raw["wall_seconds"]),
                    "csv_path": str(path.relative_to(ROOT)),
                }
                key = (row["domain"], row["planner"], row["heuristic"], row["depth"], row["branching"])
                if key not in selected or row["csv_path"] > selected[key]["csv_path"]:
                    selected[key] = row
    return sorted(selected.values(), key=lambda r: (
        r["domain"], r["planner"], r["heuristic"], r["depth"], r["branching"]
    ))


def safe_ratio(treatment: int | float | None, baseline: int | float | None) -> float | None:
    if treatment is None or baseline in (None, 0):
        return None
    return float(treatment) / float(baseline)


def paired_rows(rows: list[dict[str, object]]) -> list[dict[str, object]]:
    pairs: list[dict[str, object]] = []
    for contrast in CONTRASTS:
        domain_rows = [r for r in rows if r["domain"] == contrast.domain]
        condition_key = {"stock_regime": "condition", "resource_pair": "condition"}
        base_value = contrast.baseline[1]
        treatment_value = contrast.treatment[1]
        index = {
            (r["instance"], r["planner"], r["heuristic"], r[condition_key[contrast.baseline[0]]]): r
            for r in domain_rows
        }
        identities = sorted({(r["instance"], r["planner"], r["heuristic"]) for r in domain_rows})
        for instance, planner, heuristic in identities:
            baseline = index.get((instance, planner, heuristic, base_value))
            treatment = index.get((instance, planner, heuristic, treatment_value))
            if not baseline or not treatment:
                continue
            pairs.append({
                "domain": contrast.domain,
                "instance": instance,
                "planner": planner,
                "heuristic": heuristic,
                "contrast": contrast.name,
                "causal_role": contrast.causal_role,
                "baseline_status": baseline["status"],
                "treatment_status": treatment["status"],
                "baseline_seconds": baseline["wall_seconds"],
                "treatment_seconds": treatment["wall_seconds"],
                "time_ratio": safe_ratio(treatment["wall_seconds"], baseline["wall_seconds"]),
                "baseline_states": baseline["search_states"],
                "treatment_states": treatment["search_states"],
                "state_ratio": safe_ratio(treatment["search_states"], baseline["search_states"]),
                "baseline_objective": baseline["objective"],
                "treatment_objective": treatment["objective"],
            })
    return pairs


def fmt(value: object, digits: int = 2) -> str:
    if value is None:
        return "—"
    if isinstance(value, float):
        return f"{value:.{digits}f}"
    return str(value)


def write_csv(path: Path, rows: list[dict[str, object]]) -> None:
    with path.open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(rows[0]))
        writer.writeheader()
        writer.writerows(rows)


def write_summary(
    path: Path,
    pairs: list[dict[str, object]],
    source_rows: list[dict[str, object]],
    micro_rows: list[dict[str, object]],
) -> None:
    lines = [
        "# Delayed numeric conflict: 실제 도메인 교차 점검",
        "",
        "이 문서는 기존 통제실험을 동일한 기준으로 다시 집계한 결과다. Barman만",
        "early/deep failure의 근사 비교이며, Watering과 Logistics는 각각 지속 탐색과",
        "조기 pruning에 관한 일관성 검사다. 따라서 세 비교를 동일한 인과실험으로",
        "해석하면 안 된다.",
        "",
        "검색 상태 수는 NFD·ENHSP·Count Downward의 `expanded_nodes`를 사용하고,",
        "Metric-FF는 planner log의 `evaluating N states`를 사용했다.",
        "",
    ]
    for contrast in CONTRASTS:
        selected = [p for p in pairs if p["domain"] == contrast.domain]
        lines += [
            f"## {contrast.domain.title()}: {contrast.name}",
            "",
            f"- 역할: **{contrast.causal_role}**",
            f"- 조작 해석: {contrast.interpretation}",
            "",
            "| Instance | Planner / heuristic | 상태 | 시간 변화 | 탐색 상태 변화 |",
            "|---|---|---:|---:|---:|",
        ]
        for row in selected:
            status = f"{row['baseline_status']}→{row['treatment_status']}"
            time = f"{fmt(row['baseline_seconds'])}→{fmt(row['treatment_seconds'])}초 ({fmt(row['time_ratio'])}×)"
            states = f"{fmt(row['baseline_states'], 0)}→{fmt(row['treatment_states'], 0)} ({fmt(row['state_ratio'])}×)"
            lines.append(
                f"| {row['instance']} | {row['planner']} / `{row['heuristic']}` | {status} | {time} | {states} |"
            )
        lines.append("")

    lines += [
        "## 원본 action schema의 matched micro replication",
        "",
        "Watering과 Logistics 원본 domain.pddl을 그대로 사용하고, 네 edge의 총소모량은",
        "14로 고정한 채 비용 순서만 early=`6,6,1,1`, deep=`1,1,6,6`으로 바꿨다.",
        "용량 10에서 실제 차단 edge는 각각 2번째와 4번째다. High 조건에는 목표로",
        "이어지지 않는 실행 가능한 side edge 두 개를 각 중간 layer에 추가했다.",
        "",
        "| Domain | Planner / heuristic | E/L | E/H | D/L | D/H | D/L ÷ E/L | D/H ÷ E/H |",
        "|---|---|---:|---:|---:|---:|---:|---:|",
    ]
    groups = sorted({(r["domain"], r["planner"], r["heuristic"]) for r in micro_rows})
    for domain, planner, heuristic in groups:
        group = [r for r in micro_rows if (r["domain"], r["planner"], r["heuristic"]) == (domain, planner, heuristic)]
        lookup = {(r["depth"], r["branching"]): r["search_states"] for r in group}
        el, eh = lookup.get(("early", "low")), lookup.get(("early", "high"))
        dl, dh = lookup.get(("deep", "low")), lookup.get(("deep", "high"))
        lines.append(
            f"| {domain.title()} | {planner} / `{heuristic}` | {fmt(el, 0)} | {fmt(eh, 0)} | "
            f"{fmt(dl, 0)} | {fmt(dh, 0)} | {fmt(safe_ratio(dl, el))}× | {fmt(safe_ratio(dh, eh))}× |"
        )
    lines += [
        "",
        "모든 planner/heuristic에서 deep 조건의 탐색 상태 수가 early보다 증가했다.",
        "반면 side branching 증가는 Metric-FF와 NFD `irhadd`에서만 탐색 증가로",
        "이어졌고 Count Downward와 ENHSP에서는 같은 expanded 수를 보였다. Depth 효과는",
        "두 domain과 다섯 configuration에 공통이지만, persistent branching 효과는",
        "휴리스틱의 dead-end 판정과 preferred-action 정책에 의존한다.",
        "",
    ]
    lines += [
        "## 판정",
        "",
        "- Barman에서 같은 문제의 두 unsolvable 변형은 모순이 즉시 보이는지, 여러",
        "  주문 뒤에 보이는지에 따라 탐색량이 크게 달라진다. 이는 delayed-conflict",
        "  가설과 직접 부합하지만, blocked-zero와 one-short의 부족량도 다르므로 완전한",
        "  matched causal test는 아니다.",
        "- Watering은 물만 tight하게 만들어도 여러 planner의 탐색량이 크게 증가한다.",
        "  다중 자원 경쟁 없이도 반복 refill과 긴 행동 연쇄가 병목이 될 수 있다는 증거다.",
        "- Logistics에서는 두 자원을 tight하게 한 조건이 일부 planner의 탐색량을 크게",
        "  줄인다. 강한 제약이 선택지를 일찍 제거하면 오히려 쉬워질 수 있다는 증거다.",
        "- 따라서 `tight resource가 많을수록 어렵다`는 설명은 세 도메인을 함께 설명하지",
        "  못한다. 현재 결과는 `늦게까지 가능한 선택이 많이 남는가`라는 설명에",
        "  일관되지만, Watering·Logistics에서 revelation position을 직접 조작한 추가",
        "  실험 전에는 일반 인과결론으로 확정할 수 없다.",
        "",
        f"기존 원자료 {len(source_rows)}행에서 완성된 비교 {len(pairs)}쌍을 만들었고, "
        f"matched micro 결과 {len(micro_rows)}행을 추가했다.",
    ]
    path.write_text("\n".join(lines) + "\n", encoding="utf-8")


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", default="results/delayed-conflict/cross-domain-evidence")
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    output = Path(args.output)
    if not output.is_absolute():
        output = ROOT / output
    output.mkdir(parents=True, exist_ok=True)
    rows = discover_rows()
    if not rows:
        raise SystemExit("no controlled experiment results found")
    pairs = paired_rows(rows)
    micro_rows = discover_micro_rows()
    write_csv(output / "normalized-results.csv", rows)
    write_csv(output / "contrasts.csv", pairs)
    if micro_rows:
        write_csv(output / "matched-micro-results.csv", micro_rows)
    write_summary(output / "summary.md", pairs, rows, micro_rows)
    (output / "manifest.json").write_text(json.dumps({
        "created_at": datetime.now().astimezone().isoformat(),
        "source_rows": len(rows),
        "paired_contrasts": len(pairs),
        "matched_micro_rows": len(micro_rows),
        "note": (
            "Barman is an early/deep approximation; legacy Watering/Logistics contrasts are "
            "consistency checks; matched micro rows directly control edge-cost order."
        ),
    }, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
    print(output.relative_to(ROOT))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
