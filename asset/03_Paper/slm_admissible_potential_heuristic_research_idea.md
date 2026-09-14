# 소형 언어모델 기반 Admissible Potential Heuristic 연구 아이디어

- 상태: 1차 토론 초안
- 작성일: 2026-09-06
- 적용 후보: RoboCasa 기반 로봇 task planning 및 classical planning benchmark

## 1. 연구 아이디어 한 문장

2B 이하의 소형 언어모델(SLM)은 planning heuristic 값을 직접 예측하지 않고 도메인 수준의 해석 가능한 상태 feature를 한 번만 제안하며, symbolic LP compiler가 이 feature를 admissible하고 consistent한 potential heuristic으로 변환해 실행 중 LLM 호출 없이 탐색을 유도한다.

영문 working statement:

> A sub-2B language model is used once to propose interpretable domain-level features, while a symbolic LP compiler converts them into an admissible and consistent potential heuristic for zero-query runtime search.

## 2. 연구 배경과 문제의식

LLM은 상식과 도메인 지식을 활용해 로봇 작업에 대해 그럴듯한 계획을 생성하는 데 효과적이다. 그러나 다음과 같은 한계가 있다.

1. 기존 연구는 주로 큰 LLM 또는 적어도 수십억 파라미터 규모의 모델에 의존하며, 2B 이하 온디바이스 모델의 search guidance 능력은 충분히 연구되지 않았다.
2. 직접 계획 생성은 긴 horizon, 큰 상태 공간, 복잡한 제약에서 유효한 계획을 안정적으로 만들기 어렵다.
3. 반복적인 LLM 호출, tree search, self-correction 또는 외부 validator를 사용하는 방식은 추론 비용과 지연이 탐색 규모에 따라 누적될 수 있다.
4. Validator는 생성된 계획의 오류를 검출할 수 있지만, 그 자체로 completeness, optimality 또는 제한된 search effort를 보장하지 않는다.
5. LLM을 휴리스틱 값 예측, action proposal 또는 pruning에 직접 사용하면 형식적 보장이 약해질 수 있다.
6. 학습된 휴리스틱은 어떤 도메인 지식 때문에 효과적인지 해석하기 어려운 경우가 많다.

## 3. 용어와 주장 구분

### 3.1 Admissibility

휴리스틱 `h(s)`가 모든 상태에서 실제 최적 잔여 비용 `h*(s)`을 초과하지 않으면 admissible하다.

```text
h(s) ≤ h*(s)
```

이는 A*와 같은 optimal search에서 최적 계획 보장과 연결된다.

### 3.2 Consistency

모든 적용 가능한 action `a`와 successor `s'`에 대해 다음을 만족하면 consistent하다.

```text
h(s) ≤ cost(a) + h(s')
```

일반적으로 goal-aware한 consistent heuristic은 admissible하다.

### 3.3 Action pruning과 admissibility의 차이

- 휴리스틱 값에는 admissible/inadmissible이라는 표현을 사용한다.
- Action pruning에는 completeness 또는 optimality preservation이라는 표현을 사용한다.
- Action의 순서만 조정하는 preferred operator는 모든 action을 탐색 후보로 유지하면 completeness를 보존할 수 있다.
- Action을 완전히 제거하는 hard pruning은 feasible 또는 optimal solution을 제거할 수 있다.
- Macro action은 원래 action을 함께 유지하는지에 따라 보존 성질이 달라진다.

따라서 “action pruning이 inadmissible하다”는 표현은 피하고, 휴리스틱의 최적성 보장과 pruning의 탐색 완전성을 분리해 서술해야 한다.

## 4. 제안 방법

### 4.1 전체 파이프라인

```text
PDDL domain + task semantics
            ↓
소형 LLM 1회 호출
            ↓
의미 있는 potential feature 후보 생성
            ↓
문법·타입·grounding 형식 검사
            ↓
LP 기반 potential weight 최적화
            ↓
consistent + admissible heuristic
            ↓
A* search — 실행 중 LLM 호출 없음
```

### 4.2 역할 분리

소형 LLM은 다음을 수행한다.

- 도메인의 goal progress를 나타낼 feature template 제안
- 중요한 object–fixture 또는 state–goal 상호작용 제안
- 필요하면 unary feature와 binary/conjunctive feature 후보의 우선순위 제안

소형 LLM은 다음을 직접 결정하지 않는다.

