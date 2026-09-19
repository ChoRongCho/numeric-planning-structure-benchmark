# Changmin Benchmark 도메인·문제 구조 분석

## 1. 분석 목적

이 문서는 `changmin_benchmark` 안의 6개 활성 도메인을 같은 기준으로 분석한다.
목적은 각 도메인에서 어떤 구조가 휴리스틱에 유리하거나 불리한지 설명할 수 있는
특징을 만드는 것이다.

분석 대상은 다음과 같다.

| 번호 | 도메인 | 주요 로봇 작업 |
| ---: | --- | --- |
| 01 | Blocksworld | 파지, 이동, 적층 |
| 02 | Logistics | 화물 운송, 차량 운전, 주유, 경로 선택 |
| 03 | Books | 도서 운반, 임시 보관, 서가 순서 복원 |
| 04 | Watering | 식물 급수, 물 보충, 배터리 충전, 순회 경로 선택 |
| 05 | Barman | 용기 조작, 재료 분배, 혼합, 세척, 주문 처리 |
| 06 | Assembly | 부품 배치, 공구 교체, 체결, 검사 |

분석에 사용한 원본은 각 도메인의 `domain.pddl`, `instances/p000~p004.pddl`,
생성기와 README다.

| Domain | PDDL | Problem 설계·요약 |
| --- | --- | --- |
| Blocksworld | [`domain.pddl`](../../changmin_benchmark/01_blocksworld/domain.pddl) | [`README.md`](../../changmin_benchmark/01_blocksworld/README.md) |
| Logistics | [`domain.pddl`](../../changmin_benchmark/02_logistics/domain.pddl) | [`README.md`](../../changmin_benchmark/02_logistics/README.md) |
| Books | [`domain.pddl`](../../changmin_benchmark/03_books/domain.pddl) | [`README.md`](../../changmin_benchmark/03_books/README.md) |
| Watering | [`domain.pddl`](../../changmin_benchmark/04_watering/domain.pddl) | [`README.md`](../../changmin_benchmark/04_watering/README.md) |
| Barman | [`domain.pddl`](../../changmin_benchmark/05_barman/domain.pddl) | [`README.md`](../../changmin_benchmark/05_barman/README.md) |
| Assembly | [`domain.pddl`](../../changmin_benchmark/06_assembly/domain.pddl) | [`README.md`](../../changmin_benchmark/06_assembly/README.md) |

`p000`은 도메인의 핵심 action 하나를 확인하는 최소 smoke problem이다. 반면
`p001~p004`는 객체 수, 목표 수, 자원 여유도를 늘리거나 줄이며 난이도를 높인
본 실험군이다. 따라서 `p000`을 나머지 문제와 같은 난이도 스케일의 첫 점으로
해석하면 안 된다.

## 2. 분석 기준

각 도메인에서 다음 항목을 확인했다.

1. **Symbolic 구조:** 위치, 파지, 순서, 공구 점유와 같은 predicate 관계
2. **Numeric gate:** 현재 수치가 조건을 만족해야 action을 실행할 수 있는 구조
3. **자원 유형:** 소모되는지, 보충할 수 있는지, 다른 목표와 공유하는지
4. **상관관계:** 하나의 action이 여러 symbolic/numeric 상태를 함께 바꾸는지
5. **복구와 위치:** 자원을 어디서, 어떤 순서로 다시 얻을 수 있는지
6. **목표 의존성:** 여러 목표를 독립적으로 풀 수 있는지, 먼저 한 선택이 다음 목표에
   영향을 주는지
7. **Objective:** 실행 가능성을 제한하는 자원과 plan 실행비용의 관계

이 문서의 `낮음·중간·높음` 판정은 PDDL 구조를 비교하기 위한 정성적 분류다.
실험으로 학습한 가중치나 성능 점수가 아니다.

## 3. 전체 구조 비교

