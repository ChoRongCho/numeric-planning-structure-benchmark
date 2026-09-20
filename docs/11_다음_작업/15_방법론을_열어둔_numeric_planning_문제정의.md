# 방법론을 열어 둔 로봇 Numeric Planning 문제 정의

## 0. 현재 연구 단계와 증거 기반 문제 정의

### 0.1 지금까지 확인한 현상

동일한 domain과 symbolic 구조를 유지해도 resource slack, refill 필요성, horizon과
problem 배치를 바꾸면 기존 numeric heuristic의 탐색량, coverage와 first-plan
objective가 비단조적으로 변했다.

- 자원이 tight하다고 항상 어려워지지 않았다. Logistics에서는 연료와 예산을 모두
  tight하게 한 조건이 loose 조건보다 훨씬 빨랐다.
- 여러 자원이 동시에 경쟁해야 어려운 것도 아니었다. Watering은 배터리를 loose로
  두어도 물 refill만으로 timeout이 발생했다.
- 자원 하나의 총량 차이도 모순이 나타나는 시점에 따라 난도가 크게 달랐다. Barman은
  한 dose 부족한 조건이 처음부터 차단된 조건보다 오래 걸렸다.
- Metric-FF는 30개 기본 문제를 모두 빠르게 풀었지만 Logistics와 Watering에서 높은
  objective의 plan을 반환했다.
- 더 강한 numeric-aware heuristic은 더 낮은 objective를 찾는 경우가 있었지만
  problem에 따라 expanded states가 급증하거나 timeout됐다.

### 0.2 현재 데이터로 확정할 수 있는 문제

현재 증거로 정의할 수 있는 문제는 다음과 같다.

> **Sequential numeric planning에서 자원 제약의 강도와 개수만으로는 기존
> 휴리스틱의 탐색 난도와 first-plan quality를 설명할 수 없다. 같은 자원 제약도 어떤
> problem에서는 탐색량을 줄이고 다른 problem에서는 탐색량이나 plan cost를
> 증가시킨다. 그러나 현재는 이 방향 차이를 상태·action 수준에서 측정하고 예측하는
> 설명 변수와 계측 방법이 없다.**

이를 설명하기 위한 현재 작업 가설은 다음 두 경우의 차이다.

```text
early pruning
  자원 제약이 초기에 action을 제거함 → search space 감소

persistent ambiguity
  실패할 선택도 오랫동안 가능해 보임 → search space 증가 또는 나쁜 first plan
```

### 0.3 아직 확인하지 못한 원인 가설

`failure revelation depth`, `persistent branching`, relaxed plan의 false feasibility와
numeric–symbolic correlation 손실은 위 현상을 설명하기 위한 **가설**이다. 현재
runner는 탐색 중 각 상태의 실제 solvability, action별 성공 continuation, relaxed plan,
첫 resource-conflict witness를 기록하지 않았다. 따라서 지금 결과만으로 이 가설을
원인으로 확정할 수 없다.

특히 현재 benchmark에서 Metric-FF는 first-plan latency와 coverage가 이미 매우 강하다.
따라서 `미래 dead end를 조기에 찾으면 Metric-FF보다 빨라진다`는 주장도 아직 실험으로
지지되지 않는다. 현재 데이터가 직접 보여주는 Metric-FF의 약점은 주로 plan objective다.

### 0.4 지금 답해야 하는 연구 질문

> **Resource slack, replenishment 구조와 horizon을 통제했을 때, failure revelation
> depth와 persistent branching이 기존 numeric heuristic의 값 오류, 상태 확장,
> first-plan time과 objective 변화를 설명할 수 있는가?**

이 질문에는 새 알고리즘이 필요하지 않다. 먼저 작은 통제 문제에서 상태와 action의
실제 solvability를 구하고, 휴리스틱이 언제 잘못된 guidance를 주는지 계측해야 한다.
설명력이 확인되지 않으면 delayed-conflict 가설을 버리거나 수정한다.

### 0.5 원인 가설이 확인된 뒤의 알고리즘 문제

상태 수준 계측에서 delayed numeric conflict가 실제 탐색 증가의 반복 원인으로
확인된 뒤에만 다음 문제로 넘어간다.

> **Metric-FF 수준의 빠른 first-plan 탐색을 유지하면서, 확인된 delayed numeric
> conflict 신호를 낮은 비용으로 휴리스틱에 반영할 수 있는가?**

이것은 현재의 확정 문제 정의가 아니라 다음 단계의 조건부 연구 질문이다. RPG 수정,
backward requirement, LP, landmark, abstraction, portfolio와 LLM은 이 단계에서도
서로 경쟁하는 방법 후보로 남긴다.

## 1. 현재 입장

아직 LLM, anytime portfolio, LP, RPG 보강, abstraction 중 어느 하나를 연구 방법으로
확정하지 않는다. 지금까지의 실험 결과를 설명하기 위해 다음 가설을 검토한다.

> 일부 numeric planning 문제에서 실패할 행동열도 초반에는 실행 가능해 보인다.
> 수치 자원의 부족이나 충돌은 여러 action을 수행한 뒤에야 드러나며, 기존
> 휴리스틱이 이 사실을 현재 상태에 충분히 전파하지 못할수록 탐색량이 커질 수 있다.

따라서 먼저 이 현상을 측정 가능한 문제로 정의하고, 서로 다른 방법 후보가 실제로
어느 부분을 해결하는지 비교해야 한다.

## 2. 해결하려는 현상

### 2.1 즉시 불가능한 문제는 반드시 어려운 것이 아니다

Barman의 핵심 재료 재고를 0으로 만든 문제는 필요한 action이 처음부터 차단되므로
일부 planner가 매우 빨리 불가능을 판정했다. Logistics에서도 강한 연료·예산 제약이
잘못된 경로를 일찍 제거하여 느슨한 문제보다 탐색량이 줄어들었다.

### 2.2 늦게 실패하는 문제는 작은 자원 차이에도 어려워진다

Barman의 재고를 정확히 한 dose 부족하게 만들면 많은 주문을 처리한 뒤에야 마지막
재료가 없다는 사실이 드러났다. Watering에서도 현재 물과 배터리로 여러 action을
수행할 수 있지만, 긴 방문 순서 뒤에 refill이나 recharge가 필요해지면서 실패가
나타났다.

