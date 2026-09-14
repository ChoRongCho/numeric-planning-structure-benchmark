# Numeric Planning 기초와 LLM Heuristic 연구 재정의

- 작성일: 2026-09-07
- 문서 목적: 지금까지의 토론을 바탕으로 numeric planning의 고전적 해결 방식과 LLM의 연구 공백을 구분한다.
- 연구 범위: 이미 주어진 symbolic/numeric PDDL domain과 problem을 푸는 search guidance
- 제외 범위: 자연어에서 PDDL 생성, LLM의 end-to-end plan generation

## 1. 문제의식 변화

초기 아이디어는 다음과 같았다.

> LLM/SLM이 numeric constraint를 이해하여 heuristic, subgoal 또는 preferred action의 형태로 classical planner의 탐색을 안내한다.

그러나 관련 문헌을 살펴보면서 먼저 해결해야 할 지식 공백이 드러났다.

> **기존 classical numeric planner는 numeric constraint를 어떻게 처리하고, 어떤 numeric-aware heuristic을 사용하는가?**

Numeric constraint를 다루는 heuristic은 이미 존재한다. 따라서 연구를 다음처럼 주장해서는 안 된다.

> 기존 planning heuristic은 숫자를 이해하지 못하므로 LLM이 numeric constraint를 이해하게 한다.

보다 정확한 연구 방향은 다음과 같다.

> 기존 numeric heuristic이 relaxation 과정에서 잃는 domain-specific 또는 combinatorial resource interaction을 LLM-generated guidance가 보완할 수 있는가?

---

## 2. Numeric planning problem

일반 classical planning의 state는 Boolean fact의 집합으로 표현된다.

```text
at(robot, A)
delivered(package1)
connected(A, B)
```

Numeric planning state에는 Boolean fact와 함께 numeric fluent 값이 포함된다.

```text
Boolean state:
  at(robot, A)
  in(package1, carrier)

Numeric state:
  load(carrier) = 7
  capacity(carrier) = 12
  battery(robot) = 30
  distance(A, B) = 10
```

형식적으로는 다음과 같이 볼 수 있다.

```text
s = <F, x>

F: 현재 참인 propositional facts
x: 현재 numeric fluent의 값 벡터
```

Action은 다음을 포함한다.

- Boolean precondition
- Numeric precondition
- Boolean effect
- Numeric assignment/increase/decrease effect

예를 들어 carrier의 현재 load가 7kg이고 package가 6kg이며 capacity가 12kg이면 다음 조건은 거짓이다.

```text
current_load + package_weight <= capacity
7 + 6 <= 12                         false
```

따라서 해당 `pickup` action은 현재 state에서 applicable하지 않다.

이 검사는 반드시 MILP가 필요한 것이 아니다. 현재 numeric 값을 수식에 대입해 직접 계산할 수 있다.

---

## 3. Constraint checking과 heuristic guidance의 구분

Numeric planner에는 서로 다른 두 기능이 존재한다.

### 3.1 정확한 transition 및 constraint checking

- 현재 state에서 action의 numeric precondition을 계산한다.
- Applicable action만 successor를 생성한다.
- Numeric effect를 정확히 적용한다.
- Goal의 symbolic/numeric condition을 검사한다.
- Constraint를 위반하는 plan을 배제한다.

이 부분은 plan validity와 goal achievement를 담당한다.

### 3.2 근사적인 heuristic guidance

- 목표까지 action이 대략 몇 번 더 필요한가?
- 목표 numeric value까지 얼마나 부족한가?
- 어떤 resource를 먼저 확보해야 하는가?
- 어떤 action이 현재 유망한가?
- 현재 state가 dead end에 가까운가?

이 부분은 search efficiency를 담당한다.

```text
현재 state
    ↓
정확한 numeric precondition 검사
    ↓
Applicable successor 생성
    ↓
각 successor의 근사 heuristic h(s) 계산
    ↓
GBFS / Weighted A* / A* open list에 삽입
```

따라서 heuristic이 부정확하더라도 symbolic/numeric transition engine이 정확하다면 잘못된 action sequence를 valid plan으로 반환하지 않는다. 다만 탐색시간, coverage와 plan quality는 나빠질 수 있다.

---

## 4. Classical numeric planning의 주요 해결 방식

Numeric planning은 크게 두 방식으로 해결할 수 있다.