| Domain | Numeric feasibility | 주요 자원 | 보충 | 목표 경쟁 | 위치–자원 결합 | 주요 난점 |
| --- | --- | --- | --- | --- | --- | --- |
| Blocksworld | 없음 | 없음 | 없음 | symbolic hand/table 공유 | 없음 | delete effect와 적층 순서 |
| Logistics | 있음 | fuel, budget, truck load | fuel만 주유소에서 복구 | package들이 truck·fuel·budget 공유 | 높음 | 경로·연료·예산·배송 순서 |
| Books | 있음 | cart load, shelf space, reach | 다 되돌릴 수 있음 | cart·서가·step 공유 | 중간 | 서가 순서 복원과 묶음 운반 |
| Watering | 있음 | water, battery | 서로 다른 서비스 위치에서 복구 | 모든 plant가 두 자원 공유 | 매우 높음 | 두 보충 자원과 방문 순서 |
| Barman | 있음 | liquid volume, finite stock | stock 복구 없음 | order들이 stock·shot·shaker·hand 공유 | 장소 개념 없음 | 재고와 긴 manipulation sequence의 결합 |
| Assembly | 있음 | payload gate, bounded work | 소모성 자원 없음 | part들이 robot·tool 공유 | 장소 개념 없음 | precedence·tool setup·정확한 work 조합 |

다섯 numeric domain은 모두 action 실행시간의 합을 최소화한다. 그러나 그 시간은
planner wall-clock이 아니라 로봇이 plan을 실행할 때의 예상 시간이다.

## 4. 01 Blocksworld

### 4.1 문제 구조

Blocksworld는 numeric 휴리스틱의 효과를 보기 위한 문제가 아니라, 순수 symbolic
대조군이다. 로봇은 그리퍼 하나로 block을 집고, 내려놓고, 다른 block 위에 쌓는다.

- 주요 predicate: `holding`, `handempty`, `clear`, `on`, `on-table`
- 공유 자원: 그리퍼 하나와 table 위의 빈 자리
- Numeric fluent: 모든 action에서 1씩 늘어나는 `total-cost`만 존재
- Objective: `total-cost` 최소화, 즉 plan length 최소화

어떤 block을 먼저 옮기면 그 아래 block을 옮기 위해 다시 옮겨야 할 수 있다. Delete
relaxation은 block을 집었을 때 `handempty`가 사라지는 것과 이전 위치가 사라지는 것을
약하게 반영한다. 따라서 numeric 자원 오차 없이 symbolic delete effect만으로 생기는
휴리스틱 오차를 측정할 수 있다.

### 4.2 Problem progression

| Problem | Blocks | Tables | Initial stacks | Goal stacks | 해석 |
| --- | ---: | ---: | ---: | ---: | --- |
| p000 | 1 | 1 | 1 | 0 | block 하나를 집는 smoke test |
| p001 | 3 | 3 | 1 | 1 | 작은 재적층 문제 |
| p002 | 5 | 3 | 2 | 2 | 두 stack 간 재배치 |
| p003 | 7 | 3 | 3 | 2 | 여러 stack을 풀어 큰 stack으로 합침 |
| p004 | 9 | 3 | 3 | 3 | 가장 많은 block과 재배치 조합 |

### 4.3 휴리스틱 연구에서의 역할

Blocksworld의 결과는 numeric-aware 기법이 단순 symbolic planning에 불필요한 비용을
추가하는지 확인하는 기준이 된다. 도메인 특징 선택기는 이 문제에서 numeric 자원
결합도를 매우 낮게 판정해야 한다.

## 5. 02 Logistics

### 5.1 문제 구조

Logistics는 package를 도보 또는 truck으로 목표 장소에 배송하는 문제다. Local
road는 느리지만 무료고 highway는 빠르지만 통행료를 소모한다.

