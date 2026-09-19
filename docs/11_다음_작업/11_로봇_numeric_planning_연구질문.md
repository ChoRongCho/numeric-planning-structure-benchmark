# 로봇 Numeric Planning을 위한 적응형 휴리스틱 연구 방향

## 1. 연구 배경

로봇이 실제 환경에서 작업하려면 이동 경로만 정하는 것으로는 부족하다. 배터리,
연료, 시간, 적재량, 물과 같은 수치 자원을 함께 고려해야 한다. 이런 문제는
numeric planning으로 표현할 수 있다.

로봇 planning에서는 두 가지 요구가 동시에 존재한다. 첫째, 로봇이 사용할 수 있는
실행 가능한 plan을 빨리 찾아야 한다. 둘째, 찾은 plan이 불필요한 이동이나 자원
사용을 너무 많이 포함하지 않아야 한다. 즉, **빠른 첫 plan**과 **낮은 실행비용**이
모두 중요하다.

본 연구의 실험에서는 이 두 목표 사이의 차이가 명확하게 드러났다. Metric-FF와 같은
relaxed-plan 기반 planner는 대부분의 문제에서 매우 빨리 plan을 찾았다. 반면
수치 자원의 변화를 더 자세히 계산하는 휴리스틱은 plan을 찾았을 때 더 낮은
objective를 얻는 경우가 있었지만, 탐색이 오래 걸리거나 timeout이 발생했다.

이 결과는 특정 휴리스틱 하나를 모든 로봇 문제에 적용하는 방식에 한계가 있음을
보여 준다. 휴리스틱이 다루는 수치 정보와 실제 도메인의 자원 구조가 잘 맞을 때는
성능이 좋지만, 그렇지 않으면 탐색이 크게 늘어날 수 있다.

## 2. 사전 실험에서 발견한 현상

전체 실험 결과는
[p000~p004 최종 결과표](./09_p000-p004_최종결과_표.md)에 정리했다. 그중 본 연구 방향과
직접 연결되는 결과는 다음과 같다.

### 2.1 빠른 relaxed-plan 계열

Metric-FF `numeric-hff`는 30개 문제를 모두 풀었고 valid plan 생성 시간의 중앙값은
0.227초였다. Count Downward Agile `irhff`도 30개 중 28개를 풀었다. 이들은
문제를 단순화한 relaxed plan을 만들어 탐색의 길잡이로 사용한다.

이 방식은 놀은 coverage와 빠른 속도를 보였다. 하지만 자원 경쟁이 심한 문제에서는
plan objective가 높아지기도 했다. Metric-FF가 찾은 Logistics p004 plan의 objective는
774였으며, 같은 문제의 관측 최저값은 196이었다. Watering p004에서도 Metric-FF는
0.225초 만에 plan을 찾았지만 objective는 관측 최저값보다 59.0% 높았다.

따라서 relaxed-plan 방식은 **일단 plan을 찾는 능력**은 뛰어나지만, 모든 도메인에서
**실행비용이 낮은 plan을 찾는 능력**까지 보장하지는 않았다.

### 2.2 수치 정보를 더 많이 사용하는 계열

NFD `irhadd`와 ENHSP `hadd`, `hradd`는 행동 반복, 수치 목표까지의 비용 등을
더 적극적으로 사용한다. 이들은 성공한 문제에서 상대적으로 좋은 objective를
얻는 경우가 많았다. 예를 들어 NFD `irhadd`는 Logistics p004에서 0.855초 만에
관측 최저값보다 5.6% 높은 plan을 찾았다. ENHSP `hadd`와 `hradd`는 같은 문제에서
관측 최저 objective 196을 찾았다.

그러나 NFD `irhadd`는 30개 중 3개에서 timeout됐고, ENHSP `hadd`와 `hradd`는 각각
5개에서 timeout됐다. 수치 정보를 더 많이 반영한다고 해서 항상 좋은 것은
아니었다.

