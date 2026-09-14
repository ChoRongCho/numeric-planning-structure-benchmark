# LLM Heuristic와 Numeric Planning Baseline 조사 보고서

- 작성일: 2026-09-07
- 범위: 이미 주어진 PDDL domain/problem을 푸는 search guidance
- 제외: 자연어에서 PDDL 생성, LLM의 end-to-end plan 생성 자체
- 목적: 2B 이하 SLM의 numeric-aware search guidance를 검증할 1차 baseline 선정

## 1. 결론

현재 확인한 문헌에서 다음 두 연구 흐름은 분명하지만, 두 흐름의 교차점은 거의 비어 있다.

1. **LLM + classical planning**: LLM이 상태 휴리스틱 코드, action proposal, preferred action, subgoal 또는 pruning signal을 만들어 symbolic search를 안내한다.
2. **numeric planning**: numeric relaxation, helpful action, novelty, pattern database, LP 또는 GNN으로 numeric state를 평가한다.

그러나 **이미 주어진 numeric PDDL에 대해 LLM/SLM이 numeric fluent와 constraint를 읽고 재사용 가능한 heuristic function을 생성하여 classical numeric planner의 탐색을 안내하는 연구**는 직접적인 선행 사례를 찾기 어렵다. 이 공백이 현재 아이디어의 연구 기회다.

1차 연구의 주 baseline paper는 다음 논문을 권장한다.

> Augusto B. Corrêa, André G. Pereira, Jendrik Seipp, **Classical Planning with LLM-Generated Heuristics: Challenging the State of the Art with Python Code**, NeurIPS 2025.

이 논문의 방법론을 **numeric state를 입력받는 heuristic-code generation으로 확장**하고, 실행 엔진과 numeric 기준선은 **ENHSP**를 사용하는 것이 가장 정합적이다. 즉 논문 baseline은 Corrêa et al., planner baseline은 ENHSP로 분리한다.

---

## 2. Search guidance의 분류

LLM이 classical planner를 돕는 방식은 다음과 같이 구분할 수 있다.

| 방식 | LLM 출력 | Search에 미치는 영향 | 대표 연구 | 현재 연구와의 관계 |
|---|---|---|---|---|
| State heuristic | `h(s)`를 계산하는 점수/코드 | open list의 state 순서 변경 | Corrêa et al. | 가장 직접적 |
| Preferred action | 유망한 action 또는 action score | successor 탐색 순서/별도 queue 변경 | SayCanPay, HBTP | 차선 후보 |
| Node/action pruning | 관련 없는 object/action 제거 | 탐색 공간 자체 축소 | Scale-Plan 계열 | 불완전성 위험 |
| Subgoal guidance | 중간 조건/waypoint 제안 | subgoal proximity를 점수에 결합 | LLM-A*, HBTP 계열 | soft guidance로 응용 가능 |
| Hard decomposition | subgoal을 실제 목표로 순차 해결 | 문제를 여러 planning problem으로 분리 | 여러 LLM task decomposition 연구 | 신뢰성·ordering 문제가 큼 |
| Offline heuristic synthesis | 도메인당 한 번 LLM을 호출해 코드 생성 | runtime에는 LLM 호출 없음 | Corrêa et al. | 2B 실험에 적합 |

용어는 `search-space control`보다 **search guidance**가 상위 개념으로 적절하다. Pruning은 search-space control이고, heuristic 및 preferred action은 대개 node/action ordering을 바꾸는 soft guidance다.

---

## 3. Classical planning에서 LLM을 heuristic으로 사용한 연구

### 3.1 Corrêa et al. (NeurIPS 2025): LLM-generated heuristic code

#### 방법

LLM에 다음 자료를 제공하고 domain-dependent Python heuristic을 생성하게 한다.

- 대상 PDDL domain
- training set의 가장 작은 문제와 가장 큰 문제
- 다른 두 domain의 heuristic 구현 예시
- Pyperplan의 state/static 정보 예시
- task/action을 표현하는 planner 코드
- 구현 시 흔한 오류에 관한 checklist

