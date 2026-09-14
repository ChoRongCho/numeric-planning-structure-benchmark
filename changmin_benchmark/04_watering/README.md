# 04 Watering: Mobile Robot Plant Care

## 목적

로봇이 모든 식물의 물 요구량을 만족하고 물뿌리개를 반납한 뒤 base로 복귀하는
plan을 찾는다. 목적함수는 로봇의 예상 실행시간을 누적한 다음 metric이다.

```lisp
(:metric minimize (total-watering-time))
```

이는 planner가 해를 계산하는 wall-clock time이 아니다. Planning time은 별도의
실험 측정값이고, `total-watering-time`은 생성된 plan을 로봇이 실행하는 데 걸리는
예상시간이다.

## 생성기 사용법

기본 설정에서는 `BENCHMARK_PROFILES`에 고정된 p001~p004를 한 번에 재현한다.
각 profile은 문제 크기와 물·배터리 여유도를 단계적으로 변화시킨다. 새 문제를
직접 설정하려면 `USE_BENCHMARK_PROFILES=False`로 바꾸고 상단 전역변수를 수정한다.

```bash
# PDDL problem과 환경 PNG 생성
./changmin_benchmark/04_watering/problem_generator.py

# instances/p001~pNNN을 파싱해 이 README의 요약표 갱신
./changmin_benchmark/04_watering/problem_generator.py --summarize
```

생성 결과는 다음 위치에 저장된다.

- PDDL: `instances/pNNN.pddl`
- 환경 그림: `images/pNNN.png`

그림의 edge 표기 `e=5 / t=8`은 이동 시 배터리 5를 소비하고 실행시간 8이
누적된다는 의미다. Base는 항상 충전소이며 물뿌리개의 시작·반납 위치다.

### 기본 benchmark profile

| Problem | Plants | Locations | Water ratio | Battery factor | 성격 |
|---|---:|---:|---:|---:|---|
| p001 | 3 | 5 | 0.60 | 1.30 | 작은 medium 기준선 |
| p002 | 4 | 6 | 0.50 | 1.25 | 크기 증가, 물 보충 증가 |
| p003 | 5 | 7 | 0.40 | 1.15 | 물과 배터리 모두 tight해지기 시작 |
| p004 | 6 | 8 | 0.30 | 1.05 | 두 자원이 모두 tight한 결합 문제 |

문제 번호가 증가할수록 객체 수만 늘어나는 것이 아니라 자원 여유도도 함께
줄어든다. 따라서 이 네 문제는 전체 난이도 progression 확인용이고, 특정 원인의
인과효과를 측정할 때는 아래의 W/B 대조군처럼 한 축만 바꿔야 한다.

## 도메인 구조

### 변화하는 numeric 상태

| Fluent | 의미 | 변화 |
|---|---|---|
| `battery-level` | 로봇의 현재 배터리 | 이동·조작·급수 시 감소, 충전 시 완전 회복 |
| `water-level` | 물뿌리개의 현재 물 | 식물에 줄 때 감소, 수도에서 완전 회복 |
| `watered-amount` | 식물이 받은 물 | `water-one-unit`마다 1 증가 |
| `total-watering-time` | 현재 plan의 예상 실행시간 | 모든 행동에서 증가 |

`battery-capacity`, `container-capacity`, `plant-demand`, edge의 `move-energy`와
`move-time`은 문제마다 정해지는 정적 numeric 값이다.

### 행동과 기본 시간

| 행동 | 시간 | 자원 변화 |
|---|---:|---|
| 이동 | edge별 `move-time` | edge별 배터리 감소 |
| 물뿌리개 집기·놓기 | 각각 1 | 각각 배터리 1 감소 |
| 물 채우기 | 6 | 물을 capacity까지 회복, 배터리 2 감소 |
| 물 1단위 주기 | 2 | 물과 배터리 각각 1 감소 |
| 완전 충전 | 15 | 배터리를 capacity까지 회복 |

시간값은 생성기 전역변수에서 변경할 수 있다. 이 모델은 durative action을 쓰는
temporal PDDL이 아니라 action cost를 실행시간 단위로 해석하는 누적 모델이다.