이 차이는 다음처럼 표현할 수 있다.

```text
즉시 불가능
  현재 상태 → 필요한 action 차단 → 빠른 pruning

지연된 불가능
  현재 상태 → 가능한 선택 다수 → 긴 행동열 → 자원 충돌 → 뒤늦은 pruning
```

### 2.3 어려움은 domain과 problem의 상호작용에서 생긴다

Domain은 자원의 증감, 보충, assignment와 action 조건을 정의한다. Problem은 초기
자원, 목표 수, 위치, 경로와 horizon을 정한다. 같은 domain에서도 problem이 달라지면
자원 충돌이 나타나는 시점과 그전까지 유지되는 선택지 수가 달라진다.

현재 관찰을 설명하는 작업 가설은 다음과 같다.

```text
탐색 난도 ≈ 남아 있는 선택지 수
          × 잘못된 선택의 실패가 드러나는 깊이
          × 휴리스틱이 잃는 numeric–symbolic 상관관계
```

이 식은 증명된 난도 공식이 아니라, 후속 실험에서 검증할 설명 변수다.

### 2.4 지금 확인된 사실과 아직 검증할 설명

현재 실험으로 직접 확인된 사실은 다음과 같다.

- Barman의 blocked-zero와 one-short는 모두 unsolvable이지만 판정시간이 크게 달랐다.
- Horizon이 길어지면 one-short를 비롯한 여러 조건에서 timeout이 증가했다.
- Logistics에서는 더 강한 자원 제약이 오히려 탐색량을 줄인 경우가 있었다.
- Watering에서는 자원 조건 변화에 따라 같은 휴리스틱의 탐색량과 성공 여부가 크게
  달라졌다.
- 빠른 relaxed-plan 계열과 강한 numeric-aware 계열 사이에 coverage·시간·objective
  차이가 있었다.

반면 `failure revelation depth가 증가해서 timeout됐다`, `numeric–symbolic correlation을
잃어서 plateau가 생겼다`는 설명은 아직 작업 가설이다. 지금까지의 runner는 탐색 중
각 상태의 실제 solvability, 휴리스틱 값과 첫 conflict witness를 기록하지 않았다.
따라서 다음 실험은 최종 runtime만 다시 비교하는 것이 아니라 이 중간 값을 직접
계측해야 한다.

### 2.5 여러 수치 자원의 경쟁 자체는 주된 장벽이 아니었다

처음에는 Watering의 물과 배터리, Logistics의 연료와 예산처럼 여러 수치 자원이
동시에 tight하면 탐색이 어려워진다고 예상했다. 그러나 2×2 통제실험은 **자원의
개수나 동시 tightness만으로 난도를 설명할 수 없다**는 결과를 보였다.

| 통제 결과 | 실제 관측 | 의미 |
|---|---|---|
| Watering p001~p003: 물만 loose→tight | expanded 중앙값이 Count Downward `irhff` 6.5배, NFD `irhadd` 73.6배, ENHSP `hadd` 160.4배, `hradd` 165.9배 증가 | 배터리 조건을 바꾸지 않아도 반복 refill만으로 큰 탐색 증가가 발생 |
| Watering p001~p003: 배터리만 loose→tight | numeric-aware 세 configuration은 중앙 1.5~1.6배, Count Downward는 0.3배 | 두 번째 tight 자원이 항상 큰 추가 난도를 만들지 않으며 pruning으로 탐색을 줄이기도 함 |
| Watering p004 T/L: 물 tight, 배터리 loose | NFD `irhadd`와 ENHSP `hadd`가 60초 timeout | 물×배터리의 동시 경쟁은 timeout의 필요조건이 아님 |
| Watering p004 T/T: 물·배터리 모두 tight | Metric-FF와 Count Downward가 각각 0.20초에 valid plan, ENHSP `hradd`도 0.80초·5,435 expanded에 해결 | 여러 tight 자원이 있어도 적절한 guidance에서는 first-plan 탐색이 빠를 수 있음 |
| Logistics 2×2 전체 | 연료·예산 80 case가 모두 60초 안에 valid | 두 자원의 결합 자체가 coverage 장벽이 아니었음 |
| Logistics p004 Count Downward | L/L은 131,514 expanded·17.87초, T/T는 1,541 expanded·0.60초 | 두 자원을 더 tight하게 만든 조건이 오히려 선택지를 일찍 제거함 |
| Barman p001의 핵심 stock 하나만 조작 | NFD `irhadd`가 one-short 32.3초, blocked-zero 1.0초; Metric-FF도 1.4초 대 0.2초 | 자원 조건 하나의 모순도 늦게 드러나면 즉시 차단되는 경우보다 훨씬 어려움 |

따라서 현재 증거는 다음 설명을 지지한다.

> 여러 자원이 서로 경쟁한다는 사실은 난도를 키울 수 있지만 충분조건도 필요조건도
> 아니다. 더 직접적인 병목은 잘못된 선택을 자원 제약이 초기에 제거하는지, 아니면
> 많은 action을 허용한 뒤에야 모순이 드러나는지다.

Watering에서는 반복 refill의 긴 horizon이 주된 병목이었고, Logistics에서는 tight한
두 자원이 오히려 search space를 잘랐다. Barman에서는 핵심 stock 조건 하나만
바꿨는데도 one-short 모순이 늦게 드러나자 판정시간이 증가했다. 그러므로 본 연구의
문제 정의는 `복수 자원 경쟁 처리`가 아니라 **자원 수와 관계없이 늦게 드러나는
numeric infeasibility를 조기에 인식하는 것**에 둔다.

이 결론의 원자료와 전체 조건은
[Watering·Logistics 2×2 통제실험](./13_수치자원_2x2_통제실험_결과.md)과
[Barman stock 통제실험](./14_domain_problem_상호작용과_Barman_통제실험.md)에 있다.

## 3. 더 정확한 문제의 조작적 정의

### 3.1 관찰 단위는 domain도 problem도 아닌 `상태에서의 선택`이다