### 2.3 도메인과 휴리스틱의 구조적 궁합

Logistics p004에서 NFD `irhadd`는 582개 상태만 확장하고 plan을 찾았다. 여러
package를 각각 배송하는 구조와 하위 목표의 비용을 더하는 `irhadd`의 방식이 잘
맞았던 것으로 해석할 수 있다.

반면 Watering p004에서는 6,937,821개 상태를 확장하고도 300초 안에 plan을
찾지 못했다. Watering에서는 위치, 물, 배터리, 충전 장소와 급수 장소가 함께
엮혀 있다. Interval 기반 추정은 물과 배터리를 각각 다시 보충할 수 있다는 사실은
알 수 있지만, 현재 위치에서 남은 두 자원으로 특정 경로를 실제로 수행할 수
있는지를 충분히 표현하지 못한다.

이 결과는 다음 해석으로 요약할 수 있다.

> 휴리스틱의 성능은 수치 정보를 얼마나 많이 계산하는지만으로 결정되지 않는다.
> 휴리스틱이 가정하는 문제 구조와 실제 도메인의 자원 구조가 얼마나 잘
> 맞는지가 중요하다.

## 3. 연구 문제 정의

본 연구가 다루려는 문제는 다음과 같다.

> **로봇 numeric planning 도메인의 자원 구조에 따라 휴리스틱 전략을 조정하여,
> 실행 가능한 첫 plan을 빠르게 확보하고 주어진 시간 안에 plan quality를 개선할 수
> 있는가?**

영문 연구 질문은 다음과 같이 표현할 수 있다.

> **How can a numeric planner rapidly obtain an executable first plan and subsequently
> improve its quality by adapting its heuristic strategy to the resource structure of
> a robotic planning domain?**

이 질문은 일반적인 "가장 좋은 휴리스틱은 무엇인가?"보다 더 적합하다. 실험에서
단일 휴리스틱이 모든 도메인과 모든 평가 축에서 항상 우수하지는 않았기 때문이다.

## 4. 세부 연구 질문

6개 benchmark의 domain–problem 구조를 이 질문에 맞춰 분석한 결과는
[Changmin Benchmark 도메인·문제 구조 분석](./12_changmin_benchmark_도메인_문제_구조_분석.md)에
정리했다.
Watering·Logistics의 핵심 자원을 독립적으로 변경한 첫 검증 결과는
[2×2 통제 실험 보고서](./13_수치자원_2x2_통제실험_결과.md)에 정리했다.

### RQ1. 도메인의 어떤 특성이 휴리스틱 성능을 결정하는가?

> 수치 planning 도메인의 구조적 특성만으로 relaxed-plan, interval, additive,
> abstraction 휴리스틱의 성능을 예측할 수 있는가?

분석 후보로는 다음과 같은 특성을 고려할 수 있다.

- 수치 변수의 수
- 수치 변수를 증가·감소·대입하는 action의 수
- 소모성 자원과 보충 가능한 자원의 수
- 하나의 action이 동시에 변경하는 수치 변수의 수
- symbolic 조건과 수치 조건이 연결된 정도
- 여러 목표가 하나의 자원을 공유하거나 경쟁하는 정도
- 충전소나 급수지처럼 자원 보충 장소가 제한되는지 여부
- 탐색에서 사용하는 action cost와 PDDL objective의 일치 정도

### RQ2. 휴리스틱 선택과 전환이 고정 휴리스틱보다 좋은가?

> 도메인의 구조적 특성을 이용해 휴리스틱을 선택하거나 탐색 중에 전환하면,
> 하나의 고정 휴리스틱보다 coverage와 plan quality를 함께 개선할 수 있는가?

이 질문은 빠른 휴리스틱과 정밀한 휴리스틱 중 하나만 고르는 대신, 두 방법의
장점을 시간에 따라 사용할 수 있는지를 묻는다.

