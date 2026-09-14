# Numeric-Aware LLM Search Guidance 연구 방향 비교 보고서

- 문서 상태: 연구 주제 선정을 위한 1차 의사결정 보고서
- 작성일: 2026-09-06
- 연구 범위: 이미 주어진 symbolic/numeric PDDL domain과 problem을 해결하는 과정에서의 LLM 역할

## 1. 연구 문제

본 연구는 LLM이 자연어로부터 PDDL domain이나 problem을 생성하는 문제를 다루지 않는다. Domain, action, precondition, effect, initial state 및 goal이 이미 PDDL로 주어졌다고 가정한다.

관심 문제는 다음과 같다.

> 주어진 numeric planning problem을 해결할 때 2B 이하의 소형 언어모델(SLM)이 numeric constraint를 이해하고 search guidance 또는 search-space control에 기여할 수 있는가?

로봇 task planning에서 우선하는 목표는 cost-optimal plan이나 admissible heuristic 자체가 아니다. 우선순위는 다음과 같다.

1. 모든 action이 실행 시점의 precondition을 만족하는 valid plan 생성
2. 최종 goal condition 달성
3. 제한된 시간과 메모리 안에서의 problem coverage 향상
4. 대형 환경에서 node expansion과 branching factor 감소
5. 작은 모델의 성능 및 큰 모델과의 차이 분석

이 연구에서는 여러 search-control mechanism 중 최적의 mechanism을 자동 선택하는 문제를 다루지 않는다. 다음 세 후보 가운데 하나를 고정해 실제 가능성과 효과를 검증한다.

1. Numeric-aware LLM heuristic mapper
2. Numeric-aware subgoal decomposer
3. Numeric-aware preferred-action guidance

---

## 2. 공통 가정과 평가 원칙

### 2.1 입력

- PDDL domain
- PDDL problem
- Symbolic initial state와 goal
- Numeric fluent와 초기값
- Action별 symbolic/numeric precondition과 effect
- 선택적으로 object 위치, 거리, 실행 시간 및 resource 정보

### 2.2 Numeric constraint 예시

- Carrier 또는 gripper capacity
- Object weight
- Battery와 energy consumption
- 이동 거리
- Deadline과 elapsed time
- Temperature와 heating duration
- Container volume
- 동시에 조작 가능한 object 수

### 2.3 비교할 모델 규모

- Sub-2B SLM: 예를 들어 0.5B, 1B, 1.5B, 2B
- 중간 규모 모델: 예를 들어 7B 또는 8B
- 일반적인 대형 또는 frontier-scale LLM
- LLM을 사용하지 않는 classical/optimization baseline

### 2.4 공통 평가 지표

- 제한 시간 내 해결한 problem 비율
- Valid plan rate
- Goal achievement rate
- Expanded/generated state 수
- Effective branching factor
- Planning wall-clock time
- Peak memory
- Plan length와 execution cost
- LLM inference time, 호출 횟수 및 token 수
- Numeric constraint violation rate
- Unseen problem size에 대한 generalization

---

## 3. 후보 1: Numeric-Aware LLM Heuristic Mapper

### 3.1 핵심 아이디어

SLM이 numeric planning state의 중요 feature 또는 기존 heuristic의 조합 parameter를 제안하고, search 진행 과정에서 관측된 결과를 이용해 parameter를 adaptive하게 갱신한다.

```text
Numeric PDDL
    ↓
SLM이 heuristic feature/parameter 초기값 제안
    ↓
Heuristic search
    ↓
Plateau, dead end, expansion 결과 관찰
    ↓
Parameter adaptive update
```

예를 들어 다음과 같이 여러 heuristic signal을 결합할 수 있다.

```text
h(s) = w_goal · h_goal(s)
     + w_capacity · h_capacity(s)
     + w_distance · h_distance(s)
     + w_resource · h_resource(s)
```

SLM은 다음 중 하나를 제안할 수 있다.

- Potential heuristic에 사용할 symbolic/numeric feature
- Feature별 초기 weight
- 여러 기존 heuristic의 조합 weight
- Numeric fluent의 중요도
- 특정 search phase에서 강조할 heuristic

### 3.2 장점