동일 prompt를 25회 sampling하여 25개의 후보 휴리스틱을 만든다. 각 후보를 training problem에서 greedy best-first search(GBFS)로 실행하고, 가장 많은 문제를 해결한 후보를 선택한다. 동률이면 실행시간 기반 agile score를 사용한다. 선택된 함수는 동일 domain의 더 크고 보지 못한 problem에 재사용한다.

```text
PDDL domain + small/large training instances + planner API
                         ↓
                 LLM을 25회 sampling
                         ↓
             Python heuristic 후보 h1 ... h25
                         ↓
            training instances에서 GBFS 평가
                         ↓
                 가장 강한 h* 선택
                         ↓
          unseen/OOD instances의 GBFS에 고정 사용
```

#### Search guidance의 성격

- LLM은 plan을 직접 출력하지 않는다.
- 생성된 `h(s)`는 state expansion 순서만 바꾼다.
- successor의 applicability와 goal 판정은 symbolic planner가 담당한다.
- 따라서 heuristic이 부정확해도 반환된 plan의 validity는 planner가 보장한다.
- domain당 고정 횟수만 LLM을 호출하고 test-time에는 재호출하지 않는다.

#### 주요 결과

논문은 IPC 2023 Learning Track의 8개 propositional domain, domain당 90개 test problem을 사용했다. DeepSeek R1 생성 휴리스틱은 총 720개 중 373개를 해결했고, 같은 Pyperplan의 `hFF`는 243개를 해결했다. 단, 결과는 domain별 편차가 크다. 작은 모델 실험은 DeepSeek-R1-Distill-Qwen-14B까지이며, 이 모델은 전체 합계에서 `hFF`보다 낮았다. **2B 이하 모델은 평가하지 않았다.**

#### 장점

- 우리의 전제인 “PDDL은 이미 주어짐”과 일치한다.
- LLM을 반복적인 online oracle로 사용하지 않는다.
- heuristic code를 열어볼 수 있어 numeric feature 사용 여부를 분석할 수 있다.
- 작은 모델과 큰 모델에 동일 prompt/protocol을 적용하기 쉽다.
- 공식 코드와 benchmark가 공개되어 재현 가능성이 높다.

#### 한계

- Pyperplan 및 논문의 문제는 propositional classical planning이다.
- numeric fluent, numeric precondition/effect, metric cost를 다루지 않는다.
- unit-cost satisficing planning과 pure GBFS만 평가한다.
- 생성 휴리스틱은 admissible하지 않으며 optimality가 목적이 아니다.
- 25개 후보를 training instances에서 고르는 selection cost가 존재한다.

#### 판정

**현재 연구의 가장 적절한 주 baseline이다.** 우리가 바꿀 부분은 heuristic 함수가 읽는 state와 prompt에 numeric fluent/constraint 구조를 추가하는 것이다.

### 3.2 Property-Guided LLM Program Synthesis for Planning (2026)

Corrêa et al.의 후속 방향이다. 단순히 여러 후보를 sampling하고 점수로 고르는 대신, 생성된 휴리스틱이 `directness` 성질을 위반하는 counterexample을 찾아 LLM에 돌려주며 코드를 고친다. 여기서 directness는 strictly improving transition을 따라갈 때 계속 개선되는 successor가 존재하는 성질이다.

- 장점: 후보 생성과 평가 비용을 크게 줄이는 repair loop
- 한계: 여전히 propositional PDDL이며 numeric constraint를 다루는 연구가 아님
- 활용: 1차 baseline보다는 후속 연구에서 numeric counterexample을 제공하는 방법으로 적합

### 3.3 Query-Efficient Planning with Language Models (2024)

LLM을 search heuristic으로 사용하는 방식과 LLM을 generative planner로 사용하는 방식을 비교한다. heuristic 방식에서는 LLM이 유망한 node와 action proposal을 제공한다.

- 관련성: LLM을 planner 내부 search oracle로 사용하는 대표 비교점
- 한계: online query가 필요하고, 목표도 world-model query 수 최소화에 가깝다.
- 판정: 반복 LLM 호출을 피하려는 현재 설계의 직접 baseline으로는 Corrêa et al.보다 부적절하다.

