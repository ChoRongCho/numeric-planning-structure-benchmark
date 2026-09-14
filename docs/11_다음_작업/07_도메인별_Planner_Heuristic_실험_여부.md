# 도메인별 Planner-Heuristic 실험 여부

## 1. 적용 기준

- `O`: p000~p004 본 실험을 실행한다.
- `X`: 확인된 parser 비호환 또는 해당 heuristic의 numeric-effect 미지원으로
  실행하지 않는다.
- timeout, memory-limit, false dead-end 및 false unsolvable은 우리가 측정할
  planner/heuristic의 실제 한계이므로 `O`다.
- `X`는 실패나 0점으로 집계하지 않고 `N/A`로 기록한다.

## 2. 전체 실험 매트릭스

| No. | Planner | Heuristic | Blocksworld | Logistics | Books | Watering | Barman | Assembly |
| ---: | --- | --- | :---: | :---: | :---: | :---: | :---: | :---: |
| 1 | ENHSP | `hadd` | O | O | O | O | O | O |
| 2 | ENHSP | `hmax` | O | O | O | O | O | O |
| 3 | ENHSP | `aibr` | O | O | O | O | O | O |
| 4 | ENHSP | `hradd` | O | O | O | O | O | O |
| 5 | ENHSP | `hrmax` | O | O | O | O | O | O |
| 6 | ENHSP | `hmrp` | O | O | O | O | O | O |
| 7 | ENHSP | `ngc` | O | O | O | O | O | O |
| 8 | ENHSP | `blcost` | O | O | O | O | O | O |
| 9 | ENHSP | `blind` | O | O | O | O | O | O |
| 10 | Metric-FF | `numeric-hff` | O | O | O | O | O | O |
| 11 | Count Downward Agile | `irhff` | O | O | O | O | O | O |
| 12 | PlanForge | `lmcutnumeric` | O | O | O | O | O | O |
| 13 | PlanForge | `blind` | O | O | O | O | O | O |
| 14 | PlanForge | `ff` | O | O | O | O | O | O |
| 15 | PlanForge | `greedy_numeric_pdb` | O | O | O | O | X | O |
| 16 | PlanForge | `canonical_numeric_pdb` | O | O | O | O | X | O |
| 17 | PlanForge | `domain_abstraction` | O | O | O | O | X | O |
| 18 | PlanForge | `canonical_domain_abstractions` | O | O | O | O | X | O |
| 19 | PlanForge | `multi_domain_abstractions` | O | O | O | O | X | O |
| 20 | PlanForge | `scp_online` | O | O | O | O | X | O |
| 21 | PlanForge | `fill_scp` | O | O | O | O | X | O |
| 22 | Patty | `none` | X | X | O | O | O | O |
| 23 | Panino LNP Agile | `hadd-novelty` | O | O | O | O | O | O |
| 24 | TamerLite | `hadd` | O | O | O | O | O | O |
| 25 | TamerLite | `hff` | O | O | O | O | O | O |
| 26 | TamerLite | `hmax` | O | O | O | O | O | O |
| 27 | TamerLite | `hmax_explicit` | O | O | O | O | O | O |
| 28 | TamerLite | `blind` | O | O | O | O | O | O |
| 29 | TamerLite | `hadd_no_numbers` | O | O | O | O | O | O |
| 30 | TamerLite | `hff_no_numbers` | O | O | O | O | O | O |
| 31 | TamerLite | `hmax_no_numbers` | O | O | O | O | O | O |
| 32 | Pattint | `none` | X | X | O | O | O | O |
| 33 | Tempest Numeric | `numeric-hff` | O | O | O | O | O | O |
| 34 | OPTIC maintained | `rpg` | O | O | O | O | O | O |
| 35 | OPTIC-Cplex | `rpg` | O | O | O | O | O | O |
| 36 | POPF | `rpg` | O | O | O | O | O | O |
| 37 | Numeric Fast Downward | `lmcutnumeric` | O | O | O | O | O | O |
| 38 | Numeric Fast Downward | `aibr` | O | O | O | O | O | O |
| 39 | Numeric Fast Downward | `iihmax` | O | O | O | O | O | O |
| 40 | Numeric Fast Downward | `iihadd` | O | O | O | O | O | O |
| 41 | Numeric Fast Downward | `iihff` | O | O | O | O | O | O |
| 42 | Numeric Fast Downward | `irhmax` | O | O | O | O | O | O |
| 43 | Numeric Fast Downward | `irhadd` | O | O | O | O | O | O |
| 44 | Numeric Fast Downward | `irhff` | O | O | O | O | O | O |
| 45 | Numeric Fast Downward | `numeric_pdb` | O | O | O | O | X | O |

## 3. X로 제외하는 조합

### Parser 비호환 4개

- Patty × Blocksworld
- Patty × Logistics
- Pattint × Blocksworld
- Pattint × Logistics

두 planner의 parser가 합법적인 `:action-costs` 및 untyped parameter를
처리하지 못한다. benchmark invalid가 아니라 planner parser의 지원 범위
문제다.

### Numeric-effect 미지원 8개

- Numeric Fast Downward `numeric_pdb` × Barman
- PlanForge `greedy_numeric_pdb` × Barman
- PlanForge `canonical_numeric_pdb` × Barman
- PlanForge `domain_abstraction` × Barman
- PlanForge `canonical_domain_abstractions` × Barman
- PlanForge `multi_domain_abstractions` × Barman
- PlanForge `scp_online` × Barman
- PlanForge `fill_scp` × Barman

Barman의 fluent-RHS assignment 및 assignment와 additive effect의 혼합을
해당 PDB·CEGAR 구현이 지원하지 않는다. NFD 또는 PlanForge 전체를 제외하지
않고, 위 heuristic-domain 조합만 제외한다.

## 4. 실행 규모

| Domain | O | X | p000~p004 실행 case |
| --- | ---: | ---: | ---: |
| Blocksworld | 43 | 2 | 215 |
| Logistics | 43 | 2 | 215 |
| Books | 45 | 0 | 225 |
| Watering | 45 | 0 | 225 |
| Barman | 37 | 8 | 185 |
| Assembly | 45 | 0 | 225 |
| **합계** | **258** | **12** | **1,290** |

기존 전체 Cartesian product는 `45 × 6 × 5 = 1,350` case다. 기술적
비호환 12개 조합을 다섯 instance에서 제외하므로 본 실험은
`1,350 - (12 × 5) = 1,290` case다.

## 5. 결과표 기록 원칙

실행하지 않은 셀은 CSV와 논문 표에서 누락하거나 실패로 표시하지 않는다.

- Patty/Pattint의 4개 조합: `N/A — parser-incompatible`
- Barman의 8개 조합: `N/A — unsupported-numeric-effect`

세부 판정 근거는 `06_기술적_비호환과_성능실패_구분.md`를 따른다.