- Numeric information을 search ordering에 직접 반영할 수 있다.
- State를 제거하지 않고 우선순위만 바꾸면 solution 경로를 유지할 수 있다.
- 어떤 numeric feature가 search에 기여했는지 weight로 분석할 수 있다.
- Potential heuristic, landmark heuristic, relaxed-plan heuristic 등과 결합 가능하다.

### 3.3 주요 문제

첫 논문에서 다음 두 효과가 섞일 위험이 있다.

1. LLM이 좋은 초기 feature/parameter를 제안한 효과
2. Search feedback을 이용한 adaptive update의 효과

성능이 향상돼도 원인이 어느 쪽인지 해석하기 어렵다. 또한 LLM이 직접 정확한 numeric weight를 예측해야 할 이유는 약하며, weight optimization은 LP나 학습 알고리즘이 더 잘할 수 있다.

Potential heuristic을 사용한다면 adaptive update 때마다 허용 가능한 weight constraint를 지켜야 한다. 반대로 satisficing planning만 목표라면 potential heuristic과 admissibility에 제한할 필요가 약해진다.

### 3.4 권장 범위 축소

이 방향을 선택한다면 첫 단계에서는 adaptive update를 제외한다.

```text
1차 연구:
SLM feature/parameter initialization → 고정 heuristic search

후속 연구:
Search feedback → online adaptation
```

### 3.5 필요한 비교군

- 기존 단일 heuristic
- Handcrafted heuristic combination
- Random weight
- LP 또는 Bayesian optimization으로 찾은 weight
- Learned neural heuristic
- SLM 초기화
- Large LLM 초기화
- SLM 초기화 + adaptive update

### 3.6 종합 판단

- 연구성: 높음
- 구현 난도: 매우 높음
- 작은 모델 비교의 명료성: 중간
- 주된 위험: LLM 초기화와 adaptive learning의 기여 분리가 어려움

---

## 4. 후보 2: Numeric-Aware Subgoal Decomposer

### 4.1 핵심 아이디어

SLM이 numeric resource와 symbolic dependency를 고려해 전체 problem을 subgoal로 분해한다. 이후 symbolic/numeric solver가 subgoal의 feasibility와 ordering을 결정하고, planner가 각 subproblem을 순차적으로 해결한다.

```text
Numeric PDDL problem
    ↓
SLM이 resource-aware candidate subgoal 생성
    ↓
Numeric solver가 feasibility와 ordering 검증
    ↓
Subproblem 1 → Subproblem 2 → ... → Final goal
```

### 4.2 12kg 캐리어 사례

- 무게가 서로 다른 소포 10개
- 캐리어 최대 적재량 12kg
- 로봇은 각 위치를 방문해 소포를 수거하고 운반

전역 planner는 다음을 동시에 결정해야 한다.

- 어떤 소포를 같은 trip에 넣을 것인가?
- 어떤 순서로 방문할 것인가?
- 언제 destination 또는 depot으로 돌아올 것인가?
- 현재 load가 12kg을 넘지 않는가?
- 거리, 배터리 및 시간 제약을 만족하는가?

SLM은 다음과 같은 candidate batch subgoal을 제안할 수 있다.

```text
G1: deliver {P1=7kg, P2=5kg}       total=12kg
G2: deliver {P3=6kg, P4=6kg}       total=12kg
G3: deliver {P5=4kg, P6=4kg, P7=3kg} total=11kg
```

각 subgoal은 다음 정보를 포함할 수 있다.

```text
G_i = <symbolic conditions,
       numeric conditions,
       required resources,
       consumed resources,
       produced resources,
       invariants>
```

예:

```yaml
id: batch_1
objects: [P1, P2]
goal:
  - delivered(P1)
  - delivered(P2)
numeric_constraints:
  - weight(P1) + weight(P2) <= 12
resource_requirements:
  - battery >= estimated_route_energy
invariants:
  - carrier_load <= 12
```

### 4.3 기대 효과

- 현재 subgoal과 무관한 object/action의 후순위화
- Branching factor 감소
- 전체 horizon을 더 짧은 subproblem으로 분할
- Numeric resource에 의해 생기는 자연스러운 task grouping 활용
- Domain semantics와 numeric information의 결합