### 4.1 Heuristic state-space search

현재 state에서 applicable action을 적용하며 search tree 또는 graph를 탐색한다.

```text
Numeric PDDL
    ↓
Forward state-space search
    ↓
Numeric-aware heuristic으로 state ordering
    ↓
Feasible plan 발견
```

대표적인 search algorithm은 다음과 같다.

- Greedy Best-First Search
- Weighted A*
- A*
- Enforced Hill Climbing
- Multi-queue search

Metric-FF와 ENHSP 등이 이 흐름에 속한다.

### 4.2 Constraint solver로 compilation

일정 길이의 plan에 대해 다음 항목을 하나의 수학적 문제로 encoding한다.

- 각 시점에 선택되는 action
- State transition
- Numeric constraint
- Action ordering
- Plan cost

이를 MILP, SMT 또는 다른 constraint solver로 해결한다.

```text
Planning problem + plan horizon k
                 ↓
         MILP/SMT formulation
                 ↓
     전체 action sequence 동시 결정
```

이 방식은 forward search를 전혀 하지 않을 수도 있다. 따라서 numeric planning을 “search 중 매 state마다 MILP로 constraint를 검사하는 것”으로만 이해하면 안 된다.

### 4.3 Search와 LP/MILP의 결합

두 방식은 결합할 수도 있다. Forward search를 수행하되 각 state에서 LP 또는 IP를 풀어 남은 비용의 lower bound나 근사치를 heuristic 값으로 사용한다.

```text
Search state s
    ↓
LP/IP model 구성
    ↓
목표 달성에 필요한 최소 action/resource 비용 추정
    ↓
h(s)로 사용
```

---

## 5. 기존 numeric-aware heuristic

### 5.1 Numeric Relaxed Planning Graph와 Metric-FF

Classical FF heuristic은 delete effect를 무시한 relaxed problem을 풀고, 추출된 relaxed plan의 길이나 비용을 heuristic으로 사용한다.

Numeric planning에서는 relaxed planning graph가 Boolean proposition뿐 아니라 numeric variable이 도달할 수 있는 값 또는 범위를 함께 전파한다.

예를 들어 다음 상황을 생각할 수 있다.

```text
현재 battery = 3
drive action은 battery >= 5 필요
charge action은 battery를 4 증가
```

Relaxed graph는 대략 다음 가능성을 발견한다.

```text
charge 1회 → battery 7 → drive 가능
```

이를 바탕으로 다음을 얻는다.

- Goal까지의 relaxed distance
- Relaxed plan
- Helpful action
- Dead-end 추정

장점은 빠른 계산이지만, resource consumption, delete effect 및 action 간 상호배타성을 낙관적으로 무시할 수 있다.

### 5.2 Numeric subgoaling relaxation

Numeric goal 또는 precondition을 만족시키는 데 필요한 action과 그 precondition을 regression한다.

예를 들어 목표가 `fuel >= 20`, 현재 fuel이 5이고 `refuel`이 5씩 증가시킨다면 최소 반복 횟수를 다음처럼 추정할 수 있다.

```text
ceil((20 - 5) / 5) = 3
```

실제 subgoaling 방법은 여러 Boolean/numeric condition과 action dependency를 재귀적으로 분석한다. Multi-repetition relaxed plan은 각 action이 몇 번 필요한지도 표현한다.

이 구조는 다음 용도로 사용된다.

- Concrete relaxed-plan heuristic
- Subgoaling-based helpful actions
- Up-to-jumping actions

중요한 점은 subgoal을 독립된 planning goal로 강제하지 않고, heuristic 또는 helpful-action guidance로 사용할 수 있다는 것이다.

### 5.3 LP/IP 기반 heuristic

각 action의 필요 실행 횟수를 변수로 두고 목표의 numeric condition을 만족시키는 최소 비용을 계산할 수 있다.

```text
y_charge = charge action의 예상 실행 횟수
y_drive  = drive action의 예상 실행 횟수

current_fuel + 5*y_charge - 3*y_drive >= required_fuel
```

목적함수는 다음과 같이 둘 수 있다.

```text
minimize sum(action_cost[a] * y[a])
```

- 연속 변수로 relaxation하면 LP heuristic
- 정수 실행 횟수를 요구하면 IP/MILP heuristic