- 각 상태의 최종 heuristic value
- 형식적 보장 없이 임의로 선택한 feature weight
- 탐색에서 완전히 제거할 action
- 최종 계획의 유효성 판정

Symbolic component는 다음을 수행한다.

- 제안 feature의 PDDL grounding 및 타입 검사
- potential heuristic의 consistency와 goal-awareness 제약 구성
- LP를 이용한 weight 최적화
- admissibility와 consistency 검증
- A* 또는 다른 optimal search와 결합

### 4.3 Potential heuristic

feature 집합 `F`와 weight `w_f`가 있을 때 상태의 potential은 다음처럼 표현한다.

```text
h_pot(s) = Σ_{f ∈ F} w_f · [s ⊨ f]
```

여기서 `[s ⊨ f]`는 상태 `s`에서 feature `f`가 참이면 1, 아니면 0이다. LLM은 `F`를 제안하고, weight는 LP 제약을 만족하도록 계산한다.

핵심 안전성 주장은 다음과 같다.

> LLM이 약한 feature를 제안하면 heuristic informativeness가 낮아질 수는 있지만, weight synthesis와 검증을 symbolic component가 담당하므로 LLM의 출력이 직접 admissibility를 깨뜨리지 않는다.

### 4.4 RoboCasa feature 후보 예시

- `object-at-goal`
- `required-container-open`
- `robot-holding-required-object`
- `object-and-destination-pair`
- `unsatisfied-precondition`
- `blocking-object-present`
- 목표 물체와 receptacle의 결합 관계
- fixture 상태와 다음 manipulation action의 결합 관계

실제 feature는 RoboCasa의 primitive, PDDL predicate 및 action cost 정의에 맞춰 형식화해야 한다.

## 5. 예상 기여

1. **소형 모델 연구:** 0.5B–2B 모델이 classical planning의 feature synthesis에 제공하는 효용을 분석한다.
2. **형식적 안전성:** LLM의 예측을 직접 heuristic 값으로 사용하지 않고 LP feasible region 안으로 제한해 admissibility와 consistency를 보장한다.
3. **낮은 실행 비용:** LLM은 domain 또는 problem 전처리 단계에서 제한적으로 호출하고 search loop에서는 호출하지 않는다.
4. **해석 가능성:** heuristic 값을 symbolic feature별 기여도로 분해한다.
5. **일반화:** 한 번 생성한 domain-level feature가 더 크거나 새로운 object configuration을 가진 problem에 적용되는지 평가한다.

중요한 점은 “admissibility를 보장했다” 자체보다 다음 주장이다.

> SLM이 제안한 semantic feature를 사용하면 기존 feature-selection 방식보다 작은 feature budget으로 더 informative한 admissible heuristic을 얻을 수 있다.

## 6. 연구 질문

### RQ1. 탐색 효율

2B 이하 SLM이 생성한 feature가 기존 unary/binary potential heuristic 및 비학습 feature selection보다 search node expansion을 줄이는가?

### RQ2. 형식적 보장

SLM이 생성한 feature를 LP 기반 potential heuristic으로 변환할 때 모델 크기와 출력 품질에 관계없이 admissibility와 consistency를 유지할 수 있는가?

### RQ3. 일반화

Domain-level feature가 더 큰 unseen problem, unseen task instance 및 새로운 object configuration에 일반화되는가?

### RQ4. LLM의 실제 기여

SLM feature proposal이 random, frequency-based, causal-graph-based, mutex-based 및 sampled-state optimization보다 우수한가?

### RQ5. 설명 가능성

어떤 feature가 heuristic value와 search reduction에 기여하며, 그 기여를 사람이 이해할 수 있는 symbolic explanation으로 제시할 수 있는가?

### RQ6. 모델 규모

0.5B, 1B, 1.5B, 2B 모델의 feature 품질과 탐색 효율 사이에 어떤 scaling behavior가 나타나는가?

## 7. 실험 설계 초안

### 7.1 비교 방법

- Blind search 또는 uniform-cost search
- 표준 admissible heuristic: `h_max`, LM-cut, pattern database 등 적용 가능한 기준선
- 기존 unary potential heuristic
- 기존 binary 또는 higher-dimensional potential heuristic
- Random feature selection
- Frequency-based feature selection
- Causal graph 또는 mutex 기반 feature selection
- LLM이 heuristic 값을 직접 예측하는 방식
- LLM이 생성한 Python heuristic 방식
- 제안 방식: SLM feature proposal + LP potential heuristic
- 제안 방식과 기존 heuristic의 `max` 결합

