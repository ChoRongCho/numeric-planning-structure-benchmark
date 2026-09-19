# 방법론을 열어 둔 로봇 Numeric Planning 문제 정의

## 1. 현재 입장

아직 LLM, anytime portfolio, LP, RPG 보강, abstraction 중 어느 하나를 연구 방법으로
확정하지 않는다. 지금까지의 실험이 직접 지지하는 것은 특정 해법이 아니라 다음
현상이다.

> 많은 numeric planning 문제에서 실패할 행동열도 초반에는 실행 가능해 보인다.
> 수치 자원의 부족이나 충돌은 여러 action을 수행한 뒤에야 드러나며, 기존
> 휴리스틱이 이 사실을 현재 상태에 충분히 전파하지 못하면 탐색량이 급격히 커진다.

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

## 3. 문제의 조작적 정의

### 3.1 Delayed numeric conflict

현재 상태에서는 적용 가능한 action이 존재하고 relaxed goal도 도달 가능해 보이지만,
그 action을 포함한 일부 행동열이 미래의 누적 자원 부족, 보충 위치, 용량, assignment
또는 여러 자원의 결합 때문에 실패하는 상황을 **delayed numeric conflict**라고 부른다.

예시는 다음과 같다.

- Barman: 초반 fill은 가능하지만 마지막 주문에 필요한 stock이 부족함
- Watering: 식물 방문은 가능하지만 물과 배터리를 함께 고려하면 tour 후반이 불가능함
- Logistics: 개별 도로는 통과할 수 있지만 전체 배송 경로의 연료와 예산이 부족함

### 3.2 Failure revelation depth

잘못된 선택을 한 시점부터 그 선택이 실제 dead end로 판명되는 시점까지 필요한 최소
action 수 또는 relaxed-plan layer 수를 **failure revelation depth**로 둔다. 이 값이
클수록 forward search는 실패하는 경로를 더 오래 유지할 가능성이 있다.

### 3.3 Feasibility ambiguity

현재의 symbolic·numeric 정보만으로 성공 경로와 실패 경로가 얼마나 비슷하게
보이는지를 **feasibility ambiguity**라고 둔다. 다음 경우 ambiguity가 높을 수 있다.

- 많은 action이 현재 numeric precondition을 통과함
- 성공과 실패 행동열의 초반 prefix가 김
- 자원을 공유하는 목표가 많음
- 보충 가능 여부가 위치와 순서에 의존함
- relaxation에서 감소, 용기 점유, ordering 또는 변수 간 상관관계가 사라짐

정확한 지표는 아직 확정하지 않는다. 적용 가능한 action 수, 첫 충돌 layer, 자원
slack, 공유 목표 수와 relaxed plan의 실제 실행 가능 비율 등을 후보로 둔다.

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

## 5. 연구 문제

첫 연구 범위는 deterministic sequential numeric PDDL로 제한한다. `increase`,
`decrease`, `assign`, 선형 numeric precondition과 static fluent가 들어간 effect를
포함하되, 연속 변화, 외생 event와 임의의 비선형 식은 후속 범위로 둔다. 목표는
optimality 증명보다 제한시간 안의 valid first plan과 그 실행비용이다.

현재의 중심 문제는 다음과 같이 정의한다.

> **일반적인 numeric effect를 포함한 로봇 planning에서, 긴 행동열 뒤에 드러나는
> 수치적 불가능성과 비용을 현재 상태의 휴리스틱에 낮은 계산비용으로 반영하여,
> 빠른 첫 valid plan과 효과적인 탐색을 함께 달성할 수 있는가?**

영문 초안은 다음과 같다.

> **How can heuristic search for robotic numeric planning anticipate delayed numeric
> infeasibility and cost while retaining broad numeric expressiveness and low first-plan
> latency?**

이 문제 정의는 해결 수단을 포함하지 않는다. LLM을 사용하지 않아도 되고, 하나의
새 휴리스틱 대신 기존 방법의 조합으로 해결해도 된다.

## 6. 세부 연구 질문

### RQ1. 어떤 구조가 delayed numeric conflict를 만드는가?

Domain–problem pair의 자원 slack, 보충 가능성, 위치 의존성, 목표 간 자원 공유와
horizon이 failure revelation depth와 탐색량을 얼마나 설명하는가?

### RQ2. 기존 휴리스틱은 어느 정보를 잃어서 실패하는가?

각 휴리스틱이 decrease, ordering, numeric–symbolic correlation과 objective 정보를
어디서 제거하며, 그 손실이 dead-end 인식 시점과 plan quality에 어떤 영향을 주는가?

### RQ3. 미래 제약을 어느 정도까지 계산해야 이득인가?

총수요 lower bound, interval, 작은 LP, landmark, abstraction, bounded lookahead처럼
강도가 다른 추론에서 추가 계산비용보다 pruning 이득이 커지는 조건은 무엇인가?

### RQ4. 이득이 새로운 domain과 problem에도 유지되는가?

특정 benchmark에 맞춘 규칙이 아니라, 보지 못한 자원 구조와 problem 크기에서도
coverage, first-plan latency 또는 objective를 개선하는가?

## 7. 해결 방법에 요구되는 조건

최종 방법이 무엇이든 다음 조건으로 평가한다.

| 요구사항 | 평가 질문 |
|---|---|
| 조기 감지 | 실제 충돌보다 몇 action/layer 앞에서 위험을 구분하는가? |
| 낮은 overhead | 휴리스틱 계산 증가보다 확장 감소가 큰가? |
| 넓은 표현 범위 | decrease, refill, recharge, assignment와 fluent-dependent effect를 어디까지 지원하는가? |
| 상관관계 보존 | 위치·순서·여러 자원의 결합 중 무엇을 유지하는가? |
| 빠른 첫 plan | 주어진 짧은 시간 안의 valid-plan coverage가 유지되는가? |
| plan quality | 같은 시간에 더 낮은 objective의 plan을 찾는가? |
| 일반화 | 보지 못한 domain과 더 긴 horizon에서도 효과가 유지되는가? |

모든 조건을 완벽히 만족할 필요는 없다. 대신 어느 정보를 얼마의 비용으로 추가했고,
그 결과 어떤 문제군에서 이득과 손해가 발생하는지 명시해야 한다.

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

이 실험 뒤에 가장 작은 정보 추가로 반복적인 delayed conflict를 제거하는 방법을
우선 구현한다. 결과가 지지하지 않으면 다른 후보로 바꾼다.

## 10. 현재 단계의 결론

연구 대상은 특정 planner나 휴리스틱의 교체가 아니다. 현재까지 확인된 대상은
**forward search가 미래의 수치적 실패를 늦게 발견하는 현상**이다. 기존 방법들은
속도, 강한 수치 추론, 표현 범위, 상관관계 보존 중 일부에는 강하지만 네 요소를 함께
만족하지 못했다. 다음 단계는 해결책을 확정하는 일이 아니라 이 정보 손실과 실패
시점을 계측하여, 어떤 추론을 추가할 때 실제 탐색 이득이 생기는지 확인하는 일이다.
