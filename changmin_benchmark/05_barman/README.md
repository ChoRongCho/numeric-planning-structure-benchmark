# 05 Barman: Numeric Robotic Bartending

## 목적

기존 Barman의 양손 점유, shot 재사용, 세척, shaker 혼합 순서를 유지하면서 실제
액체 용량과 유한한 재료 재고를 추가한다. 모든 주문을 지정된 shot에 제공하고 양손과
용기를 테이블 상태로 정리한 plan의 예상 실행시간을 최소화한다.

```lisp
(:metric minimize (total-barman-time))
```

`total-barman-time`은 로봇의 plan 실행시간이다. Planner의 wall-clock 계산시간은
별도의 성능 측정값이다.

## 생성기

```bash
# p001~p004와 대응하는 PNG를 모두 재생성
./changmin_benchmark/05_barman/generator.py

# instance를 파싱하여 README 요약표 갱신
./changmin_benchmark/05_barman/generator.py --summarize
```

- PDDL: `instances/pNNN.pddl`
- 그림: `images/pNNN.png`
- 재현성: `generator.py`의 `BENCHMARK_PROFILES`와 문제 번호별 seed 사용

## 유지한 symbolic 난이도

- 로봇은 left/right 두 손만 사용한다.
- 용기를 잡은 손은 다른 용기를 동시에 잡을 수 없다.
- 새로운 재료를 shot에 받으려면 shot이 비어 있고 깨끗해야 한다.
- 같은 재료에 사용한 shot은 세척 없이 빠르게 refill할 수 있다.
- 다른 재료로 바꾸려면 비우고 세척해야 한다.
- Cocktail은 recipe의 두 ingredient를 shaker에 순서대로 넣고 shake해야 한다.
- Shaker를 다시 사용하려면 남은 cocktail을 비우고 세척해야 한다.
- 목표에서는 주문 shot과 shaker를 테이블에 놓고 양손을 비워야 한다.

따라서 numeric을 제거해도 원래의 manipulation sequence 자체가 어렵다.

## 추가한 numeric 상태

| Fluent | 의미 | 역할 |
|---|---|---|
| `container-capacity` | shot/shaker 최대 용량 | overflow 방지 |
| `liquid-volume` | 용기의 현재 액체량 | 붓기 가능성과 shaker 잔량 제한 |
| `dispenser-stock` | dispenser에 남은 재료 | 유한한 consumable resource |
| `dispense-amount` | 한 번에 따르는 정량 | volume 및 stock 변화량 |
| `total-barman-time` | 누적 실행시간 | 최소화 목적함수 |

현재 shot은 50 ml, shaker는 100 ml다. 두 ingredient를 각각 한 shot씩 넣은 cocktail
batch는 두 개의 50 ml 주문 shot에 제공할 수 있다.

## 행동 시간

| 행동 | 시간 |
|---|---:|
| grasp / leave | 1 |
| 새 재료로 shot 채우기 | 3 |
| 같은 재료 refill | 2 |
| 붓기 | 2 |
| 남은 액체 버리기 | 1 |
| shot 세척 | 6 |
| shaker 세척 | 10 |
| shake | 8 |

이 차이 때문에 action 수만 줄이는 것과 실행시간을 줄이는 것이 항상 같지 않다.
같은 재료용 shot을 유지하면 세척을 피할 수 있고, 같은 cocktail 주문 두 잔을 하나의
batch로 처리하면 shaker 준비·세척을 줄일 수 있다.

## p001~p004 progression

| Problem | Ingredients | Cocktails | Orders | Shakers | Stock ratio | 성격 |
|---|---:|---:|---:|---:|---:|---|
| p001 | 3 | 2 | 4 | 1 | 1.50 | 작은 symbolic/numeric 기준선 |
| p002 | 4 | 3 | 6 | 1 | 1.30 | 주문 및 recipe 선택 증가 |
| p003 | 5 | 4 | 8 | 2 | 1.15 | 여러 shaker 선택과 tighter stock |
| p004 | 6 | 5 | 10 | 2 | 1.00 | 필요한 최소 재고만 제공 |