| 구조 | Fluent 또는 predicate | 특성 |
| --- | --- | --- |
| Truck 적재 | `truck-load`, `truck-capacity`, `package-weight` | 적재는 load를 늘리고 하차는 줄임 |
| 연료 | `fuel-level`, `fuel-capacity` | 이동할 때 감소, 주유소에서 완전 복구 |
| 예산 | `budget` | 통행료와 주유비에 소모, 복구 불가 |
| 경로 선택 | `highway`, `local-road`, `walkable` | 시간·연료·예산 트레이드오프 |
| 실행시간 | `total-delivery-time` | 모든 action에서 증가하는 objective |

핵심 action인 `drive-highway`는 차량 위치를 바꾸면서 연료와 예산을 함께 줄이고
실행시간을 늘린다. `refuel-truck`은 주유소에 있을 때만 가능하고, 연료를 완전
복구하는 대신 예산과 시간을 사용한다. 따라서 연료, 예산, 위치를 독립적으로
보면 실제 가능한 경로를 잘못 평가할 수 있다.

그러나 package 목표 자체는 각 화물을 특정 장소로 옮기는 형태라서 상대적으로 나눌
수 있다. Truck 적재량과 연료에 여유가 있으면 additive 휴리스틱의 package별 잔여
비용이 실제 작업량과 잘 맞을 수 있다.

### 5.2 Problem progression

| Problem | Packages | Trucks | Places | Highway/local | Fuel stations | Budget | 해석 |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | --- |
| p000 | 1 | 1 | 2 | 0/1 | 1 | 10 | 이미 적재된 package를 1-edge 운송하는 smoke test |
| p001 | 3 | 1 | 5 | 1/6 | 3 | 8 | 주유와 제한된 highway 사용이 드러나는 작은 문제 |
| p002 | 3 | 2 | 8 | 5/10 | 3 | 23 | graph·truck 수 증가, package 수는 고정 |
| p003 | 6 | 2 | 8 | 5/10 | 3 | 24 | p002 topology 크기에서 package 목표 증가 |
| p004 | 9 | 2 | 8 | 5/10 | 3 | 23 | package 수 최대, 여러 양방향 배송 목표 |

p002~p004는 place, truck, edge 수가 같거나 비슷하므로 package 수 증가의 효과를 일부
볼 수 있다. 하지만 seed에 따라 경로 비용, package 위치, truck capacity, fuel capacity가
다르므로 완전한 통제 비교는 아니다.

### 5.3 휴리스틱 가설

- Relaxed plan은 fuel과 budget 감소를 약하게 반영하여 필요한 refuel과 우회를
  과소평가할 수 있다.
- `irhadd`는 독립적인 package 목표의 남은 운송비용을 더하는 데 유리할 수 있다.
- 예산이 tight해지면 package별 독립 추정이 같은 budget을 여러 번 사용하는 것처럼
  볼 수 있으므로 오차가 커질 수 있다.
- 경로를 빠르게 찾는 것과 objective가 낮은 경로를 찾는 것을 분리해 평가해야 한다.

## 6. 03 Books

### 6.1 문제 구조

Books는 도서관 로봇이 책을 지정된 서가의 정확한 순서로 정리하는 문제다. 연료나
배터리처럼 계속 소모되는 자원은 없다.

| 구조 | Fluent 또는 predicate | 특성 |
| --- | --- | --- |
| Cart 적재 | `cart-load`, `cart-capacity`, `book-weight` | 책을 싣고 내리면 되돌림 |
| 서가 공간 | `shelf-used-space`, `shelf-capacity`, `book-thickness` | 책 삽입·제거로 되돌림 |
| 높이 | `current-reach`, `shelf-height`, `step-boost` | step 설치·회수로 되돌림 |
| 서가 순서 | `next-to-fill`, `successor`, `assigned` | 끝 책만 제거, 다음 slot만 삽입 |
| 실행시간 | `total-library-time` | 이동·카트·서가 조작 비용 누적 |

