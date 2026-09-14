# Changmin Robot Planning Benchmark

로봇 계획 연구에 사용할 6개 기본 도메인과 Logistics·Barman의 단계별 통제
벤치마크를 한곳에 모은 독립 벤치마크 스위트다.
기존 `benchmarks/`는 수정하지 않는다. 이 폴더의 PDDL은 실제 robot skill에 대응하는
discrete action과 물체별 numeric resource가 결합된, 약하게 현실적인 task-planning
문제로 발전시킨다. Motion planning, perception과 stochastic execution은 아직
포함하지 않는다.

## 구성

| 순서 | 디렉터리 | 핵심 계획 요소 | 현재 상태 |
| ---: | --- | --- | --- |
| 1 | `01_blocksworld` | 파지, 적층, 작업 순서 | Classical domain 및 4개 instance 준비 |
| 2 | `02_logistics` | 실행시간 최소화 + 화물·연료·예산·경로 제약 | Numeric domain 및 검증된 instance 1개 |
| 3 | `03_books` | 실행시간 최소화 + cart/shelf·순서·높이 제약 | Numeric-gated symbolic domain 및 검증된 instance 1개 |
| 4 | `04_watering` | 식물별 demand, 물의 양, 배터리, 용기 용량 | Numeric domain 및 검증된 instance 1개 |
| 5 | `05_barman` | 실행시간 최소화 + 양손·용량·재고·혼합·세척 | Numeric domain 및 4개 instance 준비 |
| 6 | `06_assembly` | 실행시간 최소화 + 선행관계·payload·공구·체결량 | Numeric domain 및 4개 instance 준비 |

Laboratory domain은 현재 연구 범위에서 제외했다. `07~22` 번호는 Logistics와
Barman의 numeric 구조를 단계적으로 분리하는 통제 벤치마크에 사용한다.

## 07~22: 단계별 numeric 통제 벤치마크

기존 `02_logistics`와 `05_barman`은 여러 numeric 구조가 결합된 종합 벤치마크다.
`07~22`는 결과의 원인을 찾기 위해 같은 symbolic problem에 numeric layer를 한 단계씩
추가하는 독립 benchmark family다.

| 단계 | Logistics | Barman | 추가되는 구조 |
| --- | --- | --- | --- |
| N0 | `07_logistics_n0` | `15_barman_n0` | Symbolic only |
| N1 | `08_logistics_n1` | `16_barman_n1` | 실행시간 objective only |
| N2 | `09_logistics_n2` | `17_barman_n2` | Local numeric gate |
| N3 | `10_logistics_n3` | `18_barman_n3` | Consumable resource |
| N4 | `11_logistics_n4` | `19_barman_n4` | Replenishable resource와 ordering |
| N5 | `12_logistics_n5` | `20_barman_n5` | Shared-resource competition과 coupling |
| N6 | `13_logistics_n6` | `21_barman_n6` | State-dependent numeric interaction |
| N7 | `14_logistics_n7` | `22_barman_n7` | N1~N6 full composition과 tight constraint |

### N0~N7의 의미

| 단계 | 정의 | 이 단계에서 묻는 질문 |
| --- | --- | --- |
| N0 | 위치, 소유, 적재, 손 점유, 청결, recipe 등의 symbolic predicate만 사용 | Numeric 없이도 어려운가? |
| N1 | 행동별 시간을 누적하고 최소화하지만 시간은 precondition에 사용하지 않음 | Cost-sensitive search만으로 성능이 달라지는가? |
| N2 | 현재 행동의 capacity 또는 volume만 검사 | Local numeric gate가 symbolic search를 방해하는가? |
| N3 | 행동에 따라 fuel, budget 또는 stock이 단방향으로 감소 | 누적 소비를 relaxation이 얼마나 과소평가하는가? |
| N4 | 감소한 자원을 특정 행동과 위치에서 복구 | 보충 필요성과 action ordering이 얼마나 손실되는가? |
| N5 | 여러 goal이 같은 자원을 경쟁하고 한 행동이 여러 fluent를 함께 변화 | Resource allocation과 coupling이 state ranking을 악화시키는가? |
| N6 | 현재 numeric 값에 따라 effect 또는 비용이 달라짐 | 고정 operator effect로 표현할 수 없는 interaction이 병목인가? |
| N7 | 앞 단계의 구조를 함께 활성화하고 resource slack을 줄임 | 개별 원인이 결합됐을 때 실제 종합 실패가 재현되는가? |

