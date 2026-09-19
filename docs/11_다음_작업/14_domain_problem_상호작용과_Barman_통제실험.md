# Numeric planning 난도: domain–problem 상호작용과 Barman 통제실험

## 1. 질문

기존 결과에서는 같은 domain에서도 problem마다 planner–heuristic의 성능이 크게
달라졌다. 이번 분석은 다음 질문을 더 정확히 다룬다.

> Numeric planning은 언제 어려워지는가? 수치 제약이 강할수록 항상 어려운가, 아니면
> action의 실행 가능성이 오랫동안 불확실하고 모순을 늦게 발견할 때 어려운가?

결론부터 말하면 두 번째 설명이 현재 결과에 더 잘 맞는다. Domain은 어떤 자원과
제약이 존재하는지를 정하지만, problem은 그 제약이 실제 탐색에서 언제 action을
차단하는지 정한다. 여기에 휴리스틱이 그 차단을 얼마나 빨리 알아내는지가 결합된다.

```text
난도 ≈ 지속되는 선택지 수 × 모순이 드러나는 깊이 × 휴리스틱의 정보 손실
```

수치 제약이 매우 강해 필요한 action이 처음부터 불가능하면 탐색을 즉시 끝낼 수 있다.
반대로 많은 action이 당장은 가능하지만 긴 행동열 뒤에 자원이 부족해지면, planner는
서로 비슷한 실패 경로를 많이 탐색해야 한다. 따라서 난도는 자원 부족량에 대해
단조롭게 증가하지 않을 수 있다.

## 2. Domain과 problem의 역할

Domain은 난도를 만드는 **기제**를 제공한다.

- 어떤 fluent가 감소하거나 회복되는가
- numeric condition이 어떤 action을 막는가
- 자원과 symbolic 상태가 한 action에서 어떻게 결합되는가
- 실패한 자원 사용을 되돌리거나 보충할 수 있는가

Problem은 그 기제를 **활성화하는 정도**를 정한다.

- 초기 자원과 총 필요량의 차이
- 목표 수와 최소 plan horizon
- 목표 사이의 자원 경쟁
- 이동 graph, 시설과 목표의 위치
- 실패가 드러나기 전까지 가능한 action의 수

따라서 같은 domain이라도 problem마다 난도가 달라지고, 같은 problem도 휴리스틱의
constraint propagation 능력에 따라 난도가 달라진다.

## 3. 기존 Watering·Logistics 결과의 재해석

### 3.1 Watering

Watering 통제실험에서는 물만 tight하게 바꿔도 p004의 NFD `irhadd`와 ENHSP `hadd`가
timeout됐다. 주요 병목은 물과 배터리가 동시에 부족한 상황 자체보다 다음의 긴 반복
구조였다.

```text
식물 방문 → 급수 → 물 감소 → 수도 이동 → refill → 다음 식물 방문
```

작은 물통에서도 각 급수·이동 action은 한동안 실행 가능하다. 어떤 식물 묶음을 한
tour에서 처리할 수 없는지는 여러 action 뒤에 드러난다. Relaxation이 물 감소나 refill
detour를 약하게 반영하면 실패할 방문 순서도 계속 유망하게 보인다. 즉 Watering의
난점은 반복 refill 횟수뿐 아니라 **실패 경로를 늦게 제거하는 긴 자원 horizon**이다.

### 3.2 Logistics

Logistics에서는 연료와 예산을 tight하게 만든 조건이 오히려 쉬워지기도 했다. Count
Downward `irhff`의 p004는 loose/loose에서 131,514개 상태와 17.87초가 필요했지만,
tight/tight에서는 1,541개 상태와 0.60초가 필요했다.

이는 강한 제약이 나쁜 경로를 일찍 제거했기 때문이다. 반대로 loose 조건은 가능한
도로와 차량 선택을 오래 남겨 두어 더 큰 search space를 만들었다. 수학적으로 loose
problem의 feasible plan 집합은 더 크지만, satisficing search가 첫 plan을 찾는 일은
오히려 어려워질 수 있다.

## 4. Barman 통제실험

### 4.1 설계

Barman에서는 symbolic 규모와 재고 조건이 기존 p001~p004에서 함께 변했다. 이를
분리하기 위해 각 source problem의 객체, goal, recipe, container와 action schema를
그대로 유지하고 `dispenser-stock`만 바꿨다.

| Source | 주문 수 | 해석 |
|---|---:|---|
| p001 | 4 | 매우 짧은 horizon |
| p002 | 6 | 짧은 horizon |
| p004 | 10 | 긴 horizon |