문제 번호가 증가하면서 symbolic 객체 수와 recipe 수가 늘고 numeric stock 여유는
감소한다. 이 progression은 종합 난이도를 보기 위한 것이며 원인별 실험에서는 아래
대조군을 사용한다.

## 연구용 대조군

### B0: 순수 symbolic 기준선

`liquid-volume`, capacity, stock 조건을 제거하고 원본 Barman 구조만 사용한다.
Symbolic manipulation 자체의 난이도를 측정한다.

### B1: 실행시간만 추가

실행 가능성은 B0와 같고 `total-barman-time`만 누적한다. Cost-sensitive search가
동일한 symbolic 상태공간에서 어떤 차이를 만드는지 본다.

### B2: 용량 추가

Container capacity와 liquid volume을 적용하되 dispenser stock은 충분히 크게 둔다.
Symbolic level과 실제 numeric volume의 결합 효과를 분리한다.

### B3: 유한 재고 추가

용량에 더해 dispenser stock을 실제 필요량에 가깝게 제한한다. Fill/refill의
`decrease(dispenser-stock)`가 relaxation에서 사라질 때 휴리스틱 오차가 커지는지
관측한다.

| 대조군 | 시간 metric | Volume/capacity | Finite stock |
|---|---|---|---|
| B0 | 없음 | 없음 | 없음 |
| B1 | 있음 | 없음 | 없음 |
| B2 | 있음 | 있음 | Loose |
| B3 | 있음 | 있음 | Tight |

## 관측할 구조적 실패

Numeric delete relaxation이 stock 감소를 무시하면 dispenser를 무한히 사용할 수
있는 것처럼 평가할 수 있다. 동시에 symbolic relaxation은 다음 준비 행동의 삭제
효과를 약화할 수 있다.

```text
용기를 잡으면 handempty가 사라짐
shot을 채우면 empty와 clean이 사라짐
다른 재료를 사용하려면 empty → clean 순서가 필요함
shaker를 사용하면 clean과 empty가 사라짐
```

즉 Barman의 핵심 질문은 단순히 “재고가 부족한가”가 아니다. **Numeric quantity를
만족시키기 위해 필요한 긴 symbolic preparation sequence를 relaxation이 얼마나
정확히 보존하는가**가 핵심이다.

실험에서는 다음 값을 함께 기록한다.

- plan 실행시간과 action 수
- fill/refill, shot cleaning, shaker cleaning, shake 횟수
- 같은 cocktail 주문의 batching 여부
- 초기 heuristic 값과 최종 metric 차이
- expanded nodes, evaluated states, dead ends, timeout
- stock slack을 줄였을 때 최초로 성능이 급락하는 지점

## 생성 및 smoke test 결과

모든 p001~p004는 VAL parser에서 error 0, warning 0을 확인했다. Metric-FF의 첫
해 결과는 다음과 같다. 이는 최적해나 전체 planner 비교 결과가 아니라 instance가
실제로 실행 가능함을 확인하기 위한 smoke test다.

| Problem | 결과 | Plan actions | 실행시간 metric | Planning time |
|---|---|---:|---:|---:|
| p001 | solved | 32 | 93 | 0.16초 |
| p002 | solved | 56 | 134 | 0.67초 |
| p003 | solved | 69 | 171 | 1.65초 |
| p004 | 60초 timeout | — | — | ≥60초 |

p004의 ingredient stock은 generator가 계산한 최소 필요량 이상이므로 재고 때문에
unsolvable한 문제는 아니다. 작은 세 문제는 즉시 풀리지만 symbolic 규모가 크고
stock slack이 0인 p004에서 급격히 어려워지는 경계를 의도적으로 남겼다.

<!-- AUTO-GENERATED-PROBLEM-SUMMARY:START -->
## 생성된 문제 요약

| Problem | Ingredients | Cocktails | Orders/shots | Shakers | Dispenser stock |
|---|---:|---:|---:|---:|---:|
| `p001` | 3 | 2 | 4 | 1 | 100–150 ml |
| `p002` | 4 | 3 | 6 | 1 | 50–200 ml |
| `p003` | 5 | 4 | 8 | 2 | 100–250 ml |
| `p004` | 6 | 5 | 10 | 2 | 50–250 ml |

<!-- AUTO-GENERATED-PROBLEM-SUMMARY:END -->