`N0~N6`은 원인을 분리하기 위한 단계이고 `N7`은 최종 stress test다. 따라서 N7의
성능 저하만으로 특정 원인을 주장하지 않고, 최초로 성능이 변한 단계와 직전 단계를
paired comparison으로 분석한다.

### 도메인별 구현 방향

| 단계 | Logistics | Barman |
| --- | --- | --- |
| N0 | Package·truck·driver의 이동과 적재 sequence | 양손·shot·shaker·recipe·cleaning sequence |
| N1 | `total-delivery-time` | `total-barman-time` |
| N2 | Package weight와 truck load/capacity | Shot/shaker volume과 container capacity |
| N3 | 보충 없이 감소하는 fuel 또는 budget | 보충 없이 감소하는 dispenser stock |
| N4 | Fuel station과 refuel action | Dispenser restock 또는 bottle 교체 action |
| N5 | Package가 truck capacity와 global budget을 공유하고 도로 선택이 fuel·time·budget을 결합 | 여러 order가 stock·shot·shaker를 공유하고 batching 여부가 비용을 변화 |
| N6 | 남은 fuel에 따라 주유량과 비용이 달라지는 fill-to-capacity effect | 현재 container volume에 따라 pour/fill 양이 달라지는 effect |
| N7 | 고속도로·국도, payload, fuel, budget, refuel을 tight하게 결합 | Volume, stock, restock, cleaning, batching과 두 손 제약을 tight하게 결합 |

### 통제 원칙

- 같은 `pNNN`끼리는 object 수, 초기 symbolic topology와 goal을 동일하게 유지한다.
- `N_k`와 `N_{k+1}` 사이에는 표에 명시된 numeric 구조만 추가한다.
- N 단계가 올라간다는 이유로 package, order, location 또는 recipe 수도 함께 늘리지 않는다.
- Resource slack은 단계 효과와 섞이지 않도록 기본 비교에서는 고정한다.
- 각 단계에서 parser 통과, solvability와 VAL-valid reference plan을 먼저 확보한다.
- Planning wall time, expanded nodes, heuristic value, plan length와 PDDL objective를 분리해 기록한다.
- N1의 time은 누적 objective이며 durative/temporal planning을 의미하지 않는다.

현재 `07~22`에는 N0~N7의 `domain.pddl`을 작성했다. 16개 domain은 VAL parser를
통과했다. Instance, problem generator와 단계별 reference plan은 아직 작성하지
않았다.

구현상 N7은 N6와 같은 전체 action schema를 사용한다. N7의 차이는 package/order 수를
늘리는 것이 아니라 이후 problem generator에서 fuel, budget, stock, capacity의 slack을
줄이는 데서 만든다. 따라서 N6→N7 비교는 domain 표현력 변화가 아니라 동일 표현에서의
constraint tightness 변화로 해석한다.

## 02, 03, 04, 05, 06의 공통 목적

`02_logistics`부터 `06_assembly`까지는 모두 **목표를 만족하는 plan의 예상
실행시간을 최소화**한다. 플래너가 해를 계산하는 데 걸린 wall-clock planning
time을 PDDL 목적함수로 삼는다는 뜻은 아니다. Planning time은 planner 성능을
비교하는 실험 측정값이고, PDDL metric은 로봇이 해당 plan을 실제로 수행하는 데
드는 누적시간이다.

- Logistics: `total-delivery-time` 최소화
- Books: `total-library-time` 최소화
- Watering: `total-watering-time` 최소화
- Barman: `total-barman-time` 최소화
- Assembly: `total-assembly-time` 최소화