각 source problem에 네 stock regime을 적용했다.

| Regime | 설정 | 의미 |
|---|---|---|
| Abundant | 최소 필요량의 3배 | 많은 fill 선택을 허용하는 solvable 문제 |
| Boundary | 정확한 최소 필요량 | 불필요한 재료 사용을 제한하는 solvable 문제 |
| One-short | 가장 많이 필요한 재료가 한 dose 부족 | 실패가 사용 누적 뒤에 드러나는 unsolvable 문제 |
| Blocked-zero | 같은 핵심 재료의 초기 재고가 0 | 필요한 fill이 처음부터 막히는 unsolvable 문제 |

비교 configuration은 Metric-FF `numeric-hff`, Count Downward `irhff`, NFD `irhadd`,
ENHSP `hadd`, ENHSP `hradd`다. 제한시간은 case당 60초이고, 얻은 plan은 VAL로
검증했다. 총 60건 중 10건이 valid plan, 18건이 unsolvable 판정, 32건이 timeout이었다.

![Barman feasibility boundary와 horizon](./figures/controlled-barman/status_time_heatmap.png)

### 4.2 p001: 강한 제약이 solvable search를 줄였다

| Planner–heuristic | Abundant | Boundary | One-short | Blocked-zero |
|---|---:|---:|---:|---:|
| Metric-FF `numeric-hff` | Valid 0.2초 | Valid 0.2초 | Unsolved 1.4초 | Unsolved 0.2초 |
| Count Downward `irhff` | **Timeout** | Valid 0.4초 | Unsolved 2.6초 | Unsolved 0.2초 |
| NFD `irhadd` | **Timeout** | Valid 3.6초 | Unsolved 32.3초 | Unsolved 1.0초 |
| ENHSP `hadd` | **Timeout** | Valid 34.9초 | Unsolved 5.6초 | Unsolved 0.4초 |
| ENHSP `hradd` | **Timeout** | Valid 34.5초 | Unsolved 5.6초 | Unsolved 0.4초 |

네 configuration에서 Abundant가 timeout인데 Boundary는 valid plan을 찾았다. 최소
재고는 해를 없애지 않으면서 불필요한 fill과 잘못된 재료 배분을 제거했다. 따라서
solvable problem에서도 자원이 넉넉할수록 search가 쉬워진다는 보장은 없다.

두 unsolvable 조건도 큰 차이를 보였다. Blocked-zero는 모든 configuration이 1초 안에
불가능을 판정했지만, One-short는 1.4~32.3초가 필요했다. 둘 다 해가 없지만 한 dose
부족은 많은 행동열을 실행한 다음에야 모순이 드러난다.

### 4.3 horizon이 길어지면 delayed contradiction이 급격히 어려워졌다

Metric-FF는 p001의 One-short를 1.4초에 불가능으로 판정했지만 p002와 p004에서는 모두
60초 timeout됐다. Count Downward도 p001에서는 2.6초였지만 p002와 p004에서 timeout됐다.

ENHSP `hadd/hradd`는 p002와 p004에서 Abundant, Boundary, One-short를 모두 timeout했지만
Blocked-zero는 0.4~1.0초에 판정했다. 이는 긴 problem에서도 명백한 초기 모순은 빠르게
전파할 수 있지만, 누적 사용 뒤에 나타나는 모순은 쉽게 pruning하지 못한다는 뜻이다.

NFD `irhadd`는 더 강한 예외를 보였다. p002와 p004의 Blocked-zero에서도 timeout됐다.
객관적으로 action이 막혀 있어도 해당 휴리스틱이 이 사실을 goal-level dead end로
전파하지 못하면 search space가 자동으로 줄어들지 않는다.

### 4.4 Barman에서 실제로 어려운 구조

Barman의 난점은 단순한 finite stock이 아니다. 다음 상관관계가 긴 horizon에서
결합된다.

```text
재고 잔량
  × 어떤 shot/shaker가 어떤 재료를 담고 있는가
  × clean/empty/used 상태
  × 두 손의 점유 상태
  × cocktail recipe 순서와 batching
```

One-short problem에서는 대부분의 fill action이 초반에 실행 가능하다. 잘못된 배분의
결과는 여러 주문을 처리한 뒤 마지막 필요한 dose가 없을 때 나타난다. Relaxation이
stock decrease, 용기 재사용 또는 hand occupancy의 상관관계를 잃으면 실제로 실패할
상태도 목표에 가까운 것으로 평가할 수 있다.

## 5. 통합 가설: feasibility ambiguity와 pruning depth

현재 세 domain을 함께 설명하는 가설은 다음과 같다.