### 3.4 SayCanPay (AAAI 2024)

각 단계에서 다음 신호를 결합해 action sequence를 탐색한다.

- **Say**: LLM이 다음 action 후보를 제안
- **Can**: action feasibility/affordance 평가
- **Pay**: 장기 payoff 평가

이는 state heuristic보다는 **learned action scoring + heuristic search**에 가깝다. preferred-action 연구를 선택한다면 중요한 baseline이지만, 고정된 numeric PDDL에서 domain-level heuristic을 생성하려는 현재 방향과는 차이가 있다.

### 3.5 기타 인접 연구

- **HBTP**: LLM이 heuristic path 및 relevant action set을 제안하여 behavior-tree search를 안내하고, 실패 시 fallback/re-expansion을 수행한다.
- **LLM-A\***: LLM의 waypoint/global knowledge를 전통적 path-planning heuristic에 결합한다. task-level PDDL보다는 navigation에 가깝다.
- **Scale-Plan**: action graph와 LLM reasoning으로 관련 action/object의 최소 부분집합을 골라 planner 입력을 줄인다. 점수형 heuristic보다 hard filtering에 가깝다.
- **LLM-Evolved Domain-Independent Heuristics**: LLM이 C++ heuristic program을 진화시키고 MAP-Elites로 informedness와 계산속도를 함께 탐색한다. 강력하지만 첫 baseline으로는 계산·구현 부담이 크다.

---

## 4. Numeric planning을 LLM으로 다룬 연구

### 4.1 직접적인 numeric-PDDL heuristic 연구의 공백

조사 범위에서 찾은 LLM + numeric 연구는 대개 다음 중 하나다.

- 자연어 constraint를 formal constraint/PDDL로 번역
- LLM이 continuous skill sequence의 구조를 제안하고 optimizer가 수치를 결정
- symbolic plan 이후 task allocation을 LP/IP로 최적화
- LLM proposal을 simulator/constraint solver로 검증하고 다시 prompt

즉 **LLM이 numeric planning state마다 또는 domain마다 `h(s)`를 만들어 forward heuristic search를 안내하는 형태**와는 다르다.

### 4.2 Collaborative Numeric Task Planning via Constraint Translation (2025)

LLM이 자연어 요구를 분해하고 PDDL3 trajectory constraint로 번역한 뒤 numeric planner가 이를 해결한다. 저자들은 constraint를 solver에게 “하지 말아야 할 것”을 알려주는 negative heuristic으로 해석한다.

- numeric planning 관련성: 있음
- search heuristic 관련성: 간접적
- 현재 범위와의 차이: PDDL/problem이 이미 주어진 것이 아니라 constraint translation이 핵심
- baseline 판정: 제외하되 related work에는 포함

### 4.3 PRoC3S (CoRL 2024/Proceedings 2025)

LLM이 open parameter를 가진 skill-sequence code를 출력하고, 환경 constraint와 결합해 Continuous CSP를 만든다. Sampling/optimization으로 연속 파라미터를 찾고, unsatisfiable하면 LLM을 다시 호출한다.

- 장점: 기하·운동학·물리 constraint를 실제로 다룸
- 차이: PDDL numeric heuristic search가 아니라 TAMP/CCSP이며 iterative re-prompting을 사용
- baseline 판정: robot numeric constraint의 인접 연구이지 직접 baseline은 아님

### 4.4 PIP-LLM 계열

LLM/PDDL로 얻은 symbolic 계획을 dependency graph로 바꾸고 IP로 multi-robot task allocation, travel cost 및 workload를 최적화한다. Numeric optimization은 존재하지만 search heuristic을 생성하는 것은 아니다.

---

## 5. LLM 없이 numeric search guidance를 수행한 핵심 연구

LLM baseline을 numeric problem으로 확장할 때 반드시 비교해야 할 classical/learned 기준선이다.

### 5.1 Numeric subgoaling relaxation — Scala et al. (ICAPS 2020)

