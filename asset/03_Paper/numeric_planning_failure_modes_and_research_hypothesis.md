# Classical Numeric Planning의 한계와 연구 가설 재정의

- 작성일: 2026-09-07
- 문서 상태: 연구 문제 정의를 위한 토론 정리
- 현재 단계: LLM 방법론을 설계하기 전, 기존 numeric heuristic의 failure mode를 검증하는 단계

## 1. 출발점

경험적으로 다음과 같은 현상을 관찰했다.

> 대형 환경에서 여러 numeric fluent와 symbolic decision이 조합적으로 영향을 미치는 planning problem은 기존 planner가 효율적으로 풀지 못하는 것처럼 보인다.

하지만 이를 곧바로 다음처럼 주장할 수는 없다.

> Numeric fluent가 많기 때문에 기존 numeric planner는 문제를 풀지 못한다.

그 이유는 다음과 같다.

- 기존 numeric planner는 numeric precondition과 effect를 이미 정확하게 처리한다.
- Numeric-aware relaxation, landmark, LP/IP, LM-cut 및 pattern database heuristic도 존재한다.
- Fluent가 많더라도 서로 독립적이면 문제가 반드시 어려운 것은 아니다.
- Classical planning 자체가 원래 조합적이므로 단순히 “조합폭발”이라고만 설명하면 numeric planning 고유의 문제가 되지 않는다.

따라서 연구의 첫 질문은 다음과 같이 다시 정의해야 한다.

> **기존 numeric planning은 어떤 구조의 문제에서 탐색 성능이 저하되며, 그 저하가 numeric heuristic의 어떤 정보 손실 때문에 발생하는가?**

---

## 2. “못 푼다”의 의미

Numeric planner가 문제를 못 푼다는 표현에는 서로 다른 의미가 섞일 수 있다.

### 2.1 표현 불가능

Planner 또는 지원하는 PDDL fragment가 문제의 numeric condition/effect를 표현하지 못한다.

예:

- 지원되지 않는 nonlinear expression
- Continuous process
- State-dependent effect
- Durative action과 복잡한 temporal-numeric interaction

### 2.2 정확한 transition 계산 불가능

Action applicability나 numeric effect를 정확히 계산하지 못한다.

일반적인 linear numeric planning에서는 보통 핵심 문제가 아니다. 현재 값을 numeric precondition에 대입하면 action applicability를 직접 검사할 수 있다.

### 2.3 Search failure

Problem과 transition은 정확히 표현하지만 제한시간 또는 메모리 안에 plan을 찾지 못한다.

```text
정확한 problem representation
        ↓
정확한 action applicability 검사
        ↓
Heuristic이 좋은 state를 구분하지 못함
        ↓
많은 state 확장, plateau 또는 dead end
        ↓
Timeout / memory exhaustion
```

현재 관심 대상은 주로 세 번째인 **search scalability failure**다.

### 2.4 Plan-quality failure

Feasible plan은 찾지만 trip 수, 이동 거리, energy consumption 또는 execution cost가 매우 나쁠 수 있다.

Satisficing planning과 optimal planning은 목표가 다르므로 coverage와 plan quality를 분리해서 측정해야 한다.

---

## 3. Numeric fluent의 개수보다 coupling이 중요하다

### 3.1 독립적인 numeric fluent

다음 100개의 battery가 서로 영향을 주지 않는다고 하자.

```text
battery(robot_1)
battery(robot_2)
...
battery(robot_100)
```

각 robot의 goal과 action이 독립적이라면 변수 수가 많더라도 문제를 부분적으로 분해할 수 있다.

### 3.2 강하게 결합된 소수의 fluent

반대로 다음 세 변수만 있어도 어려울 수 있다.

```text
battery
current_load
remaining_time
```

하나의 `drive` action이 다음과 같이 세 변수와 동시에 상호작용할 수 있다.

```text
travel_time        = road_distance
energy_consumption = road_distance × (base_load + current_load)
remaining_time    -= travel_time
battery           -= energy_consumption
```

이 경우 다음 결정들이 서로 독립적이지 않다.

- 어떤 package를 먼저 pickup할 것인가?
- 어떤 road를 선택할 것인가?
- 언제 충전할 것인가?
- 현재 load를 얼마나 유지할 것인가?
- Deadline 전에 목적지에 도달할 수 있는가?

따라서 난도를 결정하는 핵심 후보는 fluent의 단순 개수가 아니라 다음이다.