### 4.4 12kg을 정확히 채우는 것이 항상 좋은가?

그렇지 않다. 무게만 고려하면 bin packing 또는 capacity-constrained batching 문제지만, 위치와 방문 순서를 포함하면 capacitated routing 또는 pickup-and-delivery problem이 된다.

12kg을 정확히 채우기 위해 멀리 떨어진 소포를 묶는 것보다, 총 10kg이어도 서로 가까운 소포를 묶는 편이 전체 거리와 에너지를 줄일 수 있다.

따라서 좋은 subgoal은 다음을 함께 고려해야 한다.

- Capacity utilization
- Spatial locality
- Travel distance
- Battery
- Deadline
- Symbolic precedence
- Downstream feasibility

### 4.5 Ordering은 LP인가?

Subgoal ordering과 batch assignment에는 이산 변수가 필요하다.

```text
x_ij = 1  if subgoal i precedes subgoal j
       0  otherwise
```

따라서 일반적으로 단순 LP보다 다음이 적합하다.

- Mixed-Integer Linear Programming, MILP
- Integer Programming, IP
- Constraint Programming 또는 CP-SAT
- SMT
- Temporal/numeric planner

고정된 ordering에서 연속 resource allocation만 계산한다면 LP로 풀 수 있다. 그러나 어떤 소포를 어떤 batch에 넣고 순서를 어떻게 정할지까지 결정한다면 MILP 또는 CP-SAT에 가깝다.

### 4.6 제안하는 책임 분리

#### SLM

- Candidate subgoal 개수와 구성 제안
- 의미적으로 관련된 object grouping
- Numeric resource contract 후보 생성
- 선택적인 ordering preference

#### MILP/CP-SAT 또는 numeric verifier

- Capacity와 resource constraint 검사
- Feasible candidate 선택
- Partial ordering 결정
- 전체 sequence의 누적 resource feasibility 검사

#### Classical planner

- 각 subgoal을 달성할 action sequence 생성
- Action precondition/effect 적용
- 최종 goal 검증

### 4.7 SLM은 한 개가 아니라 후보를 제안해야 함

하나의 decomposition을 강제로 사용하면 SLM 오류가 전체 planning failure로 이어질 수 있다. 권장 구조는 다음과 같다.

```text
SLM:
  candidate batch/subgoal 여러 개 생성

MILP/CP-SAT:
  feasible candidate 선택
  ordering 결정

Planner:
  선택된 subgoal별 plan 생성
```

따라서 SLM의 정확한 역할은 전체 해를 직접 결정하는 것이 아니라 **solver가 검토할 decomposition 후보 공간을 줄이는 것**이다.

### 4.8 Global feasibility 문제

각 subgoal을 독립적으로 풀 수 있어도 전체 sequence는 불가능할 수 있다.

예를 들어 초기 배터리가 20이고 두 subgoal이 각각 12와 10을 소비한다면:

```text
20 >= 12
20 >= 10

하지만

12 + 10 > 20
```

따라서 다음 상태를 subproblem 사이에 이어서 전달해야 한다.

```text
(symbolic state_i, numeric state_i)
    --plan_i-->
(symbolic state_i+1, numeric state_i+1)
```

필요한 검증은 다음과 같다.

1. Subgoal의 symbolic satisfiability
2. Numeric interval feasibility
3. 누적 resource feasibility
4. Subgoal 간 interference
5. 전체 ordering에서 final-goal reachability

### 4.9 Sequential planning의 위험

첫 subgoal을 달성하는 특정 plan이 이후 subgoal을 불가능하게 만들 수 있다. 이에 대한 대응 후보는 다음과 같다.

- Remaining-goal resource reservation
- Subgoal 경계 사이의 backtracking
- 전체 sequence feasibility pre-check
- 실패 시 다른 candidate decomposition 선택
- 실패 시 global planner fallback

### 4.10 필요한 비교군

- Global planning without decomposition
- Random decomposition
- Greedy capacity-first decomposition
- Distance-first clustering
- Classical landmark/causal decomposition
- Numeric subgoaling relaxation
- Optimization-only batching
- Sub-2B SLM decomposition
- 7B/8B model decomposition
- Frontier LLM decomposition
- Oracle 또는 expert decomposition