Numeric planning task를 $\Pi$, 현재 상태를 $s$, 현재 적용 가능한 action을 $a$라고
하자. $s$에서 goal까지 도달하는 실제 최소 잔여 비용을 $V^*(s)$라고 하고, $a$를
선택한 뒤의 실제 비용을 $Q^*(s,a)$라고 둔다. 해가 없는 상태는
$V^*(s)=\infty$이고, 미래 dead end로 들어가는 선택은 $Q^*(s,a)=\infty$다. 휴리스틱은
이를 정확히 계산하는 대신 $h(s)$ 또는 action 선호도로 근사한다.

우리가 관찰한 문제는 다음 불일치다.

```text
실제:       어떤 선택은 결국 불가능하거나 큰 보충 detour가 필요함
휴리스틱:   현재에는 다른 선택과 비슷하게 가능하고 저렴하다고 평가함
결과:       실패 또는 고비용 경로의 prefix를 깊게 확장한 뒤에야 평가가 나빠짐
```

즉 분석 단위는 “Watering은 어렵다”와 같은 domain 수준도, “p004는 어렵다”와 같은
problem 수준도 아니다. **특정 domain–problem의 특정 상태가 이미 수치적 dead end임을
왜 인식하지 못하는지**, 그리고 solvable 상태에서는 **어떤 선택의 미래 수치 결과를
구별하지 못하는지**가 직접 분석할 대상이다.

### 3.2 Delayed numeric conflict

현재 상태에서는 적용 가능한 action이 존재하고 relaxed goal도 도달 가능해 보이지만,
그 선택 이후에는 미래의 누적 자원 부족, 보충 위치, 용량, assignment 또는 여러
자원의 결합 때문에 goal에 도달할 수 없는 경우를 **delayed numeric conflict**라고
부른다. 따라서 이 용어는 실제 dead end인 경우에만 사용한다.

예시는 다음과 같다.

- Barman: 초반 fill은 가능하지만 마지막 주문에 필요한 stock이 부족함
- Watering: 식물 방문은 가능하지만 물과 배터리를 함께 고려하면 tour 후반이 불가능함
- Logistics: 개별 도로는 통과할 수 있지만 전체 배송 경로의 연료와 예산이 부족함

### 3.3 Delayed numeric cost

Goal에는 도달할 수 있지만 현재 선택 때문에 추가 refill, recharge, 우회 이동 또는
반복 작업이 불가피해지는 경우는 **delayed numeric cost**로 구분한다. 이는 dead end가
아니며 pruning 대상도 아니다. 휴리스틱이 낮은 우선순위를 주거나 실제 objective에
가까운 비용을 부여해야 할 대상이다.

이 구분을 통해 두 문제를 섞지 않는다.

1. **Feasibility guidance:** 미래 dead end를 일찍 식별하는 문제
2. **Cost guidance:** feasible 선택 사이의 불가피한 추가비용을 구별하는 문제

첫 연구의 주대상은 feasibility guidance다. Cost guidance와 plan objective 개선은
그다음 평가 축으로 둔다.

### 3.4 Failure revelation depth

Dead end 상태 또는 잘못된 선택에서 출발해, 자원 위반이 action precondition 실패나
명백한 총수요 부족으로 표면에 나타날 때까지의 최소 action 수를 **failure revelation
depth** $d$로 둔다. 의미상으로는 처음부터 dead end일 수 있지만, 그 사실을 보여주는
수치 모순이 깊은 곳에서 나타나는 것이다. Barman one-short는 초기 상태부터 해가
없지만 마지막 dose 부족이라는 모순의 witness가 깊고, blocked-zero는 같은 종류의
모순이 첫 fill에서 드러난다.

실험에서는 통제된 작은 문제의 완전 탐색 또는 검증된 continuation으로 실제 dead end를
확인하고, 자원 위반이 표면화되는 깊이와 각 휴리스틱이 처음 $\infty$를 반환하는 깊이를
별도로 기록한다. **문제 자체의 모순 깊이**와 **휴리스틱 감지 깊이**를 섞지 않는다.

### 3.5 Feasibility ambiguity

현재의 symbolic·numeric 정보만으로 성공 경로와 실패 경로가 얼마나 비슷하게
보이는지를 **feasibility ambiguity**라고 둔다. 다음 경우 ambiguity가 높을 수 있다.

- 많은 action이 현재 numeric precondition을 통과함
- 성공과 실패 행동열의 초반 prefix가 김
- 자원을 공유하는 목표가 많음
- 보충 가능 여부가 위치와 순서에 의존함
- relaxation에서 감소, 용기 점유, ordering 또는 변수 간 상관관계가 사라짐

정확한 지표는 아직 확정하지 않는다. 적용 가능한 action 수, 첫 충돌 layer, 자원
slack, 공유 목표 수와 relaxed plan의 실제 실행 가능 비율 등을 후보로 둔다.

### 3.6 우리가 개선하려는 하나의 오류

중심 오류는 **미래의 수치적 불가능성을 현재 휴리스틱이 유한하고 유망한 것으로
평가하는 것**이다. 이것은 상황에 따라 두 형태로 관찰된다.

- 문제 전체가 unsolvable이면 $V^*(s)=\infty$인 상태를 놓친다.
- 문제는 solvable이지만 일부 선택만 실패하면 $Q^*(s,a)=\infty$인 선택을 성공
  선택과 구별하지 못한다.

둘은 별도 연구 문제가 아니다. 같은 delayed-infeasibility 인식 실패가 state 수준과
action 수준에서 나타난 것이다. 새 방법은 정확한 $V^*$나 $Q^*$ 전체를 계산할 필요가
없다. Metric-FF보다 dead end를 일찍 알아내거나 실패 선택을 뒤로 보내면서 그 추가
계산비용보다 큰 탐색 절감을 만들면 된다. Hard pruning을 사용한다면 feasible 상태나
선택을 제거하지 않는 soundness가 추가로 필요하다.

## 4. 기존 휴리스틱이 놓치는 부분

각 방법은 서로 다른 정보를 보존한다. 한 방법의 약점이 다른 방법의 장점이므로,
현재 결과만으로 특정 계열을 해답으로 고를 수 없다.

