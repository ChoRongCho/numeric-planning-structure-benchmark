# Delayed numeric conflict: 실제 도메인 교차 점검

이 문서는 기존 통제실험을 동일한 기준으로 다시 집계한 결과다. Barman만
early/deep failure의 근사 비교이며, Watering과 Logistics는 각각 지속 탐색과
조기 pruning에 관한 일관성 검사다. 따라서 세 비교를 동일한 인과실험으로
해석하면 안 된다.

검색 상태 수는 NFD·ENHSP·Count Downward의 `expanded_nodes`를 사용하고,
Metric-FF는 planner log의 `evaluating N states`를 사용했다.

## Barman: one-short / blocked-zero

- 역할: **early/deep 근사**
- 조작 해석: 늦게 드러나는 재고 부족과 처음부터 차단된 재고 부족 비교

| Instance | Planner / heuristic | 상태 | 시간 변화 | 탐색 상태 변화 |
|---|---|---:|---:|---:|
| p001 | count-downward-agile / `irhff` | unsolved→unsolved | 0.20→2.61초 (12.99×) | 0→31558 (—×) |
| p001 | enhsp / `hadd` | unsolved→unsolved | 0.40→5.62초 (13.99×) | —→49590 (—×) |
| p001 | enhsp / `hradd` | unsolved→unsolved | 0.40→5.62초 (13.98×) | —→49590 (—×) |
| p001 | metric-ff-cross-v1 / `numeric-hff` | unsolved→unsolved | 0.20→1.41초 (6.99×) | 2→49047 (24523.50×) |
| p001 | numeric-fast-downward-local / `irhadd` | unsolved→unsolved | 1.00→32.32초 (32.20×) | 26877→986505 (36.70×) |
| p002 | count-downward-agile / `irhff` | unsolved→timeout | 0.40→60.03초 (149.42×) | 0→78 (—×) |
| p002 | enhsp / `hadd` | unsolved→timeout | 0.40→60.02초 (149.42×) | —→56716 (—×) |
| p002 | enhsp / `hradd` | unsolved→timeout | 0.60→60.02초 (99.58×) | —→58224 (—×) |
| p002 | metric-ff-cross-v1 / `numeric-hff` | unsolved→timeout | 0.20→60.01초 (298.36×) | 2→— (—×) |
| p002 | numeric-fast-downward-local / `irhadd` | timeout→timeout | 60.03→60.03초 (1.00×) | 347498→531 (0.00×) |
| p004 | count-downward-agile / `irhff` | unsolved→timeout | 0.80→60.04초 (74.77×) | 0→39856 (—×) |
| p004 | enhsp / `hadd` | unsolved→timeout | 1.00→60.01초 (59.75×) | —→5910 (—×) |
| p004 | enhsp / `hradd` | unsolved→timeout | 0.80→60.01초 (74.67×) | —→5953 (—×) |
| p004 | metric-ff-cross-v1 / `numeric-hff` | unsolved→timeout | 0.20→60.01초 (298.48×) | 2→— (—×) |
| p004 | numeric-fast-downward-local / `irhadd` | timeout→timeout | 60.04→60.03초 (1.00×) | 38037→923 (0.02×) |

## Watering: water-tight / water-loose (battery loose)

- 역할: **지속 탐색 일관성 검사**
- 조작 해석: 배터리를 loose로 고정하고 반복 refill이 필요한 물 제약만 추가