### 4.11 종합 판단

- 연구성: 세 후보 중 가장 높음
- 구현 난도: 높음
- 작은 모델 비교의 명료성: 가장 높음
- 주된 위험: 잘못된 decomposition이 전체 problem을 불가능하게 만들 수 있음

---

## 5. 후보 3: Numeric-Aware Preferred-Action Guidance

### 5.1 핵심 아이디어

현재 state와 numeric constraint를 보고 SLM이 applicable action의 우선순위를 제안한다. Planner는 추천 action을 먼저 확장하되 나머지 action도 fallback으로 유지한다.

```text
Current symbolic/numeric state
    ↓
Applicable action set
    ↓
SLM action ranking
    ↓
Preferred action부터 탐색
    ↓
실패 시 나머지 action 탐색
```

12kg 캐리어 사례:

```text
현재 load = 7kg
남은 capacity = 5kg

pickup(P2, weight=5)  → 높은 우선순위
pickup(P3, weight=6)  → numeric precondition 위반
pickup(P4, weight=3)  → 실행 가능하지만 낮은 우선순위
return_to_depot       → route 상태에 따라 평가
```

### 5.2 장점

- 구현이 가장 단순하다.
- 모든 applicable action을 유지하면 잘못된 추천에서 복구할 수 있다.
- 2B 모델과 큰 모델의 ranking quality를 직접 비교할 수 있다.
- Plan validity는 classical planner가 보장한다.
- Subgoal representation과 ordering solver가 필요하지 않다.

### 5.3 문제점

- Node expansion마다 LLM을 호출하면 inference 비용이 매우 커진다.
- Search space 자체를 줄이지 않으면 대형 문제에서 효과가 제한적일 수 있다.
- Learned preferred operator 및 action-ranking 연구와의 차별성이 약할 수 있다.
- Numeric infeasibility는 planner의 applicability 검사로 이미 제거되므로, 단순한 constraint filtering만으로는 LLM의 가치가 없다.

### 5.4 호출 비용 대응

- Search 전 action-priority rule을 한 번 생성
- State를 유형별로 묶어 batch inference
- Offline ranking dataset을 생성해 SLM을 fine-tuning
- Local sub-2B inference 사용
- 동일 relational state pattern의 결과 cache

### 5.5 필요한 비교군

- 기본 action ordering
- Random ordering
- Helpful action
- Preferred operator from relaxed plan
- Rule-based numeric ordering
- Learned ranking model
- Sub-2B SLM ranking
- Large LLM ranking

### 5.6 종합 판단

- 연구성: 중간
- 구현 난도: 가장 낮음
- 작은 모델 비교의 명료성: 높음
- 주된 위험: 신규성과 end-to-end 속도 향상 폭이 제한적일 수 있음

---

## 6. 세 방향 비교

| 기준 | Heuristic mapper | Subgoal decomposer | Preferred action |
|---|---|---|---|
| 주 출력 | Feature 또는 weight | Resource-aware subgoal | Action ranking |
| Search 영향 | State ordering | Horizon·조합 공간 분할 | Action expansion ordering |
| Numeric 정보 역할 | Heuristic score 구성 | Batch·resource contract·ordering | 현재 action의 유망성 평가 |
| Search 중 LLM 호출 | 구현에 따라 반복 가능 | 사전 또는 저빈도 | 반복 가능성이 높음 |
| Validity 보장 주체 | Planner | Planner + numeric verifier | Planner |
| 잘못된 LLM 출력 영향 | 탐색 지연 | 전체 decomposition 실패 가능 | 탐색 지연 |
| 별도 solver 필요성 | 선택적 | 높음: MILP/CP-SAT 등 | 낮음 |
| 구현 난도 | 매우 높음 | 높음 | 낮음 |
| 연구 신규성 가능성 | 높음 | 가장 높음 | 중간 |
| 2B 비교 적합성 | 중간 | 가장 높음 | 높음 |
| 현재 경험 사례와 연결 | 중간 | 직접적 | 부분적 |

---

## 7. 권장 연구 방향

