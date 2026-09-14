# Numeric-Aware SLM Subgoal Planning 연구 기획 보고서

- 문서 상태: 1차 토론 종합 보고서
- 작성일: 2026-09-06
- 연구 범위: 주어진 PDDL domain/problem에서 2B 이하 언어모델을 활용한 로봇 task planning

## 요약

본 연구는 자연어를 PDDL로 변환하는 문제보다, **이미 주어진 symbolic/numeric planning problem을 제한된 계산 자원 안에서 빠르게 푸는 문제**에 초점을 둔다. 특히 2B 이하 소형 언어모델(SLM)이 numeric resource를 고려한 subgoal과 partial ordering을 제안하고, classical planner 또는 numeric solver가 제안의 실행 가능성을 검증한 뒤 search guidance로 활용하는 구조를 검토한다.

연구의 핵심 가설은 다음과 같다.

> 대규모 planning problem을 전역적으로 한 번에 탐색하는 것보다, 작은 언어모델이 자원 제약을 고려해 상호 연관된 object와 action을 subgoal 단위로 묶고 classical planner가 각 묶음의 전역 실행 가능성을 검증하면, plan solvability를 훼손하지 않으면서 탐색 비용을 줄일 수 있다.

이를 검증할 대표 사례로 운반 용량이 12kg인 캐리어와 무게가 서로 다른 10개 소포의 수거·운반 문제를 고려한다. SLM이 각 운반 묶음의 총무게가 12kg 이하가 되도록 소포를 묶어 subgoal을 생성하면, 전체 소포와 모든 운반 조합을 동시에 탐색하는 방식보다 탐색 공간이 줄어들 수 있다는 경험적 관찰이다.

다만 소포의 무게만 고려한 묶음은 bin packing 또는 capacity-constrained batching에 가깝고, 소포 위치와 방문 순서까지 고려하면 capacitated routing 또는 pickup-and-delivery planning이 된다. 따라서 LLM이 단순한 숫자 합산을 대신하는 것이 아니라, **위치·선후관계·상태·자원의 결합 구조를 유용한 subproblem으로 추상화하는 역할**을 해야 연구적 가치가 생긴다.

---

## 1. 연구 배경

LLM은 상식과 의미 지식을 이용해 로봇 작업에 대해 그럴듯한 plan 또는 subgoal을 생성할 수 있다. 그러나 다음 문제가 남아 있다.

1. 많은 연구가 큰 LLM에 의존하며 2B 이하 모델의 planning 및 search guidance 성능은 충분히 분석되지 않았다.
2. LLM의 직접 plan generation은 긴 horizon과 복잡한 constraint에서 action precondition과 goal satisfaction을 안정적으로 보장하기 어렵다.
3. 반복적인 LLM 호출, self-correction, tree search 및 외부 validation은 계산 비용과 latency가 누적된다.
4. Validator는 잘못된 plan을 검출할 수 있지만, 제한된 시간과 메모리 안에 해답을 찾는다는 것을 보장하지 않는다.
5. 대형 환경에서는 heuristic value의 미세한 정확도보다 object/action relevance, subgoal decomposition 및 branching-factor control이 더 중요할 수 있다.

본 연구에서 우선하는 목표는 cost-optimal plan이 아니다. 로봇 task planning에서 plan cost의 의미가 명확하지 않은 상태에서 admissibility만 강조하면 실제 문제와 멀어질 수 있다. 따라서 중심 평가 기준을 다음으로 전환한다.

- 모든 action이 실행 시점의 precondition을 만족하는가?
- 최종 상태가 goal condition을 만족하는가?
- LLM guidance가 틀려도 planner가 다른 경로를 탐색할 수 있는가?
- 환경 규모가 커져도 제한 시간과 메모리 안에 plan을 찾는가?

---

## 2. 핵심 용어

### 2.1 Soundness

생성된 plan을 초기 상태에서 순서대로 실행했을 때 모든 action의 precondition이 만족되고, 각 effect를 적용한 최종 상태가 goal을 만족하는 성질이다.

### 2.2 Completeness preservation

원래 planning problem에 해답이 있을 때, LLM의 잘못된 guidance 때문에 모든 해답 경로가 제거되지 않는 성질이다. Hard action pruning은 completeness를 잃을 수 있지만, preferred operator와 fallback queue는 모든 action을 최종적으로 유지함으로써 이를 보존할 수 있다.