| 방법 계열 | 잘하는 부분 | 놓치거나 어려워하는 부분 | 이번 실험에서 보인 현상 |
|---|---|---|---|
| Metric-FF식 numeric relaxed plan | 매우 빠른 첫 plan, 높은 coverage | decrease, 자원 경쟁, 행동 순서와 목적함수 비용을 약하게 반영 | 전체 문제를 빠르게 풀었지만 Logistics·Watering에서 높은 objective |
| Interval-relaxed `irhff` | 값의 도달 범위를 싸게 전파하고 coverage가 높음 | 서로 다른 fluent, 위치와 자원, 여러 목표의 상관관계를 interval 하나로 잃을 수 있음 | 전반적으로 강했지만 problem에 따라 탐색량이 크게 변함 |
| Additive/subgoaling `hadd`, `irhadd` | 여러 하위 목표의 반복 비용과 수치 필요량을 더 강하게 반영 | 하위 목표의 공유·간섭을 잘못 더하거나, 긴 refill·ordering 구조에서 plateau가 커질 수 있음 | Logistics에서는 좋은 plan을 찾았지만 Watering과 긴 Barman에서 timeout |
| Redundant-constraint `hradd` | 빠진 수치 관계를 보조 제약으로 복원할 수 있음 | 어떤 제약을 추가할지가 domain에 의존하며 자동 일반화가 보장되지 않음 | 일부 문제에서 크게 개선됐지만 모든 domain에서 안정적이지 않음 |
| Numeric LM-cut | 필요한 action cost와 수치 목표를 강한 lower bound로 분리 | 계산비용, 지원 numeric fragment와 satisficing 첫 plan coverage의 부담 | valid plan의 품질은 좋지만 전체 coverage가 낮았음 |
| Numeric PDB/domain abstraction | 선택한 변수의 상호작용을 명시적으로 보존 | pattern 밖의 관계를 잃고, 큰 값 범위와 pattern 생성에 시간·메모리가 큼 | 큰 문제에서 memory·timeout이 많고 pattern에 따라 성능 변화 |
| Cartesian abstraction·CEGAR | 가짜 abstract plan의 실패 원인을 선택적으로 정밀화 | 현재 구현은 Simple Numeric Planning 범위이며 일반 assignment·복합 PDDL에 바로 적용되지 않음 | 우리 일반 benchmark와 별도 실행기로 유지해야 함 |
| Hybrid LP–RPG | 총생산·총소비와 목표의 자원 요구를 LP로 함께 계산 | 원본은 producer–consumer 구조를 가정하고 ordering, assignment, fluent-dependent effect에 제한 | Books·Assembly는 valid, Barman은 fragment 거부, Watering은 crash |
| SMT/MILP식 bounded planning | horizon 안의 수치·순서 제약을 강하게 결합 | horizon 증가에 따른 encoding과 solver 비용, 빠른 첫 plan 탐색 부담 | 일부 planner에서 작은 문제 이후 coverage가 빠르게 낮아짐 |
| Novelty·portfolio 계열 | 다양한 상태를 빠르게 탐색하고 높은 coverage를 얻을 수 있음 | 미래 자원 충돌 자체를 설명하거나 정확히 평가하는 장치는 아님 | 빠른 성능은 확인됐지만 본 문제의 원인을 직접 해결했다고 볼 수 없음 |

이 표에서 공통으로 남는 문제는 네 가지다.

1. **미래성:** 수치 충돌이 현재보다 여러 action 뒤에 나타난다.
2. **상관관계:** 자원끼리, 자원과 위치·용기·손 점유 같은 symbolic 상태가 결합된다.
3. **표현 범위:** recharge, refill, `assign`, fluent-dependent effect를 함께 지원해야 한다.
4. **계산비용:** 위 정보를 정확히 계산하면 원래 planning 문제만큼 비싸질 수 있다.

Plan quality 문제도 별도로 남는다. 빠른 휴리스틱의 평가값이 실제 PDDL objective와
정렬되지 않으면 valid plan을 빨리 찾아도 이동·시간·자원 비용이 클 수 있다.

## 5. 현재 연구 문제와 후속 알고리즘 문제

첫 연구 범위는 deterministic sequential numeric PDDL로 제한한다. `increase`,
`decrease`, `assign`, 선형 numeric precondition과 static fluent가 들어간 effect를
포함하되, 연속 변화, 외생 event와 임의의 비선형 식은 후속 범위로 둔다. 목표는
optimality 증명보다 제한시간 안의 valid first plan과 그 실행비용이다.

현재 단계의 **주 연구 질문**은 원인 설명에 관한 것이다.

> **Resource slack, replenishment 구조와 horizon을 통제했을 때, failure revelation
> depth와 persistent branching이 기존 numeric heuristic의 값 오류, 상태 확장,
> first-plan time과 objective 변화를 설명할 수 있는가?**

영문 초안은 다음과 같다.

> **To what extent do failure-revelation depth and persistent branching explain heuristic
> error, search effort, first-plan latency, and plan quality when resource slack,
> replenishment structure, and horizon are controlled?**

이 가설이 실제 state/action trace에서 확인된 뒤의 알고리즘 질문은 다음과 같다.

> Metric-FF 수준의 first-plan 성능을 유지하면서 확인된 delayed-conflict 신호를 낮은
> 비용으로 반영할 수 있는가?

Plan quality 개선은 별도 후속 문제다. 현재 데이터에서는 Metric-FF의 약점이 주로
objective에서 확인됐으므로 time–quality trade-off도 함께 기록하되, 원인 규명과
새 휴리스틱 개발을 한 단계에서 동시에 주장하지 않는다.

## 6. 세부 연구 질문

### RQ1. 통제된 구조 변화가 실제 성능을 어떻게 바꾸는가?

Domain–problem pair의 자원 slack, 보충 가능성, 위치 의존성, 목표 간 자원 공유와
horizon을 독립적으로 바꿀 때 탐색량, first-plan time과 objective가 어떻게 변하는가?

### RQ2. 휴리스틱이 어느 상태와 action에서 잘못 안내하는가?

실제 solvability와 성공 continuation을 기준으로 휴리스틱의 false-finite 평가와 action
ranking error를 직접 관찰할 수 있는가?

### RQ3. Delayed-conflict 가설이 성능 변화를 설명하는가?

Failure revelation depth와 persistent branching이 raw resource count나 tightness보다
expanded states, timeout과 objective gap을 더 잘 설명하는가?

### RQ4. 가설이 확인된 경우 어떤 최소 정보가 필요한가?