수치 변수는 action 적용 가능성을 제한하지만 모두 되돌릴 수 있다. 핵심 난이도는
잘못 꽂힌 책 뒤의 책을 먼저 빼고, staging area에 임시로 두었다가, 필요한 책을
넣고, 빼두었던 책을 다시 넣는 symbolic ordering이다.

높은 서가는 step을 설치해야 접근할 수 있고, cart capacity는 여러 책을 한 번에
운반할 수 있는지를 결정한다. 그러나 잘못된 선택이 자원을 영구적으로 소진시키지는
않는다.

### 6.2 Problem progression

| Problem | Books | Shelves | Rooms | Cart cap. | Misordered | High shelves | 해석 |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | --- |
| p000 | 1 | 1 | 1 | 10 | 0 | 0 | 책 하나를 서가에 넣는 smoke test |
| p001 | 5 | 2 | 3 | 5 | 1 | 1 | 임시 제거·step·cart가 모두 드러남 |
| p002 | 10 | 3 | 3 | 7 | 2 | 1 | 책과 잘못된 서가 수 증가 |
| p003 | 15 | 5 | 4 | 9 | 3 | 2 | 서가·방·높은 서가 모두 증가 |
| p004 | 20 | 5 | 4 | 20 | 3 | 2 | topology는 p003과 비슷하고 책과 slot 수가 증가 |

p004는 p003보다 책이 많지만 cart capacity도 9에서 20으로 커졌다. 따라서 문제
번호가 커졌다고 모든 수치 제약이 더 tight해진 것은 아니다. p003→p004의 난이도
변화는 주로 책과 순서 조합 증가로 봐야 한다.

### 6.3 휴리스틱 가설

- Symbolic goal과 서가 순서가 핵심이므로 relaxed-plan 기반 방식이 빠른 첫 plan을
  찾기에 유리할 수 있다.
- 자원이 영구적으로 소모되지 않으므로 numeric decrease를 약하게 보는 오차가 Logistics나
  Watering보다 작을 가능성이 있다.
- Plan quality는 카트에 책을 몇 권씩 묶어 싣는지, step을 몇 번 설치하는지, 방 사이를
  몇 번 왕복하는지에 의해 결정된다.
- Numeric-aware 휴리스틱이 이 공유 setup 비용을 package별로 중복 계산하면 오히려 좋지
  않은 방향으로 안내할 수 있다.

## 7. 04 Watering

### 7.1 문제 구조

Watering은 로봇이 물뿌리개를 들고 여러 식물을 방문하여 각 식물의 demand만큼
물을 주는 문제다. 모든 식물을 처리한 후 물뿌리개를 base에 놓고 로봇도 base로
복귀해야 한다.

| 구조 | Fluent | 특성 |
| --- | --- | --- |
| 배터리 | `battery-level`, `battery-capacity` | 이동·파지·급수에 소모, 충전소에서 완전 복구 |
| 물 | `water-level`, `container-capacity` | 급수에 소모, 수도에서 완전 복구 |
| 식물 진행도 | `watered-amount`, `plant-demand` | 한 단위씩 단조 증가 |
| 경로 | `connected`, `move-energy`, `move-time` | 위치와 배터리를 함께 변경 |
| 실행시간 | `total-watering-time` | 모든 action 비용 누적 |

Watering은 6개 도메인 중 위치–자원 결합이 가장 직접적이다. `water-one-unit`는
식물 진행도를 늘리면서 물과 배터리를 동시에 줄인다. `fill-container`도 수도에서만
가능하고 배터리를 사용한다. 따라서 물, 배터리, 현재 위치, 남은 plant 목표를
함께 판단해야 한다.

### 7.2 Problem progression