- Numeric fluent 간 coupling
- Numeric fluent와 symbolic action choice 간 coupling
- 한 action이 동시에 읽거나 변경하는 resource 수
- 하나의 resource를 공유하는 object와 goal 수
- Numeric effect의 state dependency
- Resource 증가와 감소가 반복되는 non-monotonicity

---

## 4. 기존 numeric heuristic은 숫자를 이미 알고 있다

기존 numeric planner는 다음과 같은 numeric-aware guidance를 사용한다.

- Numeric relaxed planning graph
- Numeric subgoaling relaxation
- Multi-repetition relaxed plan
- Numeric helpful actions
- Numeric landmarks
- LP/IP operator-counting heuristic
- Numeric LM-cut
- Numeric pattern database
- Learned GNN numeric heuristic

따라서 다음 주장은 부정확하다.

> 기존 heuristic은 numeric constraint를 알지 못한다.

더 정확한 질문은 다음이다.

> **기존 heuristic이 numeric constraint를 어떤 approximation으로 처리하며, 그 approximation이 어떤 interaction을 제거하는가?**

---

## 5. 왜 기존 heuristic이 약해질 수 있는가?

### 5.1 Resource competition의 완화

많은 heuristic은 빠른 계산을 위해 실제 planning problem을 relaxation한다. 이 과정에서 서로 경쟁하는 goal이 독립적으로 달성 가능한 것처럼 보일 수 있다.

예를 들어 carrier capacity가 12kg이고 package 무게가 다음과 같다고 하자.

```text
package A = 7kg
package B = 6kg
```

실제 problem에서는 두 package를 동시에 운반할 수 없다.

```text
7 + 6 > 12
```

그러나 relaxed heuristic이 `deliver(A)`와 `deliver(B)`를 각각 독립적으로 평가하면 다음 정보가 약해질 수 있다.

- 동일 carrier capacity를 두 goal이 공유한다.
- A를 선택하면 같은 trip에서 B를 선택할 수 없다.
- 현재 pickup 선택이 이후의 batch 구성에 영향을 준다.

즉 numeric condition 자체는 알고 있어도 **resource competition**을 충분히 보존하지 못할 수 있다.

### 5.2 Goal independence assumption

Additive 또는 subgoaling heuristic은 여러 goal의 비용을 부분적으로 독립 평가한다.

```text
h(s) ≈ h(deliver(A)) + h(deliver(B)) + h(deliver(C))
```

이때 다음 두 interaction을 놓칠 수 있다.

#### Positive interaction

```text
A와 B를 같은 trip에 운반하면 개별 운반보다 저렴하다.
```

#### Negative interaction

```text
A를 먼저 선택하면 B와 C의 좋은 batch 구성이 불가능해진다.
```

### 5.3 Aggregate bound와 실제 조합의 차이

남은 package의 총무게가 35kg이고 capacity가 12kg이면 다음 lower bound를 계산할 수 있다.

```text
ceil(35 / 12) = 3 trips
```

그러나 이 값은 개별 package의 실제 packing 가능성을 완전히 나타내지 않는다. 총무게가 같아도 다음 두 집합의 grouping 구조는 다르다.

```text
[7, 5, 6, 6]
[8, 8, 4, 4]
```

따라서 aggregate numeric progress를 잘 추정하는 것과 object-level combination을 잘 평가하는 것은 서로 다른 문제다.

### 5.4 Action repetition과 ordering의 분리

Multi-repetition relaxed plan이나 operator-counting heuristic은 action이 최소 몇 번 필요할지를 잘 추정할 수 있다.

하지만 다음을 반드시 알려주지는 않는다.

- 어떤 object에 action을 적용해야 하는가?
- 어떤 action instance를 함께 묶어야 하는가?
- 어느 순서로 수행해야 이후 resource가 부족하지 않은가?
- 지금의 선택이 미래의 feasible combination을 제거하는가?

즉 action count는 맞아도 action instantiation과 ordering guidance는 약할 수 있다.

### 5.5 Non-monotonic resource

실제 resource는 한 방향으로만 변하지 않는다.

```text
drive   → battery 감소
charge  → battery 증가
pickup  → load 증가
deliver → load 감소
```

Relaxed propagation은 계산을 단순화하기 위해 증가 가능성과 감소 가능성을 낙관적으로 합치거나 harmful effect를 약화할 수 있다. 그 결과 실제로는 동시에 유지할 수 없는 numeric condition들이 relaxed state에서는 함께 가능한 것처럼 보일 수 있다.