### 2.3 Search guidance와 search-space control

- **Search guidance:** 어떤 state, action 또는 subgoal을 먼저 탐색할지 유도하는 포괄적 개념
- **Search-control knowledge:** 탐색 순서를 유도하는 domain-dependent 지식
- **Search-space reduction:** state/action을 실제 탐색 공간에서 제거
- **Action pruning:** 적용 가능한 action 일부를 제거
- **Preferred operator:** 일부 action을 우선 탐색하되 나머지도 유지
- **Subgoal decomposition:** 전체 문제를 중간 목표 단위로 나눔
- **Macro action:** 여러 primitive action을 하나의 고수준 선택지로 묶음
- **Relevance analysis:** goal과 무관한 object, fact 또는 action을 제거하거나 후순위화

본 연구의 상위 명칭으로는 **SLM-guided search control for numeric robot task planning**이 적절하다. Completeness를 보존하는 구현을 강조한다면 **fallback-complete search guidance** 또는 **completeness-preserving SLM guidance**라고 표현할 수 있다.

---

## 3. Classical planning은 언제 어려워지는가?

### 3.1 실제로 해답이 없는 경우

- Goal을 달성할 action이 없음
- 필수 resource가 부족함
- 필요한 object가 존재하지 않음
- 상충하는 goal condition
- Irreversible action으로 인해 모든 경로가 dead end가 됨

이때 planner가 plan을 찾지 못하는 것은 올바른 결과다.

### 3.2 해답은 있지만 계산 예산 안에 못 찾는 경우

- Object 수 증가에 따른 grounding 폭발
- 높은 branching factor
- 긴 plan horizon
- Heuristic plateau와 local minimum
- 많은 dead end
- Numeric condition 사이의 복잡한 상호작용
- 대칭적인 object와 state
- Goal과 무관한 object/action의 증가

본 연구는 이 두 번째 상황을 주 대상으로 한다.

> Solvable하고 올바르게 명세된 PDDL problem이 환경 규모와 horizon 증가로 인해 제한된 계산 예산 안에서 풀리지 않는 상황을 연구한다.

### 3.3 모델과 현실이 다른 경우

- 누락되거나 잘못된 precondition/effect
- Perception 및 state estimation 오류
- Grasp, collision, reachability 등 geometric feasibility 누락
- 동적 환경 변화

이는 pure search problem이 아니라 model adequacy, TAMP 및 execution monitoring 문제다. 초기 연구에서는 정확한 symbolic/numeric state가 주어진다는 조건을 두고, continuous motion feasibility는 별도 oracle 또는 low-level planner에 위임하는 것이 적절하다.

---

## 4. 로봇 planning의 numeric constraint

로봇 환경의 상태는 세 층으로 나눌 수 있다.

### 4.1 Symbolic task state

```text
in(package_1, room_a)
empty(carrier)
at(robot, depot)
```

### 4.2 Numeric task state

```text
weight(package_1) = 5 kg
carrier_load = 0 kg
carrier_capacity = 12 kg
battery = 40
distance(robot, package_1) = 8 m
deadline = 600 sec
```

### 4.3 Continuous geometric state

```text
robot configuration
object pose
collision and grasp constraints
continuous trajectory feasibility
```

초기 연구에서는 symbolic state와 bounded numeric resource를 포함하고, raw geometry는 제외하는 것이 범위상 적절하다.

고려 가능한 numeric 변수는 다음과 같다.

- 이동 거리와 누적 이동 비용
- 배터리 및 에너지 소비
- 캐리어·그리퍼의 최대 적재량
- 물체 무게와 용기 부피
- 가열 시간과 온도
- 물과 전력 같은 consumable resource
- Deadline 및 최대 task duration
- 동시에 운반 가능한 object 수

---

## 5. 경험적 사례: 12kg 캐리어와 10개 소포

### 5.1 문제 설정

- 수거할 소포: 10개
- 각 소포의 무게: 서로 다름
- 캐리어 최대 적재량: 12kg
- 로봇은 소포 위치를 방문해 캐리어에 넣고 운반해야 함
- 한 번의 운반 batch에 포함된 소포 무게 합은 12kg 이하여야 함

예시 무게를 다음처럼 둘 수 있다.