| Problem | Plants | Locations | Taps | Chargers | Demand | Water cap. | Battery cap. | 해석 |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: | --- |
| p000 | 1 | 1 | 1 | 1 | 1 | 2 | 10 | 이동 없이 급수만 확인하는 smoke test |
| p001 | 3 | 5 | 1 | 2 | 8 | 5 | 38 | 최소 한 번의 재급수가 필요한 작은 순회 문제 |
| p002 | 4 | 6 | 1 | 2 | 18 | 9 | 59 | plant·위치·총 demand 증가 |
| p003 | 5 | 7 | 1 | 2 | 20 | 8 | 물 여유도 40%, 배터리도 tight해짐 |
| p004 | 6 | 8 | 2 | 2 | 29 | 9 | 물 여유도 30%, 배터리 factor 1.05의 결합 stress test |

p001~p004는 plant와 location 수가 늘어나는 동시에 물과 배터리 여유도가 줄어든다.
따라서 현재 progression만으로는 p004의 어려움이 객체 수 때문인지, 물 부족 때문인지,
배터리 부족 때문인지 분리할 수 없다.

### 7.3 휴리스틱 가설

- Delete/numeric relaxation이 물과 배터리 감소를 약하게 보면 refill·recharge·detour를
  과소평가할 수 있다.
- 물과 배터리의 가능 범위를 각각 계산하는 interval만으로는 같은 경로에서 두 자원을
  동시에 만족하는지 알기 어렵다.
- Additive 추정은 plant별 목표에 같은 refill·recharge 비용을 독립적으로 배분하거나
  중복 계산할 수 있다.
- 핵심 개선 정보는 최소 refill 횟수, 최소 recharge 횟수, 보충 장소까지의 최소 이동비용,
  같은 tour에서 처리할 수 있는 plant 수다.

## 8. 05 Barman

### 8.1 문제 구조

Barman은 두 손으로 shot과 shaker를 조작하여 주문을 만드는 문제다. 재료를
붓는 것만으로는 cocktail이 완성되지 않고, 용기를 집고, 정해진 순서로 재료를 넣고,
흔들고, 주문 shot에 따르고, 필요하면 세척해야 한다.

| 구조 | Fluent 또는 predicate | 특성 |
| --- | --- | --- |
| 양손 점유 | `handempty`, `holding` | 용기를 들면 해당 손을 다른 작업에 사용 불가 |
| 용기 상태 | `empty`, `clean`, `used`, `contains` | 새 재료를 위한 세척·비우기 순서 |
| 용량 | `liquid-volume`, `container-capacity` | overflow 방지, 붓기 가능성 제한 |
| 재고 | `dispenser-stock`, `dispense-amount` | fill/refill마다 감소, 복구 불가 |
| Recipe | `cocktail-part1/2`, `unshaked`, `shaked` | 두 재료의 혼합·shake 순서 강제 |
| 실행시간 | `total-barman-time` | fill·clean·shake 등의 서로 다른 비용 누적 |

장소를 이동하는 문제는 아니지만 symbolic–numeric 결합이 강하다. `fill-shot`은 shot이
비어 있고 깨끗하며 한 손으로 들고 다른 손이 비어 있어야 한다. 동시에 용량과
dispenser stock도 충분해야 한다. Numeric 목표를 한 번 증가시키기 위해 긴 symbolic
준비 순서가 필요한 구조다.

여러 주문이 같은 재료 재고를 공유하고, shot과 shaker도 재사용한다. 같은 cocktail
주문을 한 배치로 만들면 shake와 clean 횟수를 줄일 수 있지만, 이를 위해서는 주문 순서와
용기 재사용을 함께 계획해야 한다.

### 8.2 Problem progression

| Problem | Ingredients | Cocktails | Orders | Shakers | Stock ratio | 해석 |
| --- | ---: | ---: | ---: | ---: | ---: | --- |
| p000 | 1 | 1 | 1 | 1 | 여유 | 단일 ingredient shot 제조 smoke test |
| p001 | 3 | 2 | 4 | 1 | 1.50 | 양손·혼합·세척·재고가 모두 드러남 |
| p002 | 4 | 3 | 6 | 1 | 1.30 | recipe와 order 수 증가 |
| p003 | 5 | 4 | 8 | 2 | 1.15 | shaker 선택 증가, stock 여유 감소 |
| p004 | 6 | 5 | 10 | 2 | 1.00 | 필요한 최소 재고만 주어진 tight stress test |