### 5.6 State-dependent effect

다음처럼 action cost 또는 effect가 현재 numeric state에 의존할 수 있다.

```text
energy_consumption = distance × current_load
```

이 경우 동일한 road를 이동하더라도 package 구성과 현재 load에 따라 결과가 달라진다. 단순한 constant-effect relaxation이나 독립적인 distance/load estimate는 이러한 곱셈적 interaction을 약하게 표현할 수 있다.

### 5.7 Heuristic 계산비용과 정보성의 trade-off

더 강한 LP/IP heuristic은 적은 state를 확장할 수 있지만 각 state의 heuristic 계산이 비싸다.

```text
약한 heuristic:
  evaluation은 빠름
  state expansion이 많음

강한 LP/IP heuristic:
  state expansion은 적을 수 있음
  node마다 optimization overhead가 큼
```

따라서 expanded state 수가 적다고 반드시 전체 planning time이 짧은 것은 아니다.

---

## 6. 단순한 “조합폭발” 이상의 설명

Classical planning도 본질적으로 조합적이다. 따라서 다음 설명만으로는 충분하지 않다.

> Object와 action이 많아 조합폭발이 발생한다.

Numeric planning 연구로서 더 구체적인 인과관계가 필요하다.

```text
환경 크기 증가
    +
공유 numeric resource 증가
    +
symbolic choice와 numeric effect의 coupling 증가
                    ↓
Relaxation이 resource competition과 goal interaction 제거
                    ↓
실제 remaining cost와 heuristic estimate의 차이 증가
                    ↓
State ranking 오류 및 heuristic plateau 증가
                    ↓
Expanded states 증가
                    ↓
Timeout 또는 memory exhaustion
```

이 인과관계를 실험으로 확인해야 한다.

---

## 7. 현재의 핵심 가설

### 7.1 넓은 가설

> **Numeric planner가 여러 numeric fluent를 처리하지 못하는 것이 아니라, 대형 환경에서 shared resource, symbolic choice 및 여러 numeric fluent가 강하게 결합되면 기존 relaxation-based heuristic이 중요한 상호작용을 제거하여 state ranking이 부정확해질 수 있다.**

### 7.2 검증 가능한 가설

> **Numeric fluent의 수를 통제한 상태에서 numeric-symbolic coupling 강도가 증가하면, 기존 ENHSP 계열 heuristic의 ranking accuracy가 감소하고 plateau와 state expansion이 증가한다.**

### 7.3 LLM 이전의 연구 질문

> **기존 numeric heuristic은 capacity, weight, battery와 distance의 interaction을 어떤 relaxation으로 처리하며, 어떤 문제 구조에서 그 relaxation이 search guidance에 필요한 조합 정보를 잃는가?**

이 질문에 대한 실험적 증거가 먼저 필요하다.

---

## 8. Controlled benchmark 설계

문제 크기, fluent 수 및 coupling을 한꺼번에 증가시키면 실패 원인을 알 수 없다. 각 축을 독립적으로 조절해야 한다.

### 8.1 축 A: 환경 크기

Numeric constraint의 구조는 고정하고 object 수만 증가시킨다.

```text
package 수: 5 → 10 → 20 → 40 → 80
vehicle 수: 고정
constraint: weight와 capacity만 사용
```

목적은 일반적인 combinatorial scaling을 측정하는 것이다.

### 8.2 축 B: Numeric fluent 수

Object 수와 interaction 구조를 최대한 고정하고 fluent를 추가한다.

```text
Level 1: capacity + weight
Level 2: capacity + weight + battery
Level 3: capacity + weight + battery + deadline
```

목적은 단순한 numeric dimensionality의 영향을 측정하는 것이다.

### 8.3 축 C: Coupling 강도

Fluent 수는 고정하고 action이 fluents를 결합하는 정도만 변경한다.

```text
Independent:
  battery consumption은 load와 무관

Weak coupling:
  drive energy는 distance에만 의존

Strong coupling:
  drive energy는 distance와 current_load에 동시 의존
```

목적은 변수 개수가 아니라 interaction 자체의 영향을 측정하는 것이다.

### 8.4 축 D: Capacity tightness

```text
Loose:
  capacity가 package weight보다 매우 큼

Medium:
  일부 grouping 선택이 필요

Tight:
  잘못된 grouping이 추가 trip을 직접 유발
```

예를 들어 capacity 12에서 package weight distribution을 조절해 packing 난도를 변화시킨다.