### RQ3. LLM이 추출한 도메인 지식이 새로운 도메인에도 일반화되는가?

> LLM이 PDDL에서 추출한 자원 관계와 보조 수치 조건을 사용하면, 수작업 규칙이나
> 전통적인 특징 추출 방식보다 보지 못한 로봇 도메인에서 잘 일반화되는가?

LLM의 필요성은 고정 휴리스틱, 수작업 규칙 기반 선택기, 일반적인 머신러닝 선택기,
단순 portfolio와의 비교를 통해 검증해야 한다.

## 5. 해결 방법 후보

### 5.1 LLM 기반 휴리스틱 선택

LLM이 PDDL domain과 problem을 읽고 적합한 planner–heuristic 구성을 선택하게 할 수
있다. 단, LLM이 planner 이름만 직접 고르게 하면 선택 이유를 검증하기 어렵다.
먼저 도메인의 자원 구조를 정형화한 중간 표현으로 출력하게 하는 방식이 적합하다.

```json
{
  "replenishable_resources": ["water", "battery"],
  "jointly_consumed_resources": [["water", "battery"]],
  "location_dependent_replenishment": true,
  "goal_resource_competition": "high",
  "recommended_strategy": "fast-first-then-resource-aware"
}
```

이 중간 표현을 규칙 기반 또는 학습 기반 선택기에 입력하면, LLM의 설명 능력과
planner의 결정적 실행을 분리할 수 있다.

### 5.2 LLM 기반 휴리스틱 구성

LLM이 매 문제마다 새로운 planner 코드를 작성하게 하면 정확성과 재현성을 확보하기
어렵다. 대신 기존 휴리스틱에 넣을 도메인 지식을 생성하게 하는 방식을 고려할 수
있다.

- 휴리스틱 파라미터 선택
- redundant numeric constraint 생성
- 자원 간 결합을 나타내는 보조 변수 생성
- numeric PDB의 pattern과 abstraction 후보 생성
- 여러 휴리스틱의 가중치와 시간 배분 결정
- search configuration 생성

특히 Watering p004에서 ENHSP `hadd`는 timeout됐지만 `hradd`는 0.871초 만에 관측
최저 objective를 찾았다. 이 결과는 도메인에 필요한 redundant numeric constraint를
자동으로 발견하는 방향의 가능성을 보여 준다.

### 5.3 Cost partitioning과 numeric abstraction

Cost partitioning은 여러 하위 문제가 같은 action cost를 중복해 사용하지 않도록 비용을
나누는 방식이다. Numeric PDB나 domain abstraction과 결합하면 plan quality를 위한
강한 추정값을 만들 수 있다.

현재 실험에서 numeric PDB와 cost-partitioning 계열은 큰 문제에서 메모리를 많이
사용했다. 따라서 모든 pattern을 사용하기보다 로봇 자원 구조와 관련된 작은
abstraction을 선택하는 방향이 필요하다. LLM은 어떤 변수를 하나의 abstraction으로
묶을지, 어떤 pattern을 제외할지를 제안하는 역할을 할 수 있다.

### 5.4 Relaxed planning graph 개선

Metric-FF의 높은 coverage와 빠른 계산을 유지하면서, 로봇 자원의 핵심 정보만
추가하는 방향이다. 모든 자원 상태를 정확하게 계산하는 대신 다음과 같은 lower
bound를 사용할 수 있다.

- 남은 작업을 위한 최소 자원 수요
- 필수 보충 횟수의 lower bound
- 보충 장소까지의 최소 이동비용
- 동시에 감소하는 자원 쌍
- 여러 목표가 공유하는 자원의 총수요
- 현재 자원으로 처리할 수 있는 목표 수

Watering의 경우 남은 총 물 수요와 현재 물의 차이로 최소 급수 횟수를 계산하고,
남은 이동과 급수에 필요한 배터리로 최소 충전 횟수를 추정할 수 있다. 정확한 경로를
미리 계산하지 않아도 단순 relaxed plan보다 강한 탐색 신호를 제공할 수 있다.