이 progression은 order, ingredient, recipe, shaker 수가 늘어나는 동시에 stock slack이 줄어든다.
p004의 성능 급락을 객체 수와 tight stock 중 하나의 원인으로 단정할 수 없다.

### 8.3 휴리스틱 가설

- Relaxed plan은 긴 recipe·cleaning 순서를 빠르게 찾는 데 유리할 수 있다.
- Stock decrease를 무시하면 같은 재료를 무한히 사용할 수 있는 것처럼 평가할 수 있다.
- Interval로 각 용기 volume과 stock을 따로 보면 특정 재료가 어떤 shot·shaker에
  들어 있는지라는 symbolic 상관관계를 잃을 수 있다.
- p004에서는 잘못된 stock 사용을 되돌릴 수 없으므로 사실상의 dead end를 조기에
  식별할 수 있는지가 중요하다.
- Plan quality는 같은 cocktail을 batching하고 용기 세척과 교체를 줄이는지에 큰 영향을
  받는다.

## 9. 06 Assembly

### 9.1 문제 구조

Assembly는 부품의 선행관계를 지키며 각 부품을 배치하고 정확한 작업량만큼 체결한
다음 검사하는 문제다.

| 구조 | Fluent 또는 predicate | 특성 |
| --- | --- | --- |
| 선행관계 | `predecessor`, `fastened`, `placed` | 이전 part를 완료해야 다음 part 배치 가능 |
| Payload | `part-weight`, `robot-payload` | 소모되지 않는 정적 numeric gate |
| 공구 점유 | `tool-available`, `tool-mounted`, `tool-slot-empty` | 하나의 tool은 한 robot에만 장착 |
| 체결 작업량 | `completed-work`, `required-work`, `tool-work-step` | 상한을 넘지 않게 정확한 작업량 달성 |
| Setup·작업 시간 | `tool-change-time`, `tool-operation-time` | 큰 step과 공구 교체 횟수의 트레이드오프 |
| 실행시간 | `total-assembly-time` | 전체 action 비용 누적 |

Payload는 한 번 부품을 들어도 줄어드는 자원이 아니다. 반면 `completed-work`는 tool을
사용할 때마다 단조 증가하며 `required-work`와 정확히 같아야 finish action을 실행할 수
있다. 예를 들어 required work 9를 만들기 위해 step 5, 3, 1을 사용할 수 있지만,
각 step을 다른 tool로 수행하면 공구 교체비용이 추가된다.

다중 robot에서는 부품 무게에 따라 담당 robot을 정해야 하고, 여러 robot이 공구를
공유한다. 현재 PDDL은 sequential planning이므로 robot 두 대를 동시에 작동시키는 makespan
문제는 아니다. Robot 수가 늘어나면 병렬 실행보다 부품 할당과 공구 유지 선택이
늘어난다.

### 9.2 Problem progression

| Problem | Parts | Products | Robots | Tools | Work range | Payload | 해석 |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | --- |
| p000 | 1 | 1 | 1 | 1 | 1 | 10 | precision tool 하나로 체결하는 smoke test |
| p001 | 4 | 1 | 1 | 3 | 5–7 | 8 | 단일 robot·product의 작은 기준선 |
| p002 | 6 | 1 | 1 | 3 | 5–9 | 9 | precedence forest와 exact work 증가 |
| p003 | 8 | 2 | 2 | 4 | 6–12 | 6–10 | robot 할당·product 분리·tool 공유 추가 |
| p004 | 10 | 2 | 2 | 4 | 7–15 | 8–12 | 가장 많은 part와 work-step 조합 |