세 후보 중 **Numeric-Aware Subgoal Decomposer**를 우선 연구 주제로 권장한다.

이유는 다음과 같다.

1. 12kg 캐리어와 10개 소포의 경험적 관찰을 직접 연구 가설로 전환할 수 있다.
2. Numeric resource가 task decomposition에 어떤 영향을 주는지 명확하게 측정할 수 있다.
3. 2B 모델과 큰 모델의 차이를 subgoal validity, feasibility 및 search reduction으로 분리해 평가할 수 있다.
4. Global planner, greedy batching, optimization-only decomposition과 직접 비교할 수 있다.
5. Heuristic weight tuning보다 LLM의 semantic abstraction 능력과 잘 맞는다.
6. Preferred action보다 큰 planning problem의 effective horizon과 조합 공간을 직접 줄일 가능성이 크다.

### 권장 연구명

**Numeric-Aware Subgoal Proposal with Small Language Models for Scalable Robot Task Planning**

또는:

**Resource-Aware Subgoal Decomposition with Small Language Models for Numeric Robot Planning**

### 핵심 연구 질문

> Can a sub-2B language model propose resource-aware subgoals that reduce global planning complexity while retaining numeric feasibility and solution recoverability?

한국어:

> 2B 이하 소형 언어모델이 수치 자원을 고려한 subgoal을 제안함으로써, 전체 계획의 수치적 실행 가능성과 실패 복구 가능성을 유지하면서 전역 planning의 탐색 복잡도를 줄일 수 있는가?

---

## 8. 권장 시스템 범위

첫 논문에서는 다음 범위로 제한한다.

### 포함

- 주어진 symbolic/numeric PDDL
- Sub-2B SLM의 candidate subgoal proposal
- Symbolic conditions와 numeric resource contract
- MILP/CP-SAT 또는 numeric planner 기반 feasibility 검사
- Subgoal partial ordering
- Sequential planning
- 실패 시 다른 decomposition 또는 global planning fallback
- 2B, 7B/8B, frontier LLM 및 비LLM baseline 비교

### 제외 또는 후속 연구

- PDDL domain/problem 자동 생성
- Search-control mechanism 자동 선택
- Adaptive heuristic weight update
- Raw continuous motion planning
- Perception과 symbolic state estimation
- Real-time execution monitoring
- Multi-robot task allocation

---

## 9. 최소 구현안

### Phase 1. Capacity-only benchmark

- 소포 무게
- 캐리어 capacity
- Pickup, unload, return action
- 위치는 단순화하거나 고정
- Greedy, IP, SLM decomposition 비교

목표는 SLM이 capacity-feasible candidate subgoal을 생성하는지 확인하는 것이다.

### Phase 2. Spatial routing 추가

- Package 위치
- 이동 거리
- Battery 또는 travel cost
- Depot 복귀

목표는 12kg을 정확히 채우는 것보다 spatial locality까지 고려한 decomposition이 가능한지 확인하는 것이다.

### Phase 3. 복합 resource 추가

- Capacity
- Battery
- Deadline
- Precedence

목표는 단일 numeric constraint에서 학습·설계된 decomposition이 여러 resource의 결합에도 일반화되는지 확인하는 것이다.

### Phase 4. RoboCasa-derived task

- Object count/capacity
- Distance 또는 navigation cost
- 시간·온도 등 실제 task에 자연스러운 numeric fluent
- Long-horizon manipulation task

RoboCasa가 실제 numeric ground truth를 충분히 제공하는지 먼저 확인해야 한다.

---

## 10. 핵심 실험표 초안

| Method | Decomposition | Numeric-aware | Verifier | Model size | Coverage | Nodes | Time | Validity |
|---|---|---|---|---:|---:|---:|---:|---:|
| Global planner | 없음 | Planner only | Planner | - | | | | |
| Random | Random batch | 제한적 | Numeric | - | | | | |
| Greedy | Capacity-first | Yes | Numeric | - | | | | |
| IP/MILP | Optimization | Yes | 자체 보장 | - | | | | |
| SLM | Candidate subgoal | Yes | 없음 | ≤2B | | | | |
| SLM + verifier | Candidate subgoal | Yes | Global numeric | ≤2B | | | | |
| Medium LM + verifier | Candidate subgoal | Yes | Global numeric | 7B/8B | | | | |
| Large LLM + verifier | Candidate subgoal | Yes | Global numeric | Large | | | | |
| Oracle | Expert subgoal | Yes | Global numeric | - | | | | |