### 5.5 `irhff`·`irhadd`의 coverage 개선

`irhadd`가 실패하는 원인을 휴리스틱 계산 비용, plateau, 메모리 사용, 오류가
큰 추정 중 어느 것인지 먼저 분리해야 한다. Watering p004의 경우에는 유망해 보이는
상태가 너무 많이 생기는 plateau가 주요 문제로 보인다.

개선 방법으로는 다음을 고려할 수 있다.

- relaxed-plan preferred operator 활용
- relaxed plan과 `irhadd`를 함께 사용하는 다중 휴리스틱 탐색
- 자원 부족량을 보조 휴리스틱으로 사용
- 빠른 planner가 찾은 plan을 objective upper bound로 사용
- 탐색이 정체되면 다른 휴리스틱으로 전환
- 여러 open list를 두고 서로 다른 평가값에 따라 번갈아 확장

## 6. 제안하는 핵심 접근: 자원 구조 기반 anytime planning

현재 결과에서 가장 자연스러운 해결 방식은 하나의 휴리스틱으로 모든 목표를 달성하려
하기보다, 탐색 시간에 따라 휴리스틱의 역할을 나누는 것이다.

1. Metric-FF 또는 `irhff`로 실행 가능한 첫 plan을 빠르게 찾는다.
2. 첫 plan의 objective를 현재 upper bound로 저장한다.
3. `irhadd`, LM-cut, numeric abstraction 또는 cost partitioning 기반 탐색을 실행한다.
4. 현재 plan보다 objective가 낮은 plan을 찾으면 바꾼다.
5. 시간 제한이 되면 그때까지 찾은 가장 좋은 plan을 반환한다.

```mermaid
flowchart LR
    A[PDDL 도메인·문제] --> B[자원 구조 분석]
    B --> C[빠른 relaxed-plan 탐색]
    C --> D[첫 valid plan]
    D --> E[Objective upper bound]
    B --> F[Numeric-aware 휴리스틱 선택]
    E --> F
    F --> G[더 낮은 비용의 plan 탐색]
    G --> H[주어진 시간의 best plan]
```

이 방식은 로봇 시스템의 운용 요구와도 맞는다. 당장 사용할 수 있는 plan을 먼저
확보하고, 로봇이 실행을 시작하기 전까지 남은 시간을 plan 개선에 사용할 수 있다.

## 7. 평가 방법

### 7.1 평가 축

이 연구에서는 planner의 성능을 하나의 값으로 합치지 않고 다음 축으로 나누어
평가해야 한다.

| 평가 축 | 질문 |
| --- | --- |
| First-plan latency | 언제 처음 valid plan을 찾았는가? |
| Coverage | 제한 시간 안에 valid plan을 찾았는가? |
| Plan objective | 찾은 plan의 실행비용은 얼마인가? |
| Improvement rate | 시간이 더 주어졌을 때 plan이 얼마나 빨리 좋아지는가? |
| Search effort | 상태 확장, 생성, 재열기 횟수와 메모리 사용량은 얼마인가? |
| Generalization | 새로운 도메인과 문제 크기에서도 작동하는가? |

### 7.2 시간에 따른 plan quality

로봇 planning에서 "그럴듯한 plan을 빨리 찾는다"는 목표를 평가하려면 최종
objective만 보면 안 된다. 시간 (t)까지 찾은 가장 좋은 plan의 비용을 다음과 같이
정의할 수 있다.

$$
Q(t)=
\begin{cases}
\infty, & t\text{까지 valid plan이 없는 경우} \\
J(\pi_t), & t\text{까지 찾은 가장 좋은 plan의 비용}
\end{cases}
$$