총수요 lower bound, interval, 작은 LP, landmark, abstraction, bounded lookahead처럼
강도가 다른 추론 중 어떤 정보가 가장 작은 overhead로 반복적인 오류를 제거하는가?

### RQ5. 이득이 새로운 domain과 problem에도 유지되는가?

특정 benchmark에 맞춘 규칙이 아니라, 보지 못한 자원 구조와 problem 크기에서도
coverage, first-plan latency 또는 objective를 개선하는가?

## 7. 후속 해결 방법에 요구되는 조건

RQ1~RQ3이 delayed-conflict 가설을 지지해 알고리즘 단계로 넘어갈 경우, 최종 방법은
다음 조건으로 평가한다.

| 요구사항 | 평가 질문 |
|---|---|
| 조기 감지 | 기존 휴리스틱보다 몇 action 앞에서 실패 선택을 구분하는가? |
| 오판 통제 | Feasible 선택을 dead end로 잘못 제거하거나 과도하게 낮추지 않는가? |
| Metric-FF 경쟁력 | 쉬운 문제의 first-plan time과 coverage를 Metric-FF 수준으로 유지하는가? |
| 순 탐색 이득 | 추가 휴리스틱 계산시간보다 상태 확장과 first-plan time 감소가 큰가? |
| 넓은 표현 범위 | decrease, refill, recharge, assignment와 fluent-dependent effect를 어디까지 지원하는가? |
| 상관관계 보존 | 위치·순서·여러 자원의 결합 중 무엇을 유지하는가? |
| 빠른 첫 plan | 주어진 짧은 시간 안의 valid-plan coverage가 유지되는가? |
| plan quality | 같은 시간에 더 낮은 objective의 plan을 찾는가? |
| 일반화 | 보지 못한 domain과 더 긴 horizon에서도 효과가 유지되는가? |

모든 조건을 완벽히 만족할 필요는 없다. 대신 어느 정보를 얼마의 비용으로 추가했고,
그 결과 어떤 문제군에서 이득과 손해가 발생하는지 명시해야 한다.

### 7.1 이번 연구가 직접 해결하지 않는 것

- 모든 numeric PDDL과 비선형·연속 dynamics 지원
- optimal plan 또는 unsolvability proof의 효율적 계산
- 모든 domain에서 항상 우월한 단일 휴리스틱
- 첫 연구에서 plan objective까지 동시에 최적화하는 것
- LLM을 사용하는 것 자체
- planner portfolio 선택 자체

이 항목들은 확장 또는 방법 후보가 될 수 있지만 현재 문제 정의의 성공 조건은 아니다.

## 8. 열어 둔 방법 후보

다음은 경쟁하는 후보이며 현재의 확정 방법론이 아니다.

- RPG에 남은 총수요, 최소 refill/recharge 횟수 또는 자원 부족량을 추가
- relaxed-plan layer마다 작은 LP나 resource-flow 검사를 선택적으로 수행
- numeric landmark 또는 backward requirement propagation 사용
- interval이 잃는 변수 관계만 보조 제약으로 추가
- abstraction/CEGAR로 실제 실패한 numeric–symbolic 관계만 정밀화
- 여러 휴리스틱을 병렬 또는 순차적으로 사용하는 portfolio/anytime search
- domain–problem 특징으로 추론 강도나 휴리스틱을 선택
- LLM으로 자원 관계나 보조 제약 후보를 만들고 결정적 검증기로 검사

LLM은 문제 정의에 포함되지 않는다. 사용한다면 수작업 규칙, 정적 분석, 전통적인
특징 기반 선택과 비교해 추가 이득을 증명해야 한다. 마찬가지로 anytime search나
LP도 먼저 정한 목표가 아니라 실험으로 선택할 후보다.

## 9. Delayed-conflict 가설을 검증하는 실험

### 9.1 먼저 두 원인을 독립적으로 조작한다

기존 p001~p004만으로는 problem size, resource slack, conflict depth와 branching이 함께
변한다. 다음 2×2 통제 family를 새로 만든다.

| 조건 | Failure revelation depth | Persistent branching |
|---|---|---|
| E/L | early | low |
| E/H | early | high |
| D/L | deep | low |
| D/H | deep | high |

네 조건에서 객체 수, goal 수, 총 자원 부족량과 valid branch의 길이는 같게 유지한다.
바꾸는 것은 다음 두 가지뿐이다.

- **Revelation depth:** 실패 branch의 자원 모순이 첫 action 부근에서 나타나는지, 같은
  크기의 모순이 마지막 action 부근에서 나타나는지
- **Persistent branching:** 모순이 나타나기 전까지 선택할 수 있는 실패 successor가
  적은지 많은지

Solvable family에는 정확히 하나 이상의 성공 branch와 여러 실패 branch를 함께 둔다.
Unsolvable family에는 모든 branch가 실패하되 모순이 나타나는 깊이만 다르게 둔다.
이렇게 해야 state-level dead-end detection과 action ranking을 같은 설계에서 볼 수 있다.

가장 먼저 planner와 독립적인 작은 synthetic chain domain으로 조작이 정확히
작동하는지 확인한다. 이후 실제 benchmark 구조로 옮긴다.

| Domain | Early/deep 조작 | Branching 조작 |
|---|---|---|
| Barman | 같은 one-dose deficit을 첫 주문에 필요한 재료와 마지막 주문에 필요한 재료에 각각 배치 | 동일 recipe를 처리할 수 있는 shot·shaker·fill 순서 수 조절 |
| Watering | 같은 총 물 수요와 refill 횟수에서 물 부족이 짧은 tour와 긴 tour의 끝에 나타나도록 goal 순서·수도 위치 구성 | 다음 식물과 이동 경로 선택 수 조절 |
| Logistics | 같은 총 fuel/budget deficit을 강제 경로의 첫 edge와 마지막 edge에 배치 | 비용과 길이가 비슷한 대체 도로·truck 선택 수 조절 |

Barman의 기존 blocked-zero와 one-short는 early/deep의 첫 근사지만, 부족량과 실제
주문 구조까지 완전히 같지는 않다. 새 family에서는 총 deficit과 symbolic 크기를 같게
만들어 revelation position만 바꿔야 한다.

### 9.2 작은 문제에서는 exact oracle로 정답 label을 만든다