p002→p003에서 part 수뿐 아니라 product, robot, tool 수가 함께 변한다. 따라서
탐색 변화를 다중 robot 효과로만 해석할 수 없다.

### 9.3 휴리스틱 가설

- Relaxed plan은 precedence 달성 순서를 빠르게 찾을 수 있지만 hand·tool 점유 해제를
  생략하여 setup 비용을 과소평가할 수 있다.
- Interval 추정이 `completed-work` 상한만 보면, 정확한 작업량을 만드는 tool-step 조합과
  교체비용을 잃을 수 있다.
- Part별 work 목표는 어느 정도 나눌 수 있지만 robot과 tool 점유는 공유된다.
- 휴리스틱은 part별 최소 fastening 시간과 공구 교체 lower bound를 구분해야 한다.

## 10. Problem progression의 공통 한계

현재 `p001~p004`는 planner의 성능이 어디서 급격히 떨어지는지 찾는 stress test로는
적합하다. 하지만 대부분의 도메인에서 여러 요인이 함께 변한다.

| Domain | 함께 변하는 주요 요인 | 현재 문제만으로 분리하기 어려운 것 |
| --- | --- | --- |
| Blocksworld | block 수와 stack 형태 | 객체 수와 goal 재배치 깊이 |
| Logistics | package 수·위치, graph cost, capacity, fuel, budget | 배송 수와 resource tightness |
| Books | book·shelf·room 수, misordering, high shelf, cart capacity | symbolic ordering과 numeric gate |
| Watering | plant·location 수, water ratio, battery factor | 크기·물·배터리 효과 |
| Barman | order·ingredient·recipe·shaker 수, stock ratio | symbolic 조합과 finite stock |
| Assembly | part·product·robot·tool 수, work, payload | precedence·할당·numeric work 효과 |

따라서 현재 결과로 다음과 같은 문장은 말할 수 있다.

> Watering p004에서 NFD `irhadd`의 탐색이 크게 늘었다.

하지만 다음 문장을 인과관계로 주장하려면 추가 실험이 필요하다.

> 물과 배터리의 결합만으로 NFD `irhadd`의 탐색이 증가했다.

## 11. 도메인 특징 표현 초안

휴리스틱 선택기나 도메인 분석기에 넣을 초기 특징을 다음과 같이 정의할 수 있다.

| Feature | 의미 | 예시 |
| --- | --- | --- |
| `num_numeric_fluents` | 객체를 grounding한 후 dynamic numeric fluent 수 | robot별 battery, truck별 fuel |
| `num_numeric_preconditions` | grounded action의 numeric gate 수 | fuel 충분, capacity 이하 |
| `decrease_effect_ratio` | action 중 numeric decrease를 가진 비율 | move, water, drive |
| `assign_effect_ratio` | action 중 numeric assign을 가진 비율 | refill, recharge, empty |
| `replenishable_resource_count` | 감소 후 복구 가능한 자원 수 | Watering=2 |
| `nonrenewable_resource_count` | 감소 후 복구할 수 없는 자원 수 | budget, dispenser stock |
| `location_bound_replenishment` | 특정 위치에서만 복구할 수 있는지 | tap, charger, fuel station |
| `joint_numeric_effect_width` | action 하나가 동시에 바꾸는 numeric fluent 수 | watering: water+battery+progress+time |
| `symbolic_numeric_coupling` | symbolic 상태와 numeric gate/effect가 같은 action에 엮힌 정도 | Barman fill, Assembly fastening |
| `shared_resource_goal_ratio` | 같은 자원을 공유하는 goal 비율 | 모든 plant가 battery 공유 |
| `exact_numeric_goal_count` | equality 또는 정확한 누적값을 요구하는 구조 수 | Assembly completed work |
| `setup_reuse_potential` | 이동·세척·공구 교체를 여러 goal이 공유할 수 있는 정도 | Books cart, Barman shaker |
| `objective_search_alignment` | search cost가 PDDL metric과 일치하는 정도 | unit-cost `irhff`는 낮음 |