## Logistics 및 Books와의 차이

세 도메인 모두 plan 실행시간을 최소화한다. Watering의 구별점은 **두 개의
replenishable resource가 서로 다른 서비스 위치와 결합**한다는 점이다.

- Logistics: 연료·예산·화물 적재와 유료/무료 경로 선택
- Books: 서가 순서·높이·공간과 카트 묶음 운반
- Watering: 물·배터리 고갈, 수도·충전소 재방문, 식물별 반복 서비스

실제 plan은 물과 배터리 잔량을 함께 고려해 식물 방문, 수도 방문, 충전소 방문을
섞어야 한다. Numeric delete relaxation이 감소 효과를 무시하면 물과 배터리를 한 번
확보한 뒤 계속 쓸 수 있는 것처럼 평가하여 필요한 보충 detour를 과소평가할 수 있다.

## 난이도 조절 가이드라인

한 번에 여러 축을 바꾸면 실패 원인을 구분하기 어렵다. 기준 instance에서 아래 축
하나만 바꾸는 대조군을 먼저 만들고, 마지막에 두 자원 축을 결합한다.

### 1. 물 여유도

`WATER_CAPACITY_RATIO`는 전체 식물 demand 대비 물통 용량의 초기 비율이다.
생성기는 가장 demand가 큰 식물 하나는 완전히 급수할 수 있도록 하면서, 기본적으로
총 demand보다 작은 용량을 만들어 최소 한 번의 재급수를 강제한다.

| 구간 | 권장 비율 | 예상 성격 |
|---|---:|---|
| Loose | `0.70~0.90` | 재급수 1회 정도, 경로 선택 중심 |
| Medium | `0.40~0.60` | 여러 식물을 묶는 순서와 재급수 위치가 중요 |
| Tight | `0.20~0.35` | 반복 재급수와 detour가 지배적 |

관측할 것은 단순 plan 길이뿐 아니라 실제 fill 횟수, 수도까지의 추가 이동시간,
휴리스틱 초깃값과 최종 metric 사이의 차이다.

### 2. 배터리 여유도

`BATTERY_CAPACITY_FACTOR`는 base에서 임의의 한 위치를 왕복해 서비스를 수행할 수
있는 보수적 최소값의 배수다. 생성 가능한 해를 보장하기 위해 1.0 미만은 허용하지
않는다.

| 구간 | 권장 배수 | 예상 성격 |
|---|---:|---|
| Tight | `1.00~1.10` | 거의 매 tour마다 충전 필요 |
| Medium | `1.20~1.50` | 식물 묶음과 충전 위치 선택이 결합 |
| Loose | `1.80~2.50` | 충전 제약 영향이 작고 물/경로가 중심 |

충전 횟수, 충전 직전 잔량, 충전소 detour, battery-related dead end를 기록한다.

### 3. 식물 분산도와 demand 편차

- `NUM_LOCATIONS`를 늘리고 plant 위치를 분산하면 routing 비중이 증가한다.
- 같은 장소에 여러 plant를 두면 한 번의 방문으로 묶어 처리할 수 있다.
- `MIN_PLANT_DEMAND`와 `MAX_PLANT_DEMAND` 차이를 키우면 큰 demand 식물을 언제
  처리할지가 중요해진다.
- 모든 demand를 같게 두면 위치 효과만 비교하는 대조군이 된다.

### 4. 수도와 충전소 배치

- 수도와 충전소를 같은 위치에 두면 한 번의 detour로 두 자원을 회복할 수 있다.
- 두 시설을 분리하면 물과 배터리 보충 순서를 따로 계획해야 한다.
- `COLOCATE_TAPS_AND_CHARGERS=False`가 기본이며, `True`로 바꾸면 시설 중첩을
  허용하는 대조군을 만들 수 있다.
- `NUM_TAPS`와 `NUM_CHARGING_STATIONS`를 늘리면 접근성은 좋아지지만 선택지가
  늘어나 branching이 커질 수 있다.