핵심 비교는 다음이다.

```text
Global planner
vs. optimization-only decomposition
vs. 2B SLM decomposition
vs. large LLM decomposition
```

이를 통해 다음을 분리할 수 있다.

- Decomposition 자체의 효과
- Numeric awareness의 효과
- LLM semantic prior의 효과
- 모델 크기의 효과
- Verifier와 fallback의 효과

---

## 11. 필수 ablation

1. Numeric constraint 없이 symbolic 정보만 제공
2. 위치 정보 제거
3. SLM 대신 random grouping
4. SLM 대신 greedy capacity packing
5. Global feasibility 검사 제거
6. Partial order 대신 SLM total order 강제
7. Fallback 제거
8. Predicate와 object 이름 익명화
9. Candidate subgoal 수 변화
10. 모델 크기별 비교

특히 predicate/object 익명화는 SLM이 자연어 의미를 활용한 것인지 relational structure를 이해한 것인지 구분한다.

---

## 12. 가장 중요한 반론

### “소포 grouping은 LLM보다 MILP가 더 잘 푼다.”

무게와 위치가 완전히 구조화되어 있고 목적함수가 명확하다면 맞는 주장이다. 이 경우 LLM의 필요성이 없다.

따라서 논문은 다음 중 하나를 입증해야 한다.

1. SLM이 MILP가 다룰 candidate 수를 크게 줄여 전체 시간을 감소시킨다.
2. SLM이 다양한 domain에서 사람이 decomposition objective를 직접 설계하지 않아도 의미 있는 candidate를 만든다.
3. SLM이 symbolic semantics와 numeric resource를 결합해 단순 capacity optimization보다 search에 유리한 subgoal을 만든다.
4. 큰 모델과 유사한 guidance를 2B 이하 모델이 더 낮은 비용으로 제공한다.

이 중 하나도 입증되지 않으면 optimization-only 방식이 더 타당하다.

---

## 13. 결론

세 연구 후보는 각각 독립적인 주제이며, mechanism selection 문제로 확장하지 않는다.

- Heuristic mapper는 연구성이 높지만 LLM 초기화와 adaptive update가 섞여 첫 연구로는 복잡하다.
- Preferred action은 안전하고 구현하기 쉽지만 기존 learned action ordering과의 차별성이 약할 수 있다.
- Numeric-aware subgoal decomposition은 현재 경험 사례, 2B 모델 비교 및 대형 환경의 search reduction을 하나의 명확한 연구 질문으로 연결할 수 있다.

따라서 현재 우선안은 다음이다.

> **2B 이하 SLM이 numeric constraint와 symbolic semantics를 이용해 여러 candidate subgoal을 제안하고, MILP/CP-SAT 또는 numeric planner가 feasible subgoal과 partial ordering을 선택한 뒤 classical planner가 순차적으로 plan을 생성한다.**

연구 성공 여부는 LLM이 subgoal을 생성할 수 있다는 것보다, 다음을 실험적으로 보이는 데 달려 있다.

1. Global planning보다 search effort가 감소한다.
2. Optimization-only decomposition보다 semantic structure를 더 잘 활용한다.
3. 2B 모델이 큰 모델에 근접한 subgoal utility를 제공한다.
4. 잘못된 decomposition에서도 verifier와 fallback을 통해 valid plan을 찾을 수 있다.

## 참고 문헌

- Fast and Accurate Task Planning using Neuro-Symbolic Language Models and Multi-level Goal Decomposition: https://arxiv.org/abs/2409.19250
- Search-Guidance Mechanisms for Numeric Planning Through Subgoaling Relaxation: https://doi.org/10.1609/icaps.v30i1.6665
- Trust the PRoC3S: https://proceedings.mlr.press/v270/curtis25a.html
- PIP-LLM: https://arxiv.org/abs/2510.22784
- Fast Downward Planning System: https://www.jair.org/index.php/jair/article/view/10457