LP는 상대적으로 빠르지만 bound가 약할 수 있다. IP/MILP는 더 정확할 가능성이 있지만 heuristic evaluation 자체가 비싸질 수 있다. Numeric structure가 강한 domain에서는 이득이 있을 수 있지만, propositional structure가 큰 domain에서는 overhead가 이득을 상쇄할 수 있다.

### 5.4 Numeric landmarks

모든 valid plan이 반드시 거쳐야 하는 numeric condition을 찾는다.

예를 들어 어떤 긴 도로를 통과하려면 반드시 `battery >= 20`이어야 한다면 다음과 같은 dependency를 얻을 수 있다.

```text
최종 goal
  ↑
긴 도로 통과
  ↑
battery >= 20
  ↑
충전 action 또는 충전소 방문
```

아직 달성되지 않은 landmark, landmark 비용 또는 순서를 heuristic으로 사용할 수 있다.

LLM이 알고 있는 “긴 도로를 가기 전에 충전해야 한다”는 common sense와 유사하지만, classical planner는 PDDL action model의 구조로부터 이를 계산한다.

### 5.5 Numeric LM-cut, operator counting과 PDB

Optimal numeric planning을 위해 다음과 같은 admissible 또는 lower-bound heuristic도 연구되어 있다.

- Numeric hmax
- Numeric LM-cut
- Operator-counting LP
- Cost partitioning
- Numeric Pattern Database

Numeric variable은 값의 범위가 무한할 수 있어 finite abstraction을 만드는 것이 핵심 난점이다. 이 계열은 optimality가 중요한 연구에는 필요하지만, 현재 목표인 satisficing coverage와 빠른 plan 발견에는 Metric-FF 및 ENHSP subgoaling보다 우선순위가 낮다.

### 5.6 Learned numeric heuristic

최근에는 object relation, numeric condition 및 현재 fluent 값을 graph로 표현하고 GNN이 `h(s)`를 출력하도록 학습하는 방법도 있다.

이는 다음 비교 질문을 만든다.

> Pretrained LLM이 생성한 domain-specific heuristic과 numeric planning data로 학습한 GNN heuristic은 각각 어떤 일반화 특성을 가지는가?

---

## 6. 12kg carrier 예시

### 6.1 문제

- 서로 다른 무게의 package 10개
- Carrier capacity는 12kg
- Robot이 package를 pickup하고 destination에 delivery
- 모든 package를 배달하는 것이 목표

예를 들어 남은 package 무게가 다음과 같다고 하자.

```text
[7, 5, 6, 6, 4, 4, 3]
```

### 6.2 Exact constraint checking

현재 load가 7kg인 상태에서 6kg package를 pickup하려고 하면:

```text
7 + 6 > 12
```

이므로 해당 action은 applicable하지 않다. 이것은 heuristic이 아니라 정확한 transition constraint다.

### 6.3 Numeric-unaware heuristic

```text
h(s) = 아직 배달하지 않은 package 수
```

이 함수는 weight와 capacity를 보지 않는다.

### 6.4 단순 numeric-aware lower bound

남은 총무게가 35kg라면 최소 trip 수는 다음처럼 추정할 수 있다.

```text
ceil(35 / 12) = 3
```

이 값은 capacity를 인식하지만 개별 package가 실제로 어떻게 packing되는지는 충분히 설명하지 못한다.

### 6.5 Combinatorial interaction

총무게가 같더라도 package 구성에 따라 feasible batch가 달라질 수 있다.

```text
[7, 5, 6, 6]
[8, 8, 4, 4]
```

Relaxed heuristic은 각 numeric subgoal을 독립적으로 근사하거나 resource consumption을 느슨하게 취급하면서 다음 정보를 잃을 수 있다.

- 어떤 package를 함께 운반해야 유리한가?
- 목적지와 경로까지 고려했을 때 어떤 grouping이 좋은가?
- 현재 load의 잔여 capacity를 어떤 package에 배분해야 하는가?
- 당장의 progress가 이후 trip 수를 증가시키는가?

이 지점이 LLM을 투입할 수 있는 후보 공백이다.

---

## 7. LLM의 역할 재정의

### 7.1 부정확한 연구 가설

```text
기존 heuristic은 numeric constraint를 이해하지 못한다.
LLM이 numeric constraint를 이해해 이를 해결한다.
```