가설 검증에는 planner의 `unsolvable` 출력만으로 부족하다. 정수 자원 범위와 객체 수가
작은 instance의 전체 reachable state graph를 BFS 또는 Dijkstra로 열거한다. Goal
state에서 reverse reachability를 계산하면 모든 상태와 action에 다음 label을 붙일 수
있다.

```text
state_solvable(s)              # s에서 goal continuation이 존재하는가
remaining_cost(s)              # 존재하면 정확한 최소 잔여 비용
successor_solvable(s, a)       # a를 선택한 뒤 goal continuation이 존재하는가
remaining_cost_after(s, a)     # action별 정확한 잔여 비용
```

반복 refill 때문에 graph가 무한해지지 않도록 micro instance는 finite integer range로
제한하고, `total-cost`처럼 계속 증가하지만 applicability에 영향을 주지 않는 metric
accumulator는 state identity에서 분리한다. Oracle이 완전 탐색할 수 없는 큰 문제는
정답 label 실험에 사용하지 않고 외부 일반화 평가에만 사용한다.

### 9.3 각 휴리스틱에서 state-level trace를 수집한다

Metric-FF `numeric-hff`, Count Downward `irhff`, NFD `irhadd`, ENHSP `hadd/hradd`에
최소한 다음 trace를 추가한다.

```text
state_id, parent_id, generating_action, search_depth,
h_value, is_heuristic_dead_end, preferred_actions,
expanded_order, heuristic_time,
relaxed_plan_actions, relaxed_plan_layers
```

Oracle label과 합치면 다음 두 오류를 직접 계산할 수 있다.

```text
false-finite state:
    state_solvable = false and h_value < infinity

bad-action ranking:
    successor_solvable(a_bad) = false,
    successor_solvable(a_good) = true,
    but heuristic prefers or ranks a_bad no worse than a_good
```

가능하면 relaxed plan을 실제 numeric semantics로 replay한다. 처음 numeric
precondition이 깨지는 layer와 누적 resource deficit이 처음 증명되는 layer를 따로
기록한다. 이것이 단순 runtime 추측이 아니라 false feasibility의 직접 증거가 된다.

### 9.4 가설 변수는 다음처럼 측정한다

| 변수 | 조작적 측정 |
|---|---|
| Conflict manifestation depth | 실패 선택 이후 실제 numeric precondition 위반 또는 resource-deficit certificate가 처음 나타나는 최소 깊이 |
| Heuristic detection depth | 해당 branch에서 휴리스틱이 처음 infinity/dead-end를 반환하는 깊이 |
| Detection lag | heuristic detection depth − 선택이 이루어진 깊이 |
| Persistent branching | 모순이 나타나기 전까지 생성된 successor 중 휴리스틱 값이 유한한 수 |
| False-feasible subtree size | Oracle상 unsolvable이지만 휴리스틱 값이 유한하여 확장된 descendant 수 |
| Ranking error rate | 성공 action이 존재하는 상태에서 실패 action을 같거나 더 높게 평가한 비율 |
| Heuristic overhead | 상태당 휴리스틱 계산시간과 전체 계산시간 |
| Search outcome | expanded states, first-plan time, coverage, VAL-valid 여부, objective |

`failure revelation depth`라는 하나의 이름으로 실제 모순 깊이와 휴리스틱 감지 깊이를
섞지 않는다. 문제 구조가 정하는 `manifestation depth`와 알고리즘이 보이는
`detection depth`를 별도 열로 저장한다.

### 9.5 어떤 결과가 나오면 가설을 지지하는가

다음 결과가 반복되어야 delayed-conflict 가설을 채택한다.

1. 객체 수, deficit과 goal 수를 고정해도 deep 조건이 early 조건보다 false-feasible
   subtree와 expanded states를 증가시킨다.
2. 같은 revelation depth에서 high-branching 조건이 low-branching보다 탐색을 늘린다.
3. `deep × high branching` 상호작용이 가장 큰 탐색 증가를 만든다.
4. `manifestation depth`, false-feasible subtree size와 ranking error가 raw resource
   count·tightness보다 expanded states와 first-plan time을 더 잘 설명한다.
5. 이 관계가 synthetic domain뿐 아니라 Barman, Watering, Logistics 중 최소 두
   domain에서 같은 방향으로 나타난다.

분석에서는 먼저 matched-pair 비율을 보고, 그다음 다음 형태의 회귀 또는 mixed-effects
model을 사용한다.

```text
log(expanded + 1)
  ~ manifestation_depth
  + persistent_branching
  + depth × branching
  + problem_size
  + resource_slack
  + planner_heuristic
```

기본 model인 `problem_size + resource_count + resource_slack`과 비교해 depth·branching을
추가한 model의 cross-validated 설명력이 실제로 높아지는지 확인한다. Seed와 domain을
바꿔도 계수 방향이 유지되어야 한다.

### 9.6 어떤 결과가 나오면 가설을 버리는가

다음 중 하나가 반복되면 delayed-conflict를 중심 문제로 채택하지 않는다.

- Revelation depth만 바꿔도 expanded states와 first-plan time이 거의 변하지 않음
- 변화가 heuristic 계산시간이나 grounding 크기로 모두 설명됨
- False-feasible state가 많아도 실제 search는 거의 확장하지 않음
- Raw topology, duplicate detection 또는 tie breaking이 depth보다 결과를 더 잘 설명함
- Barman에서만 나타나고 Watering·Logistics에는 일반화되지 않음

이 경우 탐색 실패의 중심 원인을 plateau, heuristic 계산비용, objective misalignment,
grounding 또는 topology에서 다시 찾아야 한다.

### 9.7 검증 순서

1. [x] Synthetic 2×2 family와 exact oracle 구현
2. [x] 외부 relaxation trace와 Metric-FF 실행으로 측정 pipeline 검증
3. Count Downward, NFD, ENHSP로 같은 state/action label 비교
4. Barman matched early/deep family 실행
5. [x] 기존 Watering·Logistics 통제실험으로 방향성 교차 점검
6. [x] Watering·Logistics 원본 schema의 matched micro family 실행
7. 전체 benchmark 크기의 matched revelation-position family 실행
8. 가설이 지지된 경우에만 최소 guidance prototype 구현