```text
P1=7, P2=5, P3=6, P4=6, P5=4,
P6=4, P7=3, P8=3, P9=2, P10=2 kg
```

SLM은 다음과 같은 candidate subgoal을 제안할 수 있다.

```text
G1: collect {P1, P2}       total = 12 kg
G2: collect {P3, P4}       total = 12 kg
G3: collect {P5, P6, P7}   total = 11 kg
G4: collect {P8, P9, P10}  total = 7 kg
```

각 `Gi`는 단순 자연어 목표가 아니라 다음 resource contract를 가진다.

```yaml
subgoal: G1
objects: [P1, P2]
numeric_preconditions:
  carrier_load: 0
numeric_invariants:
  total_weight: <= 12
numeric_effects:
  carrier_load_after_pickup: 12
completion_condition:
  delivered: [P1, P2]
```

### 5.2 기대 효과

전역 planner는 다음을 동시에 고려해야 한다.

- 어떤 소포를 같은 trip으로 묶을지
- 각 소포를 어떤 순서로 방문할지
- 언제 depot 또는 destination으로 돌아갈지
- 현재 load가 capacity를 넘지 않는지
- 거리, 시간 및 에너지 제약을 만족하는지

SLM이 유망한 batch를 먼저 제안하면 classical planner는 전체 조합 대신 각 batch 안의 방문 순서와 실행 가능성을 우선 탐색할 수 있다. 좋은 decomposition은 다음 두 요소를 동시에 줄일 수 있다.

- Branching factor: 현재 subgoal과 무관한 소포 pickup action을 후순위화
- Effective horizon: 전체 10개 소포 문제를 더 짧은 batch problem으로 분할

### 5.3 문제 유형의 구분

소포의 위치와 경로를 무시하고 무게 합만 고려하면 다음 문제에 가깝다.

- Bin packing
- Capacity-constrained batching
- Knapsack-style partitioning

소포 위치, 방문 순서, depot 복귀를 함께 고려하면 다음 문제에 가깝다.

- Capacitated vehicle routing
- Capacitated pickup-and-delivery
- Resource-constrained task planning

따라서 단순히 합이 12kg에 가까운 조합을 찾는 것만으로는 좋은 decomposition이라 할 수 없다.

예를 들어 다음 두 batch가 모두 12kg이라고 하자.

```text
Batch A: 서로 인접한 위치의 {7kg, 5kg}
Batch B: 건물 반대편에 있는 {6kg, 6kg}
```

무게만 보면 둘 다 동일하지만 이동 비용과 배터리까지 고려하면 계획 품질이 달라진다. 더 나쁜 경우, 12kg을 정확히 채우기 위해 멀리 떨어진 소포를 묶는 것이 10kg짜리 지역적 batch보다 전체 execution cost를 증가시킬 수 있다.

따라서 연구 가설은 “항상 12kg을 정확히 채운다”가 아니라 다음이어야 한다.

> Capacity utilization, spatial locality, precedence, deadline 및 downstream feasibility를 함께 고려한 resource-aware subgoal decomposition이 전역 탐색을 가속할 수 있다.

---

## 6. Numeric-aware subgoal 정의

Numeric-aware subgoal은 다음 튜플로 표현할 수 있다.

```text
g_i = <G_i_prop, G_i_num, R_i_required,
       R_i_produced, R_i_consumed, I_i>
```

- `G_i_prop`: symbolic completion condition
- `G_i_num`: numeric goal 또는 threshold
- `R_i_required`: subgoal 시작에 필요한 자원
- `R_i_produced`: subgoal이 생성하거나 회복하는 자원
- `R_i_consumed`: subgoal 수행 중 소비되는 자원
- `I_i`: 수행 중 유지해야 하는 numeric invariant

소포 사례에서는 다음을 포함한다.

```text
G_i_prop      = selected packages delivered
G_i_num       = total selected weight <= 12
R_i_required  = battery and empty capacity
R_i_consumed  = travel energy and elapsed time
I_i           = carrier_load <= 12 at every step
```

---

## 7. 각 subgoal의 독립적 실행 가능성은 충분하지 않다

각 subgoal이 별도로 풀린다는 사실만으로 전체 decomposition이 실행 가능하다고 결론 내릴 수 없다.