서로 admissible한 heuristic의 `max`는 admissibility를 유지하므로, 기존 강한 heuristic과의 결합도 평가할 수 있다.

### 7.2 평가 지표

- 해결한 problem 수
- Search node expansions
- Generated states
- Planning wall-clock time
- Peak memory
- Plan cost 및 optimality
- Heuristic evaluation time
- LLM 호출 횟수와 전처리 시간
- Feature 수와 차원
- Unseen problem size에 대한 generalization
- Feature ablation에 따른 node expansion 변화

### 7.3 데이터와 benchmark

- RoboCasa task를 변환한 PDDL planning problem
- 표준 IPC classical planning domain
- Training 문제보다 object 수와 plan horizon이 큰 OOD problem
- Domain-level split과 problem-level split을 구분

RoboCasa만 사용하면 domain 수가 좁아 generality 주장이 약해질 수 있으므로, IPC benchmark를 함께 사용하는 것이 바람직하다.

## 8. 설명 가능성 평가

Potential heuristic은 다음 세 수준으로 설명한다.

1. **구조적 설명:** 어떤 symbolic feature가 사용됐는가?
2. **수치적 설명:** 각 feature가 현재 heuristic value에 얼마나 기여했는가?
3. **경험적 설명:** 해당 feature를 제거했을 때 node expansion과 runtime이 얼마나 증가하는가?

예시:

```text
현재 상태 h(s) = 5.4
- cabinet-closed: +2.1
- bread-not-in-basket: +1.7
- basket-not-at-dining-counter: +1.6
```

가중치만 보여주는 것은 탐색 효율에 대한 완전한 인과 설명이 아니다. Leave-one-feature-out ablation과 feature별 search impact를 함께 보고해야 한다.

## 9. 주요 위험과 반론

### 9.1 왜 admissibility가 필요한가?

로봇 task planning에서는 최적 계획보다 빠른 satisficing plan이 더 중요할 수 있다. 따라서 action cost의 의미와 최적성 보장의 실질적 필요성을 제시해야 한다.

가능한 대응:

- 에너지, 시간, 위험 또는 action 수를 cost로 정의
- 동일한 framework의 optimal A*와 weighted A* 버전을 함께 평가
- 보장된 최적성과 빠른 satisficing search 사이의 trade-off 분석

### 9.2 Potential heuristic의 표현력이 충분한가?

Unary feature는 긴 상호작용과 ordering dependency를 포착하지 못할 수 있다. Binary/conjunctive feature까지 허용하되 feature 수 폭발을 SLM selection으로 제어해야 한다.

### 9.3 LLM이 없어도 가능한가?

SLM이 random 또는 구조 기반 selection보다 낫다는 것을 실험으로 입증해야 한다. 특히 동일 feature budget과 동일 LP objective를 사용한 공정한 비교가 필요하다.

### 9.4 Feature 생성 비용이 절감 효과보다 큰가?

LLM 전처리 시간까지 포함한 amortized cost를 보고해야 한다. Domain-level feature를 여러 problem에서 재사용할수록 제안 방식이 유리할 가능성이 있다.

### 9.5 부분 관측 환경과의 차이

Classical planning은 완전하고 정확한 symbolic state를 가정한다. 실제 로봇 환경 또는 RoboCasa observation에서 predicate를 얻는 perception/grounding 오류는 별도 문제다. 초기 연구에서는 다음 경계를 명확히 하는 것이 안전하다.

> 본 연구는 주어진 symbolic state가 정확하다는 조건에서 task-level search guidance를 평가한다.

추후 belief-state 또는 replanning으로 확장할 수 있다.

## 10. Introduction 논리 초안