### 8.5 축 E: Goal/resource sharing

```text
Independent goals:
  각 goal이 별도 vehicle/resource 사용

Shared resource:
  여러 package가 하나의 carrier 사용

Multiple shared resources:
  여러 package가 carrier capacity와 battery를 함께 공유
```

---

## 9. “정말 못하는가?”를 판단할 지표

### 9.1 최종 planning 성능

- 제한시간 내 coverage
- Planning wall-clock time
- Peak memory
- Plan validity
- Plan length와 execution cost

### 9.2 Search behavior

- Expanded states
- Generated states
- Effective branching factor
- Duplicate states
- Dead-end detection rate
- Helpful/preferred action 수
- Heuristic evaluation time

### 9.3 Heuristic 품질

- 실제 remaining cost와 `h(s)`의 correlation
- State pair ranking accuracy
- Heuristic error
- 같은 `h(s)`를 갖는 state의 수
- Plateau 길이
- Solution path action이 helpful-action set에 포함되는 비율

### 9.4 가장 중요한 분석

두 state 중 `s1`의 실제 remaining cost가 더 작다면 heuristic도 다음 순서를 주는 것이 바람직하다.

```text
true_cost(s1) < true_cost(s2)
        ⇒
h(s1) < h(s2)
```

Coupling이 증가할수록 이 순서가 자주 뒤집히는지를 측정한다. 이것이 확인되면 단순 timeout보다 훨씬 직접적으로 heuristic failure를 설명할 수 있다.

---

## 10. 대조군과 ablation

### 10.1 Planner/heuristic 대조군

- Blind search
- Metric-FF 계열 numeric relaxation
- ENHSP numeric `h_add`
- ENHSP subgoaling/multi-repetition heuristic
- LP relaxation heuristic
- 가능하다면 IP heuristic
- Handcrafted capacity-aware heuristic

### 10.2 문제 구조 ablation

- Numeric value는 유지하고 object relation만 단순화
- Object 수는 유지하고 capacity constraint 제거
- Fluent 수는 유지하고 fluent 간 dependency 제거
- 동일 총무게에서 package weight distribution만 변경
- 동일 shortest-path distance에서 load-dependent energy effect만 제거

이를 통해 다음 효과를 분리할 수 있다.

```text
단순 problem size 효과
vs.
numeric dimension 효과
vs.
numeric-symbolic coupling 효과
vs.
resource tightness 효과
```

---

## 11. 12kg carrier에서 먼저 확인할 failure mode

### 11.1 최소 domain

- 하나의 carrier
- Capacity 12kg
- 서로 다른 weight를 가진 package
- Pickup과 delivery
- 처음에는 battery와 deadline을 제외

### 11.2 비교할 instance family

```text
Easy / loose:
  대부분의 package를 여러 방식으로 함께 적재 가능

Tight:
  일부 조합만 capacity를 효율적으로 사용

Adversarial:
  greedy한 pickup이 이후 batch를 깨뜨림
```

예:

```text
capacity = 12
weights  = [7, 5, 6, 6, 4, 4, 3]
```

### 11.3 확인할 질문

1. ENHSP heuristic은 최소 trip 수를 얼마나 정확히 추정하는가?
2. Package distribution이 달라져도 총무게가 같으면 동일한 heuristic 값을 주는가?
3. 좋은 batch를 유지하는 state와 깨뜨리는 state를 구분하는가?
4. Tightness 증가에 따라 plateau가 길어지는가?
5. Helpful action set에 좋은 pickup action이 포함되는가?

여기서 명확한 failure가 관찰돼야 LLM이 보완할 대상이 생긴다.

---

## 12. LLM 연구로 연결되는 조건

LLM은 처음부터 전제하지 않는다. 다음 결과가 먼저 확인되어야 한다.

```text
1. 기존 numeric heuristic의 성능이 coupling에 따라 체계적으로 악화됨
2. 단순 problem size만으로는 그 악화를 설명할 수 없음
3. 실패가 resource grouping 또는 symbolic-numeric interaction 손실과 연결됨
4. Handcrafted interaction-aware heuristic은 이 실패를 일부 복구함
```

특히 4번이 중요하다. 사람이 만든 간단한 grouping-aware heuristic도 기존 heuristic보다 좋아지지 않는다면 LLM을 넣을 근거가 약하다.

위 조건이 확인된 후 다음 연구 질문으로 이동한다.