기존 numeric planner는 numeric condition, numeric effect, 필요 반복 횟수 및 일부 resource dependency를 이미 명시적으로 처리한다. 따라서 이 가설은 성립하기 어렵다.

### 7.2 더 정확한 연구 가설

```text
기존 numeric relaxation은 수치 조건을 처리하지만,
relaxation 과정에서 domain-specific하고 조합적인 resource interaction을 잃을 수 있다.

LLM/SLM이 생성한 domain-dependent heuristic program이
이 손실된 구조를 soft guidance로 보완할 수 있는가?
```

### 7.3 LLM이 담당하지 않는 것

- Action applicability의 최종 판정
- Numeric constraint의 최종 validation
- PDDL domain/problem 생성
- 실행 plan 전체의 직접 생성
- Subgoal ordering의 강제 결정
- Optimality 또는 admissibility 보장

### 7.4 LLM이 담당할 수 있는 것

- Domain-specific heuristic code 생성
- Numeric fluent와 object relation을 결합한 state score 생성
- Candidate package grouping의 soft score 생성
- Numeric subgoal proximity 계산식 제안
- Existing numeric heuristic과 결합할 보조 term 제안
- Preferred action의 soft ranking 제안

핵심은 LLM이 만든 subgoal이나 batch를 실제 중간 planning goal로 강제하지 않는 것이다.

```text
LLM proposal
    ↓
soft heuristic term 또는 preferred-action signal
    ↓
classical numeric planner가 전체 search 유지
    ↓
exact transition checker가 plan validity 보장
```

---

## 8. LLM heuristic baseline

주 방법론 baseline은 Corrêa et al.의 LLM-generated heuristic code 방식이다.

```text
PDDL domain + training instances + planner API
                    ↓
          LLM이 heuristic code 후보 생성
                    ↓
     training problems에서 GBFS로 후보 평가
                    ↓
             가장 좋은 함수 선택
                    ↓
      unseen larger problems에 재사용
```

이 방식의 장점은 다음과 같다.

- LLM이 plan을 직접 생성하지 않는다.
- Runtime에 LLM을 반복 호출하지 않는다.
- Heuristic code를 분석할 수 있다.
- Search가 plan의 validity를 유지한다.
- 2B 이하 SLM과 대형 LLM을 동일 조건에서 비교할 수 있다.

그러나 기존 연구는 propositional planning만 다룬다. Numeric extension에서는 ENHSP와 결합하고 기존 numeric heuristic을 반드시 대조군으로 둬야 한다.

---

## 9. 좁힌 연구 질문

### 9.1 선행 질문

> 기존 numeric heuristic은 capacity, battery, distance 같은 constraint를 어떤 relaxation으로 처리하며, 그 과정에서 어떤 정보를 잃는가?

이 질문에 먼저 답하지 못하면 LLM의 역할도 정의할 수 없다.

### 9.2 1차 연구 질문

> **고정된 capacitated numeric PDDL domain에서, 2B 이하 SLM이 domain과 소수의 training instance로부터 생성한 domain-dependent heuristic code가 기존 numeric heuristic이 놓치는 package grouping interaction을 보완하여 unseen 대형 instance의 coverage와 search efficiency를 향상시키는가?**

### 9.3 첫 실험에서 제한할 것

- Numeric constraint는 carrier capacity와 package weight만 사용
- 이동 action은 우선 unit cost
- Domain은 하나의 Capacitated Transport로 제한
- LLM은 domain당 offline으로 한 번 후보군 생성
- LLM 출력은 state score만 제공
- Hard pruning과 hard subgoal decomposition은 사용하지 않음
- Ordering은 planner search가 결정
- Satisficing planning을 목표로 함

Battery, road distance, deadline과 여러 resource의 동시 처리는 1차 결과가 확인된 뒤 확장한다.

---

## 10. Baseline 구성

| 역할 | Baseline |
|---|---|
| No guidance | Blind GBFS |
| Classical numeric | ENHSP numeric h_add/subgoaling heuristic |
| Human domain knowledge | Handcrafted capacity/packing-aware heuristic |
| LLM methodology | Corrêa et al.의 offline heuristic-code generation |
| Small model | 2B 이하 SLM-generated heuristic |
| Model-scale comparison | 7B/8B 및 frontier LLM-generated heuristic |
| Optional learned baseline | GNN numeric heuristic |