1. LLM은 상식과 의미 지식을 활용해 로봇 task planning에서 그럴듯한 계획을 생성할 수 있다.
2. 그러나 direct generation은 긴 horizon과 복잡한 제약에서 유효성·최적성을 안정적으로 보장하지 못하며, 많은 연구가 큰 모델에 의존한다.
3. 반복 호출, self-correction, tree search 및 외부 validation은 신뢰성을 개선하지만, search 규모에 따라 LLM 비용과 지연이 증가하며 validator 자체는 completeness나 optimality를 보장하지 않는다.
4. Classical planning과 LLM을 결합하는 연구는 LLM을 formalizer, action proposer, heuristic evaluator 또는 heuristic program generator로 사용해 왔다.
5. 하지만 직접 예측한 heuristic은 admissibility가 보장되지 않을 수 있고, hard action pruning은 solution을 제거할 수 있으며, 반복적인 online guidance는 계산 비용이 크다.
6. 이를 해결하기 위해 본 연구는 SLM을 heuristic value predictor가 아니라 semantic feature proposer로 제한한다.
7. 제안 feature는 symbolic 검증 후 LP 기반 potential heuristic으로 컴파일되며, consistency와 admissibility를 만족한다.
8. LLM은 domain 또는 problem별 전처리 단계에서 한 번만 호출되고 runtime search에서는 호출되지 않는다.
9. Symbolic feature와 weight 구조를 통해 heuristic value의 근거와 search efficiency에 대한 feature별 기여를 분석할 수 있다.
10. RoboCasa 기반 task planning과 IPC benchmark에서 모델 크기, feature budget, search efficiency, optimality 및 OOD generalization을 평가한다.

## 11. 관련 연구 조사 우선순위

### 가장 가까운 연구

1. **Classical Planning with LLM-Generated Heuristics: Challenging the State of the Art with Python Code**  
   LLM이 domain-dependent Python heuristic을 생성하고 training task에서 선택한다. 제안 연구와 가장 직접적으로 비교해야 한다.

2. **Property-Guided LLM Program Synthesis for Planning**  
   반례 기반 property verification으로 LLM heuristic program을 개선한다. 본 연구의 admissibility 보장 및 LP projection과 차이를 명확히 해야 한다.

3. **Query-Efficient Planning with Language Models**  
   LLM을 heuristic과 action proposer로 사용하는 search framework와 반복 질의 비용을 다룬다.

4. **LLM+P: Empowering Large Language Models with Optimal Planning Proficiency**  
   LLM formalization과 classical planner의 결합이므로 “LLM + classical planning” 자체를 신규성으로 주장할 수 없다는 근거다.

5. **New Optimization Functions for Potential Heuristics**  
   Sampled reachable states, objective design 및 multiple potential heuristic 조합이 이미 연구됐다.

6. **Higher-Dimensional Potential Heuristics for Optimal Classical Planning**  
   Binary 또는 higher-dimensional feature가 필요한 이유와 계산 비용을 검토할 핵심 문헌이다.

### 추가로 조사할 주제

- Learned admissible heuristic
- Neural heuristic projection 또는 calibration
- Feature discovery for potential heuristics
- Pattern selection for pattern databases
- Cost partitioning과 learned abstraction
- Preferred operator와 completeness-preserving search control
- Robot task planning에서 optimality가 필요한 cost model
- Small language model의 planning 및 program synthesis 능력

## 12. 현재 단계의 결론

연구 방향은 가능성이 있지만, 신규성은 단순한 “LLM과 potential heuristic의 결합”에서 나오지 않는다. 논문의 핵심은 다음 세 요소의 동시 달성에 있어야 한다.

1. 2B 이하 SLM이 작은 feature budget으로 의미 있는 domain feature를 제안한다.
2. Symbolic LP compiler가 모델 출력과 무관하게 admissibility와 consistency를 보장한다.
3. Runtime에는 LLM을 호출하지 않으면서 기존 feature-selection 기준선보다 search effort를 유의미하게 줄인다.

다음 토론에서는 먼저 **왜 RoboCasa 작업에서 optimal planning과 admissibility가 필요한지**, 그리고 **LLM이 제안할 feature의 정확한 문법과 범위가 무엇인지**를 결정해야 한다.

## 참고 문헌 링크

- LLM+P: https://arxiv.org/abs/2304.11477
- Query-Efficient Planning with Language Models: https://arxiv.org/abs/2412.06162
- Classical Planning with LLM-Generated Heuristics: https://arxiv.org/abs/2503.18809
- Property-Guided LLM Program Synthesis for Planning: https://arxiv.org/abs/2605.16142
- New Optimization Functions for Potential Heuristics: https://doi.org/10.1609/icaps.v25i1.13714
- Higher-Dimensional Potential Heuristics for Optimal Classical Planning: https://ojs.aaai.org/index.php/AAAI/article/download/11023/10882
- VOLTS: https://proceedings.mlr.press/v318/massad26a.html