| Instance | Planner / heuristic | 상태 | 시간 변화 | 탐색 상태 변화 |
|---|---|---:|---:|---:|
| p001 | count-downward-agile / `irhff` | solved→solved | 0.20→0.20초 (1.00×) | 1536→9486 (6.18×) |
| p001 | enhsp / `hadd` | solved→solved | 0.40→0.60초 (1.50×) | 80→5103 (63.79×) |
| p001 | enhsp / `hradd` | solved→solved | 0.40→0.80초 (2.00×) | 56→16251 (290.20×) |
| p001 | metric-ff-cross-v1 / `numeric-hff` | solved→solved | 0.20→0.20초 (1.00×) | 395→1376 (3.48×) |
| p001 | numeric-fast-downward-local / `irhadd` | solved→solved | 0.20→0.40초 (2.00×) | 105→5829 (55.51×) |
| p002 | count-downward-agile / `irhff` | solved→solved | 0.20→0.40초 (2.00×) | 2324→15770 (6.79×) |
| p002 | enhsp / `hadd` | solved→solved | 0.40→4.82초 (11.97×) | 206→190184 (923.22×) |
| p002 | enhsp / `hradd` | solved→solved | 0.40→8.43초 (20.96×) | 32→265203 (8287.59×) |
| p002 | metric-ff-cross-v1 / `numeric-hff` | solved→solved | 0.20→0.20초 (1.00×) | 471→544 (1.15×) |
| p002 | numeric-fast-downward-local / `irhadd` | solved→solved | 0.40→15.86초 (39.49×) | 3363→549228 (163.31×) |
| p003 | count-downward-agile / `irhff` | solved→solved | 0.40→2.21초 (5.50×) | 7061→134220 (19.01×) |
| p003 | enhsp / `hadd` | solved→solved | 0.40→11.85초 (29.45×) | 1641→421808 (257.04×) |
| p003 | enhsp / `hradd` | solved→solved | 0.40→1.41초 (3.50×) | 642→20486 (31.91×) |
| p003 | metric-ff-cross-v1 / `numeric-hff` | solved→solved | 0.20→0.20초 (1.00×) | 1634→3247 (1.99×) |
| p003 | numeric-fast-downward-local / `irhadd` | solved→solved | 0.60→41.36초 (68.65×) | 8081→1177378 (145.70×) |
| p004 | count-downward-agile / `irhff` | solved→solved | 0.20→0.40초 (2.00×) | 1753→14726 (8.40×) |
| p004 | enhsp / `hadd` | solved→timeout | 1.00→60.03초 (59.74×) | 6570→1010221 (153.76×) |
| p004 | enhsp / `hradd` | solved→solved | 0.60→0.80초 (1.33×) | 1805→4051 (2.24×) |
| p004 | metric-ff-cross-v1 / `numeric-hff` | solved→solved | 0.20→0.20초 (1.00×) | 442→1272 (2.88×) |
| p004 | numeric-fast-downward-local / `irhadd` | solved→timeout | 44.17→60.03초 (1.36×) | 613818→26382 (0.04×) |

## Logistics: tight/tight / loose/loose

- 역할: **조기 pruning 일관성 검사**
- 조작 해석: 연료와 예산 제약이 선택지를 일찍 제거하는지 검사

| Instance | Planner / heuristic | 상태 | 시간 변화 | 탐색 상태 변화 |
|---|---|---:|---:|---:|
| p001 | count-downward-agile / `irhff` | solved→solved | 0.20→0.20초 (1.00×) | 19→19 (1.00×) |
| p001 | enhsp / `hadd` | solved→solved | 0.40→0.40초 (1.00×) | 35→35 (1.00×) |
| p001 | enhsp / `hradd` | solved→solved | 0.40→0.40초 (1.00×) | 35→35 (1.00×) |
| p001 | metric-ff-cross-v1 / `numeric-hff` | solved→solved | 0.20→0.20초 (1.00×) | 32→32 (1.00×) |
| p001 | numeric-fast-downward-local / `irhadd` | solved→solved | 0.20→0.20초 (1.00×) | 34→34 (1.00×) |
| p002 | count-downward-agile / `irhff` | solved→solved | 0.40→0.40초 (1.00×) | 2806→2275 (0.81×) |
| p002 | enhsp / `hadd` | solved→solved | 3.81→2.61초 (0.68×) | 2065→1216 (0.59×) |
| p002 | enhsp / `hradd` | solved→solved | 3.61→2.61초 (0.72×) | 2065→1216 (0.59×) |
| p002 | metric-ff-cross-v1 / `numeric-hff` | solved→solved | 0.20→0.20초 (1.00×) | 1486→1762 (1.19×) |
| p002 | numeric-fast-downward-local / `irhadd` | solved→solved | 1.20→0.80초 (0.67×) | 2267→1063 (0.47×) |
| p003 | count-downward-agile / `irhff` | solved→solved | 0.40→0.40초 (1.00×) | 737→286 (0.39×) |
| p003 | enhsp / `hadd` | solved→solved | 2.01→58.21초 (28.99×) | 202→45992 (227.68×) |
| p003 | enhsp / `hradd` | solved→solved | 2.01→59.61초 (29.67×) | 202→45992 (227.68×) |
| p003 | metric-ff-cross-v1 / `numeric-hff` | solved→solved | 0.20→0.20초 (1.00×) | 918→975 (1.06×) |
| p003 | numeric-fast-downward-local / `irhadd` | solved→solved | 0.60→15.86초 (26.33×) | 217→32946 (151.82×) |
| p004 | count-downward-agile / `irhff` | solved→solved | 17.87→0.60초 (0.03×) | 131514→1541 (0.01×) |
| p004 | enhsp / `hadd` | solved→solved | 3.41→4.02초 (1.18×) | 392→815 (2.08×) |
| p004 | enhsp / `hradd` | solved→solved | 3.21→3.81초 (1.19×) | 392→815 (2.08×) |
| p004 | metric-ff-cross-v1 / `numeric-hff` | solved→solved | 0.20→0.20초 (1.00×) | 552→811 (1.47×) |
| p004 | numeric-fast-downward-local / `irhadd` | solved→solved | 0.80→0.80초 (1.00×) | 365→581 (1.59×) |