다섯 도메인의 차이는 목적이 아니라 제약 구조다. Logistics는 연료·예산·적재량과
유료 고속도로/무료 국도의 경로 선택이 중심이고, Books는 서가 순서·카트 적재·책장
공간·높이와 발판 배치에 따른 작업 순서 및 묶음 운반이 중심이다. Watering은 물과
배터리의 동시 고갈 및 서로 다른 위치에서의 재급수·충전이 중심이다. Barman은
양손 점유·용기 청결·혼합 순서와 실제 액체 용량·유한 재고의 결합이 중심이다.
Assembly는 조립 선행관계·로봇 payload·공구 setup과 정확한 numeric 체결량의
결합이 중심이다.

## 출발 PDDL과 현재 변경 범위

- `01_blocksworld`: `benchmarks/03_BLOCKSWORLD`
- `02_logistics`: `benchmarks/01_LOGISTIC`에서 출발. `package-weight`,
  `truck-capacity/load`, `fuel-capacity/level`, `distance`, refuel을 추가했다.
  고속도로는 빠르지만 통행료가 들고 국도는 느리지만 무료다. 주유비와 통행료는
  초기 `budget`을 넘을 수 없으며, 목적함수는 `total-delivery-time` 최소화다.
- `03_books`: 소모성 feasibility 자원 없이 구성했다. `cart-load`, 책 두께에 따른
  `shelf-used-space`, 높이–reach가 action applicability를 제한하고, `next-to-fill`이
  잘못 꽂힌 책의 제거–임시 보관–순서 복원을 강제한다. 각 행동의 시간 비용을
  `total-library-time`에 누적하며 이를 최소화한다.
- `04_watering`: 물과 배터리를 서로 독립적으로 보충되는 numeric resource로
  모델링했다. 식물별 `plant-demand`, 수도·충전소 위치, 이동 에너지와 시간을
  결합하며 목적함수는 `total-watering-time` 최소화다.
- `05_barman`: 기존 양손·세척·혼합 sequence를 유지하면서 `liquid-volume`,
  `container-capacity`, `dispenser-stock`을 추가했다. 목적함수는
  `total-barman-time` 최소화다.
- `06_assembly`: ADL quantifier와 conditional effect 의존성을 줄이고 조립 forest,
  robot payload, tool compatibility와 bounded `completed-work`를 결합했다.
  목적함수는 `total-assembly-time` 최소화다.

## 현재 검증 상태

2026-09-11 기준 `02_logistics`부터 `06_assembly`까지 현재 p001은 VAL parser를
통과했다. 아래 길이는 현재 domain에서 얻은 first-plan smoke test 결과이며 최적성을
뜻하지 않는다.

| Domain | ENHSP 길이 | Metric-FF 길이 | Numeric 제약이 plan에 나타난 증거 |
|---|---:|---:|---|
| Blocksworld | 8 | 8 | 순수 symbolic delete-effect 대조군; 모든 action cost 1 |
| Logistics | 16 | 16 | 주유 1회가 필수이며 예산 8로 고속도로를 정확히 1구간만 선택 |
| Books | 32 | 22 | A120 제거–A110 삽입–A120 복원 및 high shelf step 사용 |
| Watering | 24 | 39 | 물과 배터리 보충을 식물 방문 사이에 배치 |
| Barman | — | 32 | shot 재사용·세척, shaker 혼합, 유한 dispenser stock 적용 |
| Assembly | 37 | 35 | payload gate, 공구 교체와 정확한 체결 작업량 적용 |

각 도메인의 p002~p004 및 난이도 축은 해당 디렉터리 README에 기록한다.

### Logistics 예산 반증 검사

`p001`에서 예산 값만 임시로 바꿔 ENHSP로 검사한 결과다. 예산 4에서는 필수 주유비
5를 낼 수 없어 해가 없고, 예산이 늘수록 고속도로를 더 사용하여 배송 시간이 감소한다.

| 초기 budget | 결과 | 최소화된 배송 시간 |
|---:|---|---:|
| 4 | unsolvable | - |
| 7 | solved; 고속도로 0구간 | 64 |
| 8 | solved; 고속도로 1구간 | 59 |
| 11 | solved; 고속도로 2구간 | 54 |