이 순서라면 처음부터 일반 numeric dead-end detector를 만들지 않아도 된다. 첫 결과는
`왜 어려워지는가`에 대한 검증이고, 그 결과가 충분할 때만 `어떻게 고칠 것인가`로
넘어간다.

### 9.8 첫 synthetic pilot 결과

`scripts/run/delayed_conflict_experiment.py`로 depth 6, initial fuel 2,
high branching 2의 첫 pilot을 실행했다. 네 조건 모두 Metric-FF가 plan을 찾았고 VAL에서
valid였다.

| Variant | Manifestation depth | Branching | Oracle false-finite states | Reference GBFS expanded | Metric-FF evaluated states |
|---|---:|---:|---:|---:|---:|
| early-low | 3 | 1 | 1 | 10 | 12 |
| early-high | 3 | 2 | 2 | 11 | 16 |
| deep-low | 6 | 1 | 4 | 13 | 15 |
| deep-high | 6 | 2 | 30 | 39 | 72 |

High-branching 조건에서 모순 위치만 early에서 deep으로 옮기자 grounded action 수는
동일한 199개인 상태에서 Metric-FF 평가 상태가 16개에서 72개로 4.5배 증가했다.
Oracle상 false-finite 상태도 2개에서 30개로 증가했다. Deep 조건에서 branching을
1에서 2로 바꾸면 Metric-FF 평가 상태는 15개에서 72개로 증가했다. 즉 synthetic
조작은 `deep × branching`이 false-feasible subtree와 실제 Metric-FF search effort를
함께 늘리는 예상 방향을 만들었다.

이 결과는 pipeline과 조작이 작동한다는 sanity check다. 가설의 일반적 증거로
사용하려면 seed·depth·branching sweep과 Barman·Watering·Logistics 재현이 필요하다.
첫 실행 결과는
[`results/delayed-conflict/20260919-224204`](../../results/delayed-conflict/20260919-224204/)에
보관했다.

### 9.9 실제 Barman·Watering·Logistics 교차 점검

기존 통제실험 220행을 같은 형식으로 다시 읽어 55개의 paired contrast를 만들었다.
NFD·ENHSP·Count Downward에는 `expanded_nodes`를 사용했고, 기존 CSV에서 비어 있던
Metric-FF 탐색량은 각 `planner.log`의 `evaluating N states`를 다시 추출했다. 전체
결과와 재현 스크립트는 다음 위치에 있다.

- 결과: [`results/delayed-conflict/cross-domain-evidence`](../../results/delayed-conflict/cross-domain-evidence/)
- 분석기: [`scripts/run/analyze_delayed_conflict_evidence.py`](../../scripts/run/analyze_delayed_conflict_evidence.py)

#### Barman: 늦은 모순은 실제 search를 크게 늘렸다

p001에서 `blocked-zero`와 `one-short`는 모두 unsolvable이다. 전자는 필요한 핵심
재료가 처음부터 0이고, 후자는 여러 잔을 만든 뒤 마지막 한 dose가 부족하다.

| Planner / heuristic | 즉시 모순 상태 수 | 늦은 모순 상태 수 | 증가 |
|---|---:|---:|---:|
| Metric-FF / `numeric-hff` | 2 evaluated | 49,047 evaluated | 24,523.5배 |
| NFD / `irhadd` | 26,877 expanded | 986,505 expanded | 36.7배 |
| Count Downward / `irhff` | 0 expanded | 31,558 expanded | 즉시 종료→대규모 탐색 |

Metric-FF의 실행시간도 0.20초에서 1.41초로, NFD는 1.00초에서 32.32초로 늘었다.
p002와 p004에서는 Metric-FF를 포함한 여러 configuration이 `one-short`에서 60초
timeout에 도달했지만 `blocked-zero`는 0.2~1.0초에 unsolvable을 판정했다. 이는
`확실히 안 되는 선택은 쉽고, 한동안 될 것처럼 보이는 선택은 어렵다`는 관찰에
직접 부합한다.

다만 이 비교는 아직 완전한 matched causal test가 아니다. `blocked-zero`와
`one-short`는 부족한 총량도 다르다. 따라서 Barman 결과는 강한 실제-domain 증거지만,
같은 deficit을 유지하고 모순 위치만 바꾼 후속 실험이 필요하다.

#### Watering: 자원 하나의 반복 refill만으로도 탐색이 커졌다

배터리를 loose로 고정하고 물만 loose에서 tight로 바꿨다. Metric-FF의 evaluated
states는 p001~p004에서 각각 `395→1,376`, `471→544`, `1,634→3,247`,
`442→1,272`로 모두 증가했지만 실행시간은 약 0.2초를 유지했다. 반면 numeric-aware
휴리스틱은 훨씬 민감했다.

- p002 ENHSP `hadd`: 206→190,184 expanded, 923.2배
- p002 NFD `irhadd`: 3,363→549,228 expanded, 163.3배
- p003 ENHSP `hradd`: 642→20,486 expanded, 31.9배
- p004 ENHSP `hadd`: 6,570 expanded에서 solved였으나 water-tight에서
  1,010,221 expanded 후 timeout

즉 물과 배터리 두 자원의 동시 경쟁이 없어도 물 보충을 반복해야 하는 긴 action
연쇄만으로 탐색이 크게 늘었다. 이 결과는 persistent ambiguity 설명과 일관되지만,
현재 2×2 실험은 물 부족이 나타나는 **위치**를 직접 조작하지 않았으므로 failure
revelation depth의 인과효과를 증명하지는 않는다.

#### Logistics: 강한 제약의 효과도 instance와 휴리스틱에 따라 바뀌었다

p004 Count Downward `irhff`에서는 loose/loose의 131,514 expanded가 tight/tight에서
1,541로 줄었다. 시간도 17.87초에서 0.60초로 감소했다. 이는 강한 수치 제약이
불가능한 선택을 일찍 제거하면 search space가 작아질 수 있다는 사례다.

하지만 이 방향은 보편적이지 않았다. p003에서는 tight/tight가 ENHSP `hadd`의
expanded를 202에서 45,992로, NFD `irhadd`를 217에서 32,946로 늘렸다. Metric-FF도
p001을 제외한 각 instance에서 tight/tight의 evaluated states가 소폭 증가했다.
따라서 `tight하면 쉬워진다` 역시 일반 설명이 아니다. 같은 제약이 어떤 problem에서는
초기 pruning 신호가 되고, 다른 problem에서는 긴 탐색 동안 남는 결합 조건이 된다.