> **2B 이하 SLM이 PDDL의 domain structure와 numeric fluent를 읽고, handcrafted interaction-aware heuristic에 가까운 domain-dependent soft guidance를 자동으로 생성할 수 있는가?**

LLM의 출력은 hard subgoal이나 pruning이 아니라 우선 heuristic score 또는 preferred-action ranking으로 제한한다. Action applicability와 plan validity는 classical numeric planner가 계속 담당한다.

---

## 13. 현재 연구의 단계적 구조

### Phase 1: 기존 planner 이해

- Numeric relaxation이 어떻게 동작하는지 분석
- ENHSP heuristic 설정과 출력 확인
- LP/IP heuristic과 subgoaling heuristic 비교

### Phase 2: Failure mode 확인

- Controlled Capacitated Transport benchmark 작성
- Size, fluent 수, coupling과 tightness 독립 조절
- Ranking accuracy, plateau 및 state expansion 측정

### Phase 3: 설명 가능한 oracle 구성

- Handcrafted grouping-aware heuristic 작성
- 기존 heuristic이 놓친 interaction을 보완할 수 있는지 확인

### Phase 4: LLM/SLM 도입

- Corrêa et al. 방식으로 heuristic code 생성
- 2B 이하 SLM과 대형 LLM 비교
- Numeric counterfactual ablation 수행

### Phase 5: 다중 constraint 확장

- Capacity + battery
- Capacity + battery + distance
- 필요하면 deadline과 temporal constraint 추가

---

## 14. 지금 시점의 결론

기존 numeric planner가 “여러 numeric fluent를 아예 처리하지 못한다”고 말하기는 어렵다. Numeric-aware heuristic은 이미 존재하며, 일부 방법은 numeric condition, 반복 횟수, landmark와 resource bound를 직접 계산한다.

현재의 유력한 문제는 다음과 같다.

> **대형 환경에서 여러 object와 goal이 numeric resource를 공유하고 symbolic action choice와 numeric effect가 강하게 결합되면, 계산 효율을 위해 사용한 relaxation이 resource competition과 object-level combination을 제거한다. 그 결과 heuristic의 state-ranking 능력이 약해져 search가 급격히 커질 수 있다.**

그러나 이것은 아직 연구 결과가 아니라 검증해야 할 가설이다. 첫 연구 단계는 기존 planner가 정말 이 구조에서 실패하는지 controlled benchmark로 확인하는 것이다.

### 한 문장 연구 질문

> **Numeric-symbolic coupling과 resource tightness가 증가할 때 기존 numeric heuristic의 정보 손실과 search 성능 저하가 실제로 발생하는가?**

이 질문에 긍정적인 결과가 나온 뒤에야 다음 질문이 정당화된다.

> **작은 언어모델이 그 손실된 combinatorial resource interaction을 domain-dependent soft heuristic으로 복원할 수 있는가?**

---

## 15. 참고문헌

- [Scala et al., Search-Guidance Mechanisms for Numeric Planning Through Subgoaling Relaxation, ICAPS 2020](https://ojs.aaai.org/index.php/ICAPS/article/view/6665)
- [Piacentini et al., Linear and Integer Programming-Based Heuristics for Cost-Optimal Numeric Planning, AAAI 2018](https://ojs.aaai.org/index.php/AAAI/article/download/12082/11941)
- [Piacentini et al., Compiling Optimal Numeric Planning to Mixed Integer Linear Programming, ICAPS 2018](https://ojs.aaai.org/index.php/ICAPS/article/view/13919)
- [Kuroiwa et al., LM-Cut Heuristics for Optimal Linear Numeric Planning, ICAPS 2022](https://ojs.aaai.org/index.php/ICAPS/article/download/19803/19562/23816)
- [Chen and Thiébaux, Novelty Heuristics, Multi-Queue Search, and Portfolios for Numeric Planning, 2024](https://arxiv.org/abs/2404.05235)
- [Gnad et al., PDBs Go Numeric, AAAI 2025](https://ojs.aaai.org/index.php/AAAI/article/view/34851)
- [Borelli et al., Learning Heuristic Functions with Graph Neural Networks for Numeric Planning, AAAI 2026](https://ojs.aaai.org/index.php/AAAI/article/view/40935)
- [Corrêa et al., Classical Planning with LLM-Generated Heuristics, NeurIPS 2025](https://proceedings.neurips.cc/paper_files/paper/2025/hash/3bf4b55960aaa23553cd2a6bdc6e1b57-Abstract-Conference.html)
- [ENHSP official repository](https://github.com/hstairs/enhsp)