일부 특징은 domain PDDL만으로 계산할 수 있지만, resource tightness나 goal 경쟁은 problem의
초기값과 goal까지 함께 읽어야 한다. 따라서 선택기는 domain-only가 아니라 domain–problem
pair를 분석해야 한다.

## 12. 도메인별 통제 실험 우선순위

| 우선순위 | Domain | 고정할 것 | 단독으로 바꿀 것 | 핵심 질문 |
| ---: | --- | --- | --- | --- |
| 1 | Watering | graph, plant, demand, 시설 위치 | water ratio 또는 battery factor | 두 보충 자원의 결합이 plateau를 만드는가? |
| 2 | Logistics | graph, package, truck | budget 또는 fuel capacity | relaxed plan의 품질 저하는 어느 자원에서 시작되는가? |
| 3 | Barman | order, recipe, container | stock slack | finite stock이 symbolic preparation 탐색을 언제 악화시키는가? |
| 4 | Assembly | precedence, part, robot | work-step 조합 또는 payload | exact work와 tool setup 중 어느 쪽이 탐색을 키우는가? |
| 5 | Books | shelf order, book placement | cart capacity 또는 high shelf 비율 | reversible numeric gate도 성능 차이를 만드는가? |
| 6 | Blocksworld | block·stack problem | numeric 요인 없음 | numeric 없는 symbolic baseline에서의 overhead는 얼마인가? |

우선순위는 현재 연구 질문인 `빠른 첫 plan–numeric plan quality`의 차이를 가장 명확하게
보여 준 도메인부터 배치한 것이다.

## 13. 결론

6개 도메인은 단순히 numeric fluent 수가 다른 문제가 아니다. 수치 상태의 역할이
다르다.

- Blocksworld는 numeric feasibility가 없는 symbolic baseline이다.
- Books는 수치 제약이 있지만 대부분 되돌릴 수 있고 symbolic ordering이 핵심이다.
- Logistics는 복구 가능한 fuel과 복구할 수 없는 budget이 경로 선택과 엮힌다.
- Watering은 서로 다른 위치에서 복구되는 물과 배터리를 같이 관리해야 한다.
- Barman은 복구할 수 없는 재고와 긴 symbolic manipulation sequence가 엮힌다.
- Assembly는 소모성 자원보다 정확한 numeric work 조합과 공구 setup이 핵심이다.

따라서 휴리스틱 적합성을 예측하려면 `numeric fluent가 있는가?`를 보는 것으로는
부족하다. 자원의 복구 가능성, 복구 위치, 여러 목표 간 경쟁, symbolic–numeric 결합,
setup 재사용과 exact numeric completion을 함께 보아야 한다.

다음 실험에서는 우선 Watering의 물·배터리 축과 Logistics의 fuel·budget 축을 각각
고정·변화하여, 어떤 구조가 relaxed-plan의 plan quality 저하와 numeric-aware 휴리스틱의
coverage 저하를 만드는지 먼저 분리하는 것이 적합하다.

이 추가 분석은
[Watering·Logistics 수치 자원 2×2 통제 실험](./13_수치자원_2x2_통제실험_결과.md)으로
수행했다. 그 결과 Watering에서는 물과 배터리의 동시 tightness보다 반복 refill을
요구하는 물 용량이 numeric-aware 탐색량을 가장 크게 늘린 요인으로 나타났다.

Barman의 symbolic 규모와 stock feasibility를 분리한 후속 결과는
[Domain–problem 상호작용과 Barman 통제실험](./14_domain_problem_상호작용과_Barman_통제실험.md)에
정리했다. 이 실험에서는 제약의 강도 자체보다 가능한 action이 오래 남아 모순이 늦게
드러나는 `one-short` 조건과, 선택지를 많이 남기는 abundant 조건이 더 어려울 수 있음을
확인했다.