예를 들어 초기 배터리가 20이고 두 subgoal이 각각 12와 10의 배터리를 소비한다면 각 subgoal은 독립적으로 가능하지만 전체 순차 실행은 불가능하다.

```text
20 >= 12
20 >= 10

그러나

12 + 10 > 20
```

따라서 numeric state를 subproblem 경계에서 이어서 전달해야 한다.

```text
(s_i, x_i) --plan_i--> (s_{i+1}, x_{i+1})
```

- `s_i`: symbolic state
- `x_i`: battery, time, load, temperature 등의 numeric state

검증기는 다음을 확인해야 한다.

1. 각 subgoal의 symbolic satisfiability
2. Numeric interval feasibility
3. 누적 resource feasibility
4. Subgoal 사이의 interference
5. 제안 순서 전체에서 final goal reachability

---

## 8. Subgoal 순서와 partial order

LLM이 모든 subgoal의 total order를 확정하면 불필요하거나 잘못된 순서를 강제할 수 있다. 권장 방식은 partial-order subgoal graph다.

```text
charge_robot ───────┐
                    ├──> delivery_batch_2
delivery_batch_1 ───┘
```

순서 관계는 다음에서 발생한다.

- Symbolic causal dependency
- Numeric resource production/consumption
- Mutex 또는 interference
- Deadline
- 온도 감소와 같은 시간 의존 상태
- Carrier 또는 gripper capacity

권장 처리 과정은 다음과 같다.

1. SLM이 candidate subgoal과 예상 dependency를 제안한다.
2. Planner가 causal relation, mutex 및 numeric resource constraint를 검사한다.
3. 반드시 필요한 관계만 hard partial order로 유지한다.
4. 검증되지 않은 순서는 soft preference로 사용한다.
5. 독립적인 subgoal의 순서는 planner가 탐색하도록 남겨둔다.

---

## 9. 숨은 subgoal 발견

숨은 subgoal은 최종 goal에 직접 나타나지 않지만 action precondition을 만족하기 위해 필요한 중간 조건이다.

예시:

```text
Goal: all packages delivered

Hidden conditions:
- carrier has sufficient remaining capacity
- battery is sufficient for the selected route
- carrier is unloaded before starting the next batch
- a blocked passage is opened before visiting a package
```

Classical planning에서는 regression과 landmark extraction으로 이러한 necessary condition의 일부를 찾을 수 있다. Numeric planning에도 regression-based numeric subgoaling relaxation이 이미 존재한다.

따라서 SLM의 차별적 역할을 “숨은 조건을 처음 발견한다”로만 주장하기는 어렵다. 더 타당한 역할은 다음과 같다.

- Regression이 만든 많은 necessary condition을 의미 있는 subgoal로 묶음
- Numeric condition과 symbolic condition의 결합 후보 생성
- Disjunctive strategy 제안: 충전 또는 가까운 소포부터 운반
- 반복 action을 semantic macro 또는 batch로 추상화
- 제한된 subgoal budget 안에서 유용한 후보의 우선순위를 결정

---

## 10. 제안 시스템

### 10.1 전체 구조

```text
Given symbolic/numeric PDDL domain and problem
                    ↓
Classical numeric dependency analysis
                    ↓
2B 이하 SLM 1회 호출
                    ↓
Candidate resource-aware subgoals
+ partial ordering
+ relevant objects/actions
                    ↓
Symbolic/numeric certification
├── certified necessary condition
├── valid soft waypoint
├── reachable but harmful candidate
└── infeasible candidate
                    ↓
Fallback-complete preferred search
                    ↓
Valid goal-reaching plan
```

### 10.2 Classical analyzer

LLM 호출 전에 다음 정보를 구조화한다.

- Numeric fluent 목록
- Action별 numeric precondition/effect
- Resource producer와 consumer
- 반복 가능한 action
- Goal-related threshold
- Symbolic/numeric dependency graph
- Object 위치와 action grounding 후보

### 10.3 SLM 출력

SLM은 자유서술 plan이 아니라 제한된 JSON 구조를 출력한다.

```json
{
  "subgoals": [
    {
      "id": "batch_1",
      "objects": ["package_1", "package_2"],
      "propositional_conditions": [
        "delivered(package_1)",
        "delivered(package_2)"
      ],
      "numeric_constraints": [
        "weight(package_1) + weight(package_2) <= 12"
      ]
    }
  ],
  "orderings": [],
  "relevant_actions": ["pickup", "move", "unload"],
  "relevant_objects": ["package_1", "package_2", "carrier"]
}
```