0.1초, 1초, 10초, 60초, 300초 시점의 (Q(t))를 기록하면 빠른 relaxed-plan 방식과
느리지만 정밀한 numeric-aware 방식을 같은 틀에서 비교할 수 있다. 최종 비교에서는
시간–품질 곡선의 area under the curve도 함께 사용할 수 있다.

### 7.3 필수 baseline

제안 방법의 효과를 알기 위해 다음 baseline과 비교해야 한다.

- Metric-FF `numeric-hff` 단일 실행
- Count Downward `irhff` 단일 실행
- NFD `irhadd` 단일 실행
- ENHSP `hadd`, `hradd` 단일 실행
- 모든 planner에 동일한 시간을 나누는 단순 portfolio
- 수작업 규칙 기반 휴리스틱 선택기
- 전통적인 특징 기반 머신러닝 선택기
- LLM 기반 선택기
- 빠른 첫 plan 후 numeric-aware 탐색을 수행하는 anytime 방법

LLM 기반 방법은 단순 portfolio나 작은 규칙 기반 선택기보다 좋은 결과를 보여야 그
복잡도를 정당화할 수 있다.

## 8. 단계별 연구 계획

### 1단계: 휴리스틱 적합성 분석

PDDL에서 자원과 action의 관계를 추출하고, 각 특징이 planner의 coverage, 탐색량,
objective와 어떻게 연결되는지 분석한다. 이 단계에서 RQ1을 먼저 다룬다.

### 2단계: 빠른 첫 plan과 plan 개선의 결합

Metric-FF나 `irhff`로 첫 plan을 찾고, 이를 upper bound로 사용하여 numeric-aware 탐색을
진행하는 anytime prototype을 구현한다. 고정 휴리스틱과 단순 portfolio를 먼저
비교한다.

### 3단계: LLM 기반 도메인 지식 생성

LLM이 자원 관계, redundant numeric constraint, abstraction pattern과 휴리스틱 시간 배분을
생성하게 한다. 이 정보가 새로운 도메인에서도 유용한지를 수작업 및 학습 기반
방법과 비교한다.

## 9. 예상 기여

이 연구가 목표로 하는 기여는 다음과 같다.

1. 로봇 numeric planning에서 휴리스틱 성능을 결정하는 자원 구조 특징을 정리한다.
2. 빠른 첫 plan과 낮은 최종 objective를 함께 고려하는 anytime numeric planning 방법을
   제안한다.
3. 고정된 휴리스틱이 아니라 도메인 구조에 따라 선택·전환되는 적응형 탐색
   구조를 검증한다.
4. LLM을 planner 대체제가 아닌 도메인 구조 분석과 휴리스틱 구성 도구로 사용할
   수 있는지 평가한다.

## 10. 현재 결론과 다음 검증 과제

현재 실험만으로 relaxed-plan, interval, cost partitioning 중 하나가 로봇 numeric
planning의 일반적인 해답이라고 결론낼 수는 없다. 확인된 사실은 휴리스틱별로
속도, coverage, plan quality 사이에 다른 장단점이 있으며, 도메인의 자원 구조에
따라 성능 순위가 바뀐다는 것이다.

다음 단계에서는 다음을 우선 검증해야 한다.

1. 로봇 도메인의 자원 결합도를 정량화할 수 있는가?
2. 빠른 첫 plan을 upper bound로 제공했을 때 numeric-aware 탐색이 실제로 빨라지는가?
3. 휴리스틱 선택보다 탐색 중 전환이 더 효과적인가?
4. LLM 없이 규칙 기반 접근만으로 어느 정도까지 해결할 수 있는가?
5. LLM이 추가로 제공하는 정보가 보지 못한 도메인에서도 실질적인 이득을 주는가?

이 검증을 통해 수단을 먼저 정한 연구가 아니라, 빠른 반응과 자원 효율이 모두 필요한
로봇 planning 문제를 해결하기 위해 적합한 휴리스틱 전략을 찾는 연구로 범위를
구체화할 수 있다.