> Numeric planning은 수치 제약이 강해서 어려운 것이 아니라, 제약이 많은 action을
> 당장은 허용하면서 장기적으로 일부 행동열만 실패시키고, 휴리스틱이 그 실패를 이른
> 깊이에서 증명하지 못할 때 어려워진다.

이를 측정 가능한 네 요소로 나눌 수 있다.

| 요소 | 의미 | 예시 |
|---|---|---|
| Feasibility slack | 총 필요량 대비 가용 자원의 여유 | stock/required stock, water/demand |
| Persistent branching | 자원 제약 이후에도 남는 action·경로 선택지 | Logistics의 여러 도로, Barman의 fill 순서 |
| Failure revelation depth | 잘못된 선택이 불가능으로 판명되기까지 필요한 행동 수 | 마지막 dose 부족, tour 후반 물 부족 |
| Propagation strength | 휴리스틱이 미래 모순을 현재 dead end로 전파하는 능력 | blocked-zero에서 즉시 infinity를 반환하는가 |

난도는 slack 하나로 예측하기 어렵다. 다음 세 구간으로 보는 편이 정확하다.

1. **즉시 불가능:** 핵심 action이 처음부터 막히고 휴리스틱이 이를 인식하면 쉽다.
2. **경계·애매 구간:** 많은 action이 가능하지만 일부 긴 경로만 성공한다. 가장 어려울
   가능성이 크다.
3. **충분한 여유:** dead end는 줄지만 branching이 커진다. search strategy에 따라 다시
   어려워질 수 있다.

따라서 난도 곡선은 자원량에 대해 단조 증가가 아니라 중간이나 loose 영역에서도
정점이 나타날 수 있다.

## 6. 연구 질문으로 바꿀 때

아직 특정 planner 구조를 연구 주제로 확정할 필요는 없다. 현재 결과에서 바로 도출되는
연구 질문은 다음과 같다.

> Domain–problem pair에서 numeric action feasibility의 불확실성과 failure revelation
> depth를 어떻게 측정하며, 이 값이 휴리스틱별 탐색량·coverage·첫 plan 품질을 얼마나
> 설명하는가?

후보 feature는 다음과 같다.

- 최소 필요 자원 대비 초기 자원 비율
- 최소 refill/recharge 횟수
- 누적 resource constraint에 참여하는 goal 수
- 한 자원을 공유하는 action과 goal의 수
- 보충 또는 복구 가능 여부
- relaxed plan에서 무시되는 decrease 효과 수
- 처음 명백한 자원 충돌이 나타나는 relaxed-plan layer
- numeric gate를 통과한 뒤 필요한 symbolic preparation 길이

## 7. 한계와 다음 통제실험

- p001, p002, p004는 완전히 nested된 problem이 아니다. 주문 수뿐 아니라 recipe와
  shaker 구성이 달라지므로 cross-instance 차이를 순수 horizon 효과로 단정할 수 없다.
- 각 source 안의 stock 비교는 다른 모든 PDDL 요소를 고정했으므로 stock regime의
  인과효과로 해석할 수 있다.
- 60초 timeout 결과는 실제 해결시간의 하한만 제공한다.
- Unsolvable 판정 실험은 plan finding과 proof of no plan이라는 서로 다른 작업도
  비교한다. 이번 목적은 pruning 시점을 보기 위한 것이므로 둘을 구분해 보고했다.
- 다음에는 같은 recipe와 goal 구조를 반복 복제하는 nested generator로 horizon만
  `4, 6, 8, 10, 12`로 늘리고, stock slack을 `3, 2, 1, 0, -1 dose`로 sweep해야 한다.
- Watering에서는 동일 graph에서 refill 횟수와 수도 거리를 독립적으로 변화시키고,
  Logistics에서는 선택 가능한 경로 수와 연료·예산 gate를 독립적으로 변화시켜야 한다.

## 8. 재현 자료

- 실행기: [`controlled_barman_experiment.py`](../../scripts/run/controlled_barman_experiment.py)
- 분석기: [`analyze_controlled_barman_experiment.py`](../../scripts/analyze_controlled_barman_experiment.py)
- 통합 결과: [`combined.csv`](./figures/controlled-barman/combined.csv)
- 원시 p001 run: [`horizon-stock-p001-20260919-201410-818738`](../../results/controlled-barman/horizon-stock-p001-20260919-201410-818738/)
- 원시 p002/p004 run: [`horizon-stock-p002-p004-20260919-194518-753176`](../../results/controlled-barman/horizon-stock-p002-p004-20260919-194518-753176/)