### 10.4 Symbolic/numeric certification

후보를 다음처럼 분류한다.

| 분류 | 의미 | Search에서의 사용 |
|---|---|---|
| Certified necessary | 모든 유효 계획에 필요하거나 안전하게 강제 가능 | Hard guidance 후보 |
| Valid and helpful | 전체 goal로 확장 가능한 waypoint | Preferred queue |
| Reachable but harmful | 도달 가능하지만 이후 비용 증가 또는 dead end 위험 | 후순위 또는 제거 |
| Unverified | 제한 시간 내 검증하지 못함 | Tie-breaking만 사용 |
| Infeasible | Symbolic/numeric constraint 위반 | 사용하지 않음 |

### 10.5 Fallback-complete search

```text
Queue 1: 현재 검증된 subgoal을 향하는 state/action
Queue 2: 다른 valid subgoal을 향하는 state/action
Queue 3: 기존 planner heuristic이 추천한 state/action
Queue 4: 나머지 전체 applicable action
```

마지막 queue를 유지하면 SLM guidance가 틀렸을 때 원래 탐색으로 복구할 수 있다. 실제 completeness는 사용하는 search algorithm, queue scheduling 및 duplicate handling에 맞춰 별도로 증명해야 한다.

---

## 11. LLM이 필요한 이유와 반론

### 반론 1. 소포 grouping은 solver가 더 잘하지 않는가?

맞는 반론이다. 무게 합만 계산하는 문제라면 bin-packing solver, integer programming 또는 dynamic programming이 LLM보다 정확하고 빠르다.

따라서 연구에서 LLM의 역할은 다음이어야 한다.

- 어떤 object와 constraint를 하나의 semantic task unit으로 묶을지 제안
- 위치·작업 의미·선후관계·수치 자원을 함께 고려한 abstraction
- 다양한 domain에서 solver-specific decomposition rule을 사람이 직접 설계하는 비용 감소
- 많은 후보 중 planner가 검증할 소수 후보의 우선순위화

### 반론 2. PDDL 구조만으로 decomposition이 가능하지 않은가?

Causal graph, landmark, relaxation 및 relevance analysis만으로도 상당한 guidance를 생성할 수 있다. 따라서 반드시 다음과 비교해야 한다.

- Numeric regression
- Landmark extraction
- Relaxed-plan subgoal
- Causal-graph decomposition
- Random grouping
- Greedy capacity packing
- Integer-programming optimal batching
- Distance-aware clustering

SLM이 이 기준선보다 낫지 않으면 언어모델을 사용할 이유가 없다.

### 반론 3. Predicate 이름을 읽고 상식적으로 묶은 것뿐 아닌가?

Predicate와 object 이름을 익명화하는 ablation이 필요하다.

```text
pickup(package) → a17(x)
carrier_capacity → n03
```

- 익명화 후 실패: 자연어 semantic prior가 기여
- 익명화 후에도 성공: relational structure reasoning이 기여

두 결과 모두 의미가 있지만 연구 주장을 다르게 해야 한다.

---

## 12. 연구 질문

### RQ1. Solvability와 탐색 효율

2B 이하 SLM의 numeric-aware subgoal decomposition이 기존 planner보다 더 많은 대형 problem을 제한 시간 안에 해결하는가?

### RQ2. 전역 numeric feasibility

각 subgoal의 local feasibility가 아니라 전체 subgoal graph의 누적 resource feasibility를 symbolic/numeric verifier가 검증할 수 있는가?

### RQ3. Search control 방식

Hard decomposition, preferred operators, multi-queue fallback 중 어떤 방식이 속도와 robustness 사이에서 가장 좋은가?

### RQ4. Subgoal 품질

어떤 candidate가 necessary subgoal, useful waypoint, harmful waypoint 또는 infeasible subgoal인지 자동 분류할 수 있는가?

### RQ5. 기존 방법 대비 LLM의 기여

SLM이 greedy packing, IP batching, causal graph, landmarks 및 numeric relaxation보다 유용한 decomposition을 제안하는가?

### RQ6. 일반화

작은 problem에서 학습하거나 설계한 SLM guidance가 더 많은 object, 긴 horizon 및 새로운 numeric distribution에 일반화되는가?