Numeric subgoal 만족에 필요한 regression-based necessary condition을 이용한다. Multi-repetition relaxed plan에서 action이 몇 번 실행되어야 하는지 계산하고, 이를 다음 세 가지 guidance로 활용한다.

1. concrete relaxed-plan heuristic
2. subgoaling-based helpful actions
3. up-to-jumping actions

이는 사용자가 생각한 “numeric constraint를 이해한 subgoal을 실제 중간 목표로 강제하지 않고 search guidance로 사용”하는 아이디어와 가장 가까운 classical numeric 연구다. 따라서 **개념적 numeric baseline**으로 매우 중요하다.

### 5.2 Novelty, multi-queue, portfolio — Chen & Thiébaux (2024)

Numeric novelty, Manhattan-distance heuristic, multi-queue search 및 heuristic portfolio를 ENHSP에 결합한다. 이 논문의 중요한 메시지는 성능 향상이 반드시 더 정교한 단일 휴리스틱에서만 나오지 않으며, 서로 다른 guidance를 여러 queue로 결합하는 search architecture도 중요하다는 것이다.

LLM heuristic을 기존 numeric heuristic과 결합할 때 다음 구조를 사용할 수 있다.

```text
Queue A: classical numeric heuristic
Queue B: LLM-generated numeric heuristic
Queue C: novelty or preferred actions
```

하지만 1차 실험에서는 LLM 효과를 분리하기 위해 pure GBFS의 단일 heuristic으로 먼저 비교하는 편이 낫다.

### 5.3 GNN heuristic for numeric planning — Borelli et al. (AAAI 2026)

Numeric condition의 object 관계와 numeric fluent 값을 graph message에 함께 넣고, GNN이 `h(s)`를 출력하도록 학습한다. Learned heuristic을 best-first search에 사용하며, 일부 domain에서 기존 heuristic보다 guidance/계산비용 trade-off가 좋다고 보고한다.

이 논문은 LLM 연구는 아니지만 다음 질문의 직접 비교군이다.

> LLM의 pretrained common sense로 생성한 heuristic이 numeric training data로 학습한 GNN heuristic과 비교해 어떤 이점이 있는가?

다만 AAAI 2026의 최신 방법이라 코드 및 benchmark 재현성을 먼저 확인해야 한다.

### 5.4 Numeric PDB — Gnad et al. (AAAI 2025), Fritzsche et al. (AAAI 2026)

Linear condition과 constant numeric effect를 가진 simple numeric planning에 pattern-database heuristic을 확장한다. Numeric projection이 무한해질 수 있어 유한한 abstraction을 구성하는 방법이 핵심이다. Optimal numeric planning과 admissibility가 목표라면 중요한 기준선이지만, 본 연구의 첫 목표인 satisficing coverage와는 우선순위가 낮다.

### 5.5 ENHSP

ENHSP는 propositional 및 linear/non-linear numeric expression을 지원하는 forward heuristic-search planner다. 기본 satisficing 설정은 GBFS와 numeric `h_add` 계열을 사용하며, subgoaling relaxation 기반 search guidance도 제공한다. 현재 연구의 numeric execution substrate로 가장 자연스럽다.

---

## 6. Baseline 최종 선정

### 6.1 주 baseline paper

**Corrêa et al. (NeurIPS 2025)**를 선택한다.

선정 이유는 다음과 같다.

1. LLM의 역할이 오직 heuristic generation이라 연구 질문과 정확히 맞는다.
2. LLM이 만든 정보가 plan validity를 침범하지 않는다.
3. domain당 offline 생성이므로 반복 호출 문제를 피한다.
4. heuristic code를 분석해 capacity, weight, battery, distance를 실제로 사용했는지 확인할 수 있다.
5. 공식 코드가 공개되어 먼저 propositional 결과를 재현할 수 있다.
6. 기존 최소 모델이 14B이므로 2B 이하 비교가 명확한 연구 질문이 된다.

### 6.2 Numeric planner 및 heuristic baseline

하나의 논문만으로 numeric 비교를 완성할 수 없으므로 다음 stack을 권장한다.