- Base는 항상 충전소지만 수도는 service zone에 두어 최초 급수 이동을 강제한다.

시설 수를 비교할 때는 위치 효과가 섞이지 않도록 동일 graph와 plant 배치를
유지하고 시설 fact만 변경하는 것이 좋다.

### 5. Graph 구조

`NUM_EXTRA_CONNECTIONS=0`이면 tree이고 우회 경로가 없다. 값을 늘리면 빠른 경로,
충전소를 경유하는 안전한 경로, 수도를 경유하는 경로 사이의 선택지가 생긴다.

- Sparse: spanning tree 또는 extra edge 0~1개
- Medium: location 수의 약 50%만큼 extra edge
- Dense: 가능한 edge의 50% 이상

Dense graph는 최단 실행시간 선택지를 늘리지만 grounding action 수도 증가시키므로,
grounding 증가와 numeric-resource 난이도를 별도로 해석해야 한다.

## 권장 실험군

| 실험군 | 물 | 배터리 | 목적 |
|---|---|---|---|
| W0/B0 | Loose | Loose | 순수 routing 기준선 |
| W1/B0 | Tight | Loose | 물 감소·재급수만 격리 |
| W0/B1 | Loose | Tight | 배터리 감소·충전만 격리 |
| W1/B1 | Tight | Tight | 두 replenishable resource의 결합 효과 |

각 군에서는 plant 수, graph, demand, 시설 위치, random seed를 동일하게 유지한다.
`W1/B1`만 실패한다면 문제 크기 자체보다 두 자원의 결합이 휴리스틱을 악화시킨다는
근거가 된다. 반대로 단일 tight 군부터 실패한다면 해당 자원의 relaxation 손실만으로
충분히 어려워진다는 반증이 된다.

## Solvability 보장 범위

생성기는 다음 보수적 plan이 항상 가능하도록 battery capacity를 계산한다.

1. Base에서 물뿌리개를 집는다.
2. 필요하면 수도를 왕복하여 물을 채운다.
3. Base에서 충전한다.
4. 식물 위치 하나를 왕복하여 급수한다.
5. 필요할 때마다 base 충전과 수도 방문을 반복한다.
6. 물뿌리개를 base에 놓고 종료한다.

따라서 기본 설정과 허용 범위에서는 자원 부족 때문에 생성 즉시 unsolvable해지는
문제를 피한다. 단, 생성 후 수동으로 capacity나 edge 값을 낮추면 이 보장은 깨진다.

## 생성 및 해 존재 점검

모든 p001~p004는 VAL parser에서 error 0, warning 0을 확인했다. 생성 직후
Metric-FF가 반환한 첫 해는 다음과 같다.

| Problem | Plan actions | 실행시간 metric |
|---|---:|---:|
| p001 | 39 | 307 |
| p002 | 60 | 403 |
| p003 | 82 | 571 |
| p004 | 83 | 610 |

p001은 ENHSP `hadd + WA*`로도 확인했으며 24 actions, 실행시간 metric 128,
planning time 약 0.31초였다.

플래너 사이의 plan 품질 차이가 크다. 이는 최적해가 증명됐다는 결과가 아니라,
동일한 실행시간 목적함수에서도 numeric relaxation과 search 방식에 따라 보충·방문
순서의 품질이 크게 달라질 수 있음을 보여주는 초기 관측이다.

<!-- AUTO-GENERATED-PROBLEM-SUMMARY:START -->
## 생성된 문제 요약

| Problem | Plants | Locations | Taps | Chargers | Total demand | Water capacity | Battery capacity |
|---|---:|---:|---:|---:|---:|---:|---:|
| `p001` | 3 | 5 | 1 | 2 | 8 | 5 | 38 |
| `p002` | 4 | 6 | 1 | 2 | 18 | 9 | 59 |
| `p003` | 5 | 7 | 1 | 2 | 20 | 8 | 74 |
| `p004` | 6 | 8 | 2 | 2 | 29 | 9 | 47 |

<!-- AUTO-GENERATED-PROBLEM-SUMMARY:END -->