Handcrafted heuristic이 중요하다. LLM이 단순한 `ceil(total_weight/capacity)`를 생성한 것이라면 LLM의 고유한 이점이라고 보기 어렵기 때문이다.

---

## 11. 평가와 검증

### 11.1 Planning 성능

- 제한시간 내 해결한 problem 수와 coverage
- Plan validity와 goal achievement
- Expanded/generated state 수
- Effective branching factor
- Planning wall-clock time
- Heuristic evaluation overhead
- Peak memory
- Plan length와 execution cost
- Domain당 LLM 호출 수, token 수와 생성시간
- Unseen problem size generalization

### 11.2 Numeric awareness 검증

성능 향상만으로는 LLM이 numeric constraint를 이해했다고 주장할 수 없다. 다음 counterfactual ablation이 필요하다.

- Symbolic structure를 고정하고 package weight만 변경
- Carrier capacity만 변경
- Numeric fluent 이름을 의미 없는 token으로 치환
- Weight 값을 서로 permutation
- 생성 코드에서 numeric term만 제거
- 동일 총무게이지만 packing 난도가 다른 instance 비교

### 11.3 검증하려는 핵심

```text
LLM이 단순히 domain 이름을 암기했는가?
        vs.
실제 numeric value와 object interaction을 이용했는가?
```

---

## 12. 우선 학습할 문헌과 개념

1. Metric-FF와 numeric relaxed planning graph
2. ENHSP의 numeric subgoaling relaxation
3. Multi-repetition relaxed plan과 helpful action
4. LP/IP-based numeric heuristic
5. Numeric landmark
6. Numeric LM-cut/operator counting/PDB
7. 그 다음 LLM-generated heuristic과의 결합

현재 가장 중요한 논문은 다음과 같다.

- [Scala et al., Search-Guidance Mechanisms for Numeric Planning Through Subgoaling Relaxation, ICAPS 2020](https://ojs.aaai.org/index.php/ICAPS/article/view/6665)
- [Piacentini et al., Linear and Integer Programming-Based Heuristics for Cost-Optimal Numeric Planning, AAAI 2018](https://ojs.aaai.org/index.php/AAAI/article/download/12082/11941)
- [Piacentini et al., Compiling Optimal Numeric Planning to Mixed Integer Linear Programming, ICAPS 2018](https://ojs.aaai.org/index.php/ICAPS/article/view/13919)
- [Kuroiwa et al., LM-Cut Heuristics for Optimal Linear Numeric Planning, ICAPS 2022](https://ojs.aaai.org/index.php/ICAPS/article/download/19803/19562/23816)
- [Gnad et al., PDBs Go Numeric, AAAI 2025](https://ojs.aaai.org/index.php/AAAI/article/view/34851)
- [Borelli et al., Learning Heuristic Functions with Graph Neural Networks for Numeric Planning, AAAI 2026](https://ojs.aaai.org/index.php/AAAI/article/view/40935)
- [Corrêa et al., Classical Planning with LLM-Generated Heuristics, NeurIPS 2025](https://proceedings.neurips.cc/paper_files/paper/2025/hash/3bf4b55960aaa23553cd2a6bdc6e1b57-Abstract-Conference.html)
- [ENHSP official repository](https://github.com/hstairs/enhsp)

---

## 13. 현재 결론

Numeric planning에는 이미 numeric-aware heuristic이 존재하며, LP/MILP는 그중 한 접근일 뿐이다. 일반적인 numeric planner는 numeric precondition을 직접 검사하면서 Metric-FF, subgoaling relaxation, landmark, LP/IP 또는 기타 abstraction으로 탐색을 안내한다.

따라서 LLM의 연구 가치는 “숫자를 처음 도입한다”는 데 있지 않다. 보다 설득력 있는 가치는 다음에 있다.

> **기존 numeric relaxation이 놓치는 domain-specific하고 combinatorial한 resource interaction을 작은 언어모델이 domain-dependent soft heuristic으로 보완할 수 있는지 검증한다.**

첫 대상은 12kg carrier와 package weight로 구성된 capacitated transport가 적절하다. 이 문제에서 classical numeric heuristic, handcrafted packing-aware heuristic, 2B 이하 SLM-generated heuristic과 대형 LLM-generated heuristic을 동일한 numeric search 위에서 비교한다.