### RQ7. 모델 크기

0.5B, 1B, 1.5B, 2B 모델 사이에서 subgoal validity, search reduction 및 generalization이 어떻게 변하는가?

---

## 13. 실험 설계

### 13.1 독립변수

- Object 또는 package 수
- Numeric resource 종류 수
- Carrier capacity
- Package weight distribution
- 위치의 공간적 분산
- Plan horizon
- Deadline tightness
- Resource replenishment action의 존재 여부
- SLM 크기
- Subgoal budget

### 13.2 비교 방법

1. Global classical/numeric planner
2. Classical planner + standard heuristic
3. Numeric subgoaling relaxation
4. Greedy capacity-first decomposition
5. Distance-first clustering
6. Integer-programming batch optimization
7. Random subgoal decomposition
8. Large LLM decomposition
9. Sub-2B SLM decomposition without verifier
10. Sub-2B SLM + local verifier
11. 제안 방식: sub-2B SLM + global numeric certification + fallback search

### 13.3 평가 지표

- Problem coverage: 제한 시간 내 해결한 문제 비율
- Valid plan rate
- Goal achievement rate
- Node expansions 및 generated states
- Grounded action 수
- Peak memory
- Planning wall-clock time
- Plan length 및 execution cost
- LLM 호출 횟수와 token 수
- Subgoal validation time
- Invalid/harmful subgoal 비율
- Fallback 발생률
- Capacity utilization
- Travel distance 및 energy consumption

### 13.4 핵심 ablation

- Numeric constraint 제거
- Spatial information 제거
- Partial order 제거 후 total order 강제
- Global certification 없이 local check만 수행
- Fallback queue 제거
- Predicate/object 이름 익명화
- LLM 대신 random 또는 greedy grouping 사용
- SLM 크기별 비교

### 13.5 중요한 분석

단순 planning time만 비교하면 SLM 호출과 검증 비용이 누락될 수 있다. 다음 두 값을 모두 보고해야 한다.

```text
online planning time
end-to-end time = SLM inference + verification + planning
```

Domain-level decomposition knowledge를 여러 problem에서 재사용하는 경우 amortized cost도 별도로 보고한다.

---

## 14. RoboCasa 적용 시 확인할 사항

현재 RoboCasa task annotation은 symbolic subtask sequence 분석에는 적합하지만, 다음 numeric ground truth가 충분히 포함되는지 확인해야 한다.

- 물체별 실제 무게
- Gripper 또는 carrier payload
- 이동 거리와 에너지 모델
- 조리 시간과 온도 dynamics
- 용기 capacity와 내용물 양
- Deadline

이 값이 benchmark에 없는데 임의로 추가하면 연구 결과가 synthetic numeric extension에 한정될 수 있다. 따라서 다음의 이중 평가가 권장된다.

1. IPC numeric planning benchmark에서 방법의 일반적 효과 검증
2. RoboCasa-derived task planning에서 로봇 관련성 검증

RoboCasa 확장에서는 실제 task에 자연스러운 distance, duration, count 및 capacity부터 도입해야 한다.

---

## 15. 가장 가까운 관련 연구와 차별점

### Classical numeric subgoaling

`Search-Guidance Mechanisms for Numeric Planning Through Subgoaling Relaxation`은 regression-based necessary numeric condition을 이용해 heuristic, helpful action 및 반복 action 압축을 구성한다. 본 연구는 이를 반드시 기준선이자 symbolic verifier 기반으로 고려해야 한다.

### LLM multi-level decomposition

`Fast and Accurate Task Planning using Neuro-Symbolic Language Models and Multi-level Goal Decomposition`은 LLM이 subgoal을 만들고 symbolic 또는 LLM-MCTS planner가 하위 문제를 해결한다. 본 연구는 2B 이하 모델, numeric resource contract, global certification 및 fallback-complete search를 차별점으로 검토한다.

### Continuous constraint satisfaction

`Trust the PRoC3S`는 LLM이 연속 파라미터를 가진 skill-sequence 프로그램을 제안하고 CCSP solver가 기구학·충돌·물리 constraint를 해결한다. 본 연구는 continuous skill parameter보다 fixed numeric PDDL에서의 decomposition과 search control에 초점을 둔다.

### Multi-robot assignment and numeric optimization