| 역할 | 선택 |
|---|---|
| LLM 방법론 baseline | Corrêa et al. 2025 |
| Numeric planner | ENHSP |
| Classical numeric heuristic | ENHSP의 `h_add`/subgoaling 계열 |
| No-guidance baseline | blind search |
| Optional learned baseline | Borelli et al. 2026 GNN heuristic |
| Optional search-control baseline | numeric novelty/multi-queue |

“논문 하나를 baseline으로 삼는다”는 의미에서는 Corrêa et al. 하나를 중심으로 삼고, ENHSP의 기본 설정은 필수 실험 대조군으로 둔다.

---

## 7. 권장 1차 문제 정의

연구 질문을 다음처럼 좁힌다.

> **고정된 numeric PDDL domain에서, 2B 이하 SLM이 domain과 소수의 training instance만 보고 생성한 numeric-aware heuristic code가 ENHSP의 GBFS에서 기존 numeric heuristic보다 unseen 대형 instance의 coverage와 search efficiency를 향상시킬 수 있는가?**

### 7.1 첫 domain

처음부터 battery, distance, capacity를 모두 넣지 않는다. 우선 **capacitated transport** 하나만 사용한다.

- package별 weight
- vehicle/carrier의 capacity
- 현재 load
- pickup/delivery predicate
- 이동은 처음에는 unit cost
- 목표는 모든 package delivery

이 domain은 기존 12kg 캐리어 예시를 그대로 formalize할 수 있으며, LLM이 다음 common sense를 heuristic code로 표현하는지 확인할 수 있다.

- capacity를 넘는 조합은 유망하지 않다.
- 남은 capacity를 잘 채우는 package 조합이 유리할 수 있다.
- 이미 같은 경로/목적지에 있는 package를 함께 처리하는 것이 유리하다.

다만 LLM이 만든 batch를 hard subgoal로 강제하지 않는다. 예를 들어 batch alignment를 soft term으로 둔다.

```text
h_LLM(s) = generated numeric-aware score

또는

h_mix(s) = h_numeric(s) + lambda * h_LLM(s)
```

첫 실험은 `h_LLM` 단독으로 Corrêa protocol을 재현하고, 두 번째 실험에서 `h_mix`를 추가한다. 그래야 LLM heuristic 자체의 능력과 기존 heuristic 보완 효과가 분리된다.

### 7.2 모델 비교

- 0.5B/1B급 SLM
- 1.5B 또는 2B 이하 SLM
- 7B/8B 모델
- frontier LLM 1종
- LLM 없이 handcrafted/classical heuristic

모든 모델에 동일 prompt, 동일 candidate 수, 동일 training budget을 적용한다. 2B 모델만 context-length 문제로 정보를 덜 제공하면 모델 크기 효과와 prompt 정보량 효과가 섞이므로 피해야 한다.

### 7.3 실험군

최소 실험군은 다음과 같다.

1. Blind GBFS
2. ENHSP classical numeric heuristic
3. Handcrafted capacity-aware heuristic
4. Random/generated-but-numeric-ablated heuristic
5. 2B 이하 SLM-generated heuristic
6. Large-LLM-generated heuristic
7. 선택 사항: classical numeric heuristic + SLM soft term

### 7.4 평가 지표

- Coverage: 제한 시간 내 해결한 problem 수
- Plan validity와 goal achievement
- Expanded/generated states
- Wall-clock planning time
- Heuristic evaluation time
- Plan length 및 총 이동/실행 cost
- Peak memory
- Domain당 LLM 호출 수, token 수 및 생성 시간
- OOD size generalization
- Numeric-awareness test: numeric fluent 이름/값을 shuffle하거나 제거했을 때 성능 하락

마지막 ablation이 중요하다. 단순히 성능이 좋아진 것만으로는 모델이 numeric constraint를 이해했다고 말할 수 없다. 다음 반사실 검사를 포함해야 한다.

- 동일 symbolic structure에서 weight만 변경
- capacity만 변경
- fluent 이름을 의미 없는 토큰으로 치환
- constraint 설명은 유지하고 numeric values만 permutation
- heuristic code에서 numeric term을 제거

---

## 8. 예상 novelty와 주의점

