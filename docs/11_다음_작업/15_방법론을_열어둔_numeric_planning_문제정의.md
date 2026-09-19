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

## 9. 방법을 고르기 전에 필요한 실험

1. Barman에서 horizon과 stock slack을 독립적으로 변화시킨다.
2. Watering에서 목표 수, 물 용량, recharge 필요성과 보충 장소 거리를 분리한다.
3. Logistics에서 경로 branching과 연료·예산 slack을 분리한다.
4. 각 상태에서 relaxed plan의 실행 가능성, 첫 numeric conflict layer와 실제 dead end
   깊이를 기록한다.
5. 휴리스틱 계산시간과 상태 확장 감소를 함께 측정한다.
6. objective를 제외한 실험과 포함한 실험을 나눠 feasibility guidance와 quality
   guidance를 구분한다.

작은 통제 문제에서는 탐색 중 표본을 다음 단위로 저장한다.

```text
domain, problem, state_id, action,
state_solvable, action_has_goal_continuation,
remaining_cost_or_infinity,
resource_conflict_witness_depth,
heuristic_name, heuristic_value, heuristic_dead_end,
heuristic_time, expanded_before_detection
```

이 데이터가 있어야 `문제가 어려웠다`는 결과에서 한 단계 더 나아가, 기존 휴리스틱이
실제 dead end를 놓친 것인지, feasible 선택의 순서만 잘못 정한 것인지, 아니면
휴리스틱 계산 자체가 비쌌는지를 구분할 수 있다.

이 실험 뒤에 가장 작은 정보 추가로 반복적인 delayed conflict를 제거하는 방법을
우선 구현한다. 결과가 지지하지 않으면 다른 후보로 바꾼다.

## 10. 현재 단계의 결론

현재까지 확인된 것은 **자원 개수와 tightness만으로 휴리스틱의 비단조적인 성능을
설명할 수 없다는 사실**과 **빠른 relaxed-plan 계열과 강한 numeric-aware 계열 사이의
시간–품질 차이**다. Forward search가 미래 수치 실패를 늦게 발견한다는 설명은 아직
유력한 가설이지 확인된 결론이 아니다.

따라서 다음 단계의 기여는 새 휴리스틱이 아니라 상태·action 수준 계측으로 이 가설을
검증하는 것이다. 가설이 탐색량과 objective 변화를 실제로 설명할 때만 조기
numeric-conflict guidance를 알고리즘 문제로 채택한다.