## 원본 action schema의 matched micro replication

Watering과 Logistics 원본 domain.pddl을 그대로 사용하고, 네 edge의 총소모량은
14로 고정한 채 비용 순서만 early=`6,6,1,1`, deep=`1,1,6,6`으로 바꿨다.
용량 10에서 실제 차단 edge는 각각 2번째와 4번째다. High 조건에는 목표로
이어지지 않는 실행 가능한 side edge 두 개를 각 중간 layer에 추가했다.

| Domain | Planner / heuristic | E/L | E/H | D/L | D/H | D/L ÷ E/L | D/H ÷ E/H |
|---|---|---:|---:|---:|---:|---:|---:|
| Logistics | count-downward-agile / `irhff` | 4 | 4 | 12 | 12 | 3.00× | 3.00× |
| Logistics | enhsp / `hadd` | 4 | 4 | 12 | 12 | 3.00× | 3.00× |
| Logistics | enhsp / `hradd` | 4 | 4 | 12 | 12 | 3.00× | 3.00× |
| Logistics | metric-ff-cross-v1 / `numeric-hff` | 14 | 22 | 26 | 42 | 1.86× | 1.91× |
| Logistics | numeric-fast-downward-local / `irhadd` | 10 | 38 | 28 | 76 | 2.80× | 2.00× |
| Watering | count-downward-agile / `irhff` | 5 | 5 | 12 | 12 | 2.40× | 2.40× |
| Watering | enhsp / `hadd` | 5 | 5 | 12 | 12 | 2.40× | 2.40× |
| Watering | enhsp / `hradd` | 5 | 5 | 12 | 12 | 2.40× | 2.40× |
| Watering | metric-ff-cross-v1 / `numeric-hff` | 24 | 44 | 34 | 64 | 1.42× | 1.45× |
| Watering | numeric-fast-downward-local / `irhadd` | 18 | 64 | 49 | 153 | 2.72× | 2.39× |

모든 planner/heuristic에서 deep 조건의 탐색 상태 수가 early보다 증가했다.
반면 side branching 증가는 Metric-FF와 NFD `irhadd`에서만 탐색 증가로
이어졌고 Count Downward와 ENHSP에서는 같은 expanded 수를 보였다. Depth 효과는
두 domain과 다섯 configuration에 공통이지만, persistent branching 효과는
휴리스틱의 dead-end 판정과 preferred-action 정책에 의존한다.

## 판정

- Barman에서 같은 문제의 두 unsolvable 변형은 모순이 즉시 보이는지, 여러
  주문 뒤에 보이는지에 따라 탐색량이 크게 달라진다. 이는 delayed-conflict
  가설과 직접 부합하지만, blocked-zero와 one-short의 부족량도 다르므로 완전한
  matched causal test는 아니다.
- Watering은 물만 tight하게 만들어도 여러 planner의 탐색량이 크게 증가한다.
  다중 자원 경쟁 없이도 반복 refill과 긴 행동 연쇄가 병목이 될 수 있다는 증거다.
- Logistics에서는 두 자원을 tight하게 한 조건이 일부 planner의 탐색량을 크게
  줄인다. 강한 제약이 선택지를 일찍 제거하면 오히려 쉬워질 수 있다는 증거다.
- 따라서 `tight resource가 많을수록 어렵다`는 설명은 세 도메인을 함께 설명하지
  못한다. 현재 결과는 `늦게까지 가능한 선택이 많이 남는가`라는 설명에
  일관되지만, Watering·Logistics에서 revelation position을 직접 조작한 추가
  실험 전에는 일반 인과결론으로 확정할 수 없다.

기존 원자료 220행에서 완성된 비교 55쌍을 만들었고, matched micro 결과 40행을 추가했다.