### 8.1 주장 가능한 novelty

- LLM-generated heuristic program을 propositional planning에서 numeric PDDL로 확장
- 2B 이하 SLM의 domain-level heuristic synthesis 능력 평가
- online LLM 호출 없이 numeric common sense를 search에 주입
- numeric-awareness를 반사실 ablation과 생성 코드 분석으로 검증

### 8.2 아직 주장하면 안 되는 것

- “LLM이 numeric reasoning을 한다”: 코드가 숫자를 읽는 것만으로는 부족하다.
- “optimal plan을 찾는다”: GBFS와 비-admissible heuristic이면 보장되지 않는다.
- “완전성을 보장한다”: heuristic이 state ordering만 바꾸더라도 구현의 duplicate handling, dead-end 값, timeout 및 search 설정에 따라 표현을 신중히 해야 한다.
- “모든 numeric domain에 일반화한다”: 첫 논문은 capacity-constrained transport 하나로 제한하고 battery/continuous domain은 후속으로 둔다.

---

## 9. 실행 순서

1. Corrêa et al. 공식 코드에서 propositional domain 1개를 재현한다.
2. 같은 protocol로 2B 이하 모델이 executable heuristic code를 생성하는지 측정한다.
3. Capacitated Transport numeric PDDL benchmark generator를 만든다.
4. ENHSP의 state/heuristic extension point 또는 별도 Python numeric GBFS wrapper를 확인한다.
5. Blind, ENHSP 기본, handcrafted capacity heuristic을 먼저 실행한다.
6. SLM/LLM이 생성한 numeric heuristic을 동일 search에 삽입한다.
7. Coverage, expansions, runtime 및 numeric counterfactual ablation을 수행한다.
8. 효과가 확인된 뒤에만 battery+distance의 두 constraint domain으로 확장한다.

---

## 10. 참고문헌 및 원문

- [Corrêa et al., Classical Planning with LLM-Generated Heuristics, NeurIPS 2025](https://proceedings.neurips.cc/paper_files/paper/2025/hash/3bf4b55960aaa23553cd2a6bdc6e1b57-Abstract-Conference.html)
- [Corrêa et al. official implementation](https://github.com/abcorrea/llm-generated-heuristics)
- [Corrêa et al., Property-Guided LLM Program Synthesis for Planning, 2026](https://arxiv.org/abs/2605.16142)
- [Gonzalez-Pumariega et al., Query-Efficient Planning with Language Models, 2024](https://arxiv.org/abs/2412.06162)
- [Hazra et al., SayCanPay, AAAI 2024](https://ojs.aaai.org/index.php/AAAI/article/view/29991)
- [Scala et al., Search-Guidance Mechanisms for Numeric Planning Through Subgoaling Relaxation, ICAPS 2020](https://ojs.aaai.org/index.php/ICAPS/article/view/6665)
- [Chen and Thiébaux, Novelty Heuristics, Multi-Queue Search, and Portfolios for Numeric Planning, 2024](https://arxiv.org/abs/2404.05235)
- [Borelli et al., Learning Heuristic Functions with Graph Neural Networks for Numeric Planning, AAAI 2026](https://ojs.aaai.org/index.php/AAAI/article/view/40935)
- [Gnad et al., PDBs Go Numeric, AAAI 2025](https://ojs.aaai.org/index.php/AAAI/article/view/34851)
- [Fritzsche et al., Managing Infinite Abstractions in Numeric PDB Heuristics, AAAI 2026](https://ojs.aaai.org/index.php/AAAI/article/view/40941)
- [ENHSP official repository](https://github.com/hstairs/enhsp)
- [Curtis et al., Trust the PRoC3S, CoRL/PMLR 2025](https://proceedings.mlr.press/v270/curtis25a.html)

## 11. 한 문장 연구 방향

> **Corrêa et al.의 offline LLM heuristic-program synthesis를 ENHSP 기반 capacitated numeric planning으로 확장하고, 2B 이하 SLM이 생성한 soft state guidance가 기존 numeric heuristic 대비 대형 unseen problem의 탐색 효율을 높이는지 검증한다.**