`PIP-LLM`은 team-level subtask dependency graph와 robot-level integer programming을 결합해 travel cost와 workload를 최적화한다. 본 연구와 가까우므로 single-robot/resource-constrained setting 및 small-model search-control 차이를 명확히 해야 한다.

예비 조사 단계에서 보이는 연구 공백 후보는 다음과 같다.

> Fixed numeric PDDL input + sub-2B SLM subgoal proposal + global numeric certification + completeness-preserving fallback search

이는 추가적인 체계적 문헌조사를 거쳐 확정해야 한다.

---

## 16. 제안 논문 포지셔닝

### 제목 후보 1

**Resource-Aware Subgoal Decomposition with Small Language Models for Scalable Numeric Robot Planning**

### 제목 후보 2

**Safe Search Control for Numeric Task Planning via Verified Subgoals from Small Language Models**

### 제목 후보 3

**Think in Batches: Small Language Models for Resource-Constrained Subgoal Guidance in Robot Planning**

### 핵심 연구 문장

> Can a sub-2B language model construct resource-aware subgoal abstractions that reduce search effort in numeric planning, while a symbolic verifier guarantees global numeric feasibility and a fallback search preserves completeness?

### 한국어 표현

> 2B 이하 소형 언어모델이 수치 자원을 고려한 subgoal abstraction을 생성하고, symbolic numeric verifier가 전역 실행 가능성을 검증하며, fallback search가 완전성을 보존할 때 대규모 로봇 task planning의 탐색 비용을 줄일 수 있는가?

---

## 17. 예상 기여

1. 주어진 numeric PDDL problem에서 작동하는 2B 이하 SLM 기반 subgoal generator
2. Symbolic·numeric condition과 resource contract를 포함하는 subgoal representation
3. Local feasibility가 아닌 전체 decomposition의 누적 자원 실행 가능성 검증
4. 잘못된 SLM guidance에서 복구 가능한 fallback-complete search architecture
5. Package batching과 RoboCasa-derived task를 통한 대규모 환경 확장성 분석
6. SLM이 기존 numeric regression, solver-based decomposition 및 heuristic보다 언제 유용한지에 대한 경계 분석

---

## 18. 현재 판단과 다음 결정사항

이 연구에서 가장 설득력 있는 부분은 “LLM이 subgoal을 만든다”가 아니다. 다음 세 요소가 동시에 필요하다.

1. **Resource-aware abstraction:** 무게·거리·배터리·시간과 symbolic goal을 함께 묶는다.
2. **Global certification:** 개별 subgoal이 아니라 전체 sequence 또는 partial-order graph의 실행 가능성을 검증한다.
3. **Safe search integration:** 검증된 subgoal을 preferred guidance로 사용하되 실패 시 원래 search로 복구한다.

다음 토론에서 우선 결정할 사항은 다음과 같다.

1. 첫 benchmark를 소포 운반 문제로 자체 구성할 것인가, 기존 numeric IPC domain을 먼저 사용할 것인가?
2. 소포 문제에 위치와 routing cost까지 포함할 것인가, 초기에는 capacity grouping만 볼 것인가?
3. SLM 출력은 subgoal batch만 포함할 것인가, partial order와 relevant action까지 포함할 것인가?
4. Global certification에 기존 numeric planner, LP/IP solver 또는 별도 constraint solver 중 무엇을 사용할 것인가?
5. Completeness를 보존하는 multi-queue search를 직접 구현할 것인가, 기존 planner의 preferred operator interface를 활용할 것인가?

---

## 참고 문헌

- Fast and Accurate Task Planning using Neuro-Symbolic Language Models and Multi-level Goal Decomposition: https://arxiv.org/abs/2409.19250
- Search-Guidance Mechanisms for Numeric Planning Through Subgoaling Relaxation: https://doi.org/10.1609/icaps.v30i1.6665
- Trust the PRoC3S: https://proceedings.mlr.press/v270/curtis25a.html
- PIP-LLM: https://arxiv.org/abs/2510.22784
- Fast Downward Planning System: https://www.jair.org/index.php/jair/article/view/10457
- SayPlan: https://proceedings.mlr.press/v229/rana23a.html
- Dealing with Numeric and Metric Time Constraints in PDDL3 via Compilation to Numeric Planning: https://doi.org/10.1609/aaai.v38i18.29981