#### 현재 판정

세 도메인을 함께 보면 `자원이 많다`, `자원이 tight하다`, `두 자원이 경쟁한다`는
변수만으로 난도를 설명할 수 없다. 결과는 다음의 더 구체적인 설명과 일관된다.

> 수치 제약이 강한가보다, 그 제약이 실패 선택을 얼마나 일찍 제거하며 그전까지
> 유한한 휴리스틱 값을 받는 대안이 얼마나 많이 남는가가 탐색 난도와 더 관련된다.

Synthetic 실험은 depth와 branching을 직접 통제해 이 방향을 지지했고, Barman은
실제 domain에서 매우 큰 early/deep 근사 차이를 보였다. Watering과 Logistics는 이
설명에 부합하는 사례와 중요한 비단조성을 제공했다. 아직 Watering·Logistics에서
revelation position을 독립적으로 바꾸지 않았으므로 **교차 도메인 인과가 확인됐다고
결론 내리지는 않는다.**

### 9.10 Watering·Logistics matched micro replication

9.9의 한계를 보완하기 위해 Watering과 Logistics의 **원본 domain.pddl과 action
schema를 그대로 사용한** micro problem family를 추가했다. 두 domain 모두 용량은
10, 네 개 edge의 총 자원소모는 14로 고정했다.

```text
early: 6, 6, 1, 1  → 두 번째 edge에서 차단
deep:  1, 1, 6, 6  → 네 번째 edge에서 차단
```

즉 객체 수, goal, 총 deficit과 grounded domain semantics는 같고, edge cost의 순서만
바뀐다. High-branching 조건에는 목표로 이어지지 않는 실행 가능한 side edge를 중간
layer마다 두 개 추가했다. 여덟 problem은 모두 unsolvable이며 각 planner도 이를
정상 판정했다.

| Domain | Planner / heuristic | E/L | E/H | D/L | D/H | Deep/early low | Deep/early high |
|---|---|---:|---:|---:|---:|---:|---:|
| Watering | Metric-FF `numeric-hff` | 24 | 44 | 34 | 64 | 1.42배 | 1.45배 |
| Watering | Count Downward `irhff` | 5 | 5 | 12 | 12 | 2.40배 | 2.40배 |
| Watering | NFD `irhadd` | 18 | 64 | 49 | 153 | 2.72배 | 2.39배 |
| Watering | ENHSP `hadd` / `hradd` | 5 | 5 | 12 | 12 | 2.40배 | 2.40배 |
| Logistics | Metric-FF `numeric-hff` | 14 | 22 | 26 | 42 | 1.86배 | 1.91배 |
| Logistics | Count Downward `irhff` | 4 | 4 | 12 | 12 | 3.00배 | 3.00배 |
| Logistics | NFD `irhadd` | 10 | 38 | 28 | 76 | 2.80배 | 2.00배 |
| Logistics | ENHSP `hadd` / `hradd` | 4 | 4 | 12 | 12 | 3.00배 | 3.00배 |

표의 값은 Metric-FF에는 evaluated states, 나머지에는 expanded nodes다. 모든
domain–configuration 조합에서 deep 조건이 early보다 1.42~3.00배 더 많은 상태를
탐색했다. 따라서 **같은 총 deficit에서도 모순이 늦게 드러나면 탐색이 증가한다는
효과는 Barman에만 국한되지 않았다.** Watering과 Logistics 원본 action semantics를
사용한 통제 family에서도 같은 방향이 반복됐다.

Branching 효과는 더 제한적이었다. Metric-FF와 NFD `irhadd`에서는 high 조건이 low보다
상태 수를 늘렸지만, Count Downward와 ENHSP에서는 side edge가 expanded 수를 바꾸지
않았다. 이 planner들은 해당 successor를 휴리스틱 dead end나 비선호 action으로
초기에 걸러낸 것으로 해석할 수 있다. 정확한 이유는 trace를 확인해야 한다. 따라서
현재 결과는 다음처럼 정리한다.

1. **Revelation depth 효과:** 두 실제 domain schema와 다섯 configuration에서 반복됨
2. **Persistent branching 효과:** Metric-FF와 NFD에서는 확인, 다른 configuration에는
   일반화되지 않음
3. **남은 한계:** 작은 강제-chain unsolvable 문제이므로, solvable 문제의 bad-action
   ranking과 전체 benchmark 규모에서도 재현해야 함

생성기와 원자료는 다음 위치에 있다.

- 생성·실행기: [`scripts/run/delayed_conflict_domain_micro.py`](../../scripts/run/delayed_conflict_domain_micro.py)
- 5개 configuration 실행: [`results/delayed-conflict-domain-micro`](../../results/delayed-conflict-domain-micro/)
- 통합표: [`results/delayed-conflict/cross-domain-evidence/matched-micro-results.csv`](../../results/delayed-conflict/cross-domain-evidence/matched-micro-results.csv)

## 10. 현재 단계의 결론

현재까지 확인된 것은 **자원 개수와 tightness만으로 휴리스틱의 비단조적인 성능을
설명할 수 없다는 사실**, **빠른 relaxed-plan 계열과 강한 numeric-aware 계열 사이의
시간–품질 차이**, 그리고 **synthetic family, Barman 근사 비교, Watering·Logistics
matched micro family에서 늦은 모순이 탐색을 늘렸다는 사실**이다. 특히 같은 deficit과
문제 크기에서 revelation position만 바꾼 micro 실험은 다섯 configuration 모두에서
같은 방향을 보였다. 다만 작은 unsolvable chain을 넘어 solvable 문제의 action ranking과
전체 benchmark 규모에서도 재현하기 전에는 일반적인 난도 원인으로 확정하지 않는다.

따라서 다음 단계의 기여는 새 휴리스틱이 아니라 상태·action 수준 계측으로 이 가설을
검증하는 것이다. 가설이 탐색량과 objective 변화를 실제로 설명할 때만 조기
numeric-conflict guidance를 알고리즘 문제로 채택한다.
