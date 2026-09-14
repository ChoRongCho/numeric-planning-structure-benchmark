# 03 Books: Library Rearrangement

## Problem generator

`generate_problem.py` 상단의 전역변수에서 book, shelf, room, cart 수와
numeric 범위 및 misordered/high shelf 비율을 설정한다.

```bash
# PDDL과 PNG 생성
./changmin_benchmark/03_books/generate_problem.py

# 현재 p001~pNNN을 파싱해 이 README의 요약표 갱신
./changmin_benchmark/03_books/generate_problem.py --summarize
```

출력은 `instances/pNNN.pddl`과 `images/pNNN.png`에 같은 번호로 저장된다.

## 연구 성격

Books는 연료, 배터리, 예산처럼 실행 가능성을 고갈시키는 소모성 자원을 사용하지
않는다. Numeric fluent는 물리적 capacity와 configuration으로 행동의 적용 가능성을
제한한다. 여기에 각 행동의 소요시간을 `total-library-time`에 누적하고 이를
최소화한다. 핵심 난이도는 잘못 꽂힌 책을 제거하고 임시 보관한 뒤 올바른 순서로
복원하는 symbolic action sequence이며, 시간 목적함수는 카트를 한 권짜리 셔틀처럼
왕복시키는 plan보다 여러 책을 묶어 운반하는 plan을 선호하게 한다.

## Numeric 상태

| Fluent | 의미 | 변화 방식 |
|---|---|---|
| book-weight | 책 무게 | 정적 |
| book-thickness | 책 두께 | 정적 |
| cart-capacity | cart 최대 적재 무게 | 정적 |
| cart-load | cart 현재 적재 무게 | 적재·하역 시 증가·감소 |
| shelf-capacity | shelf 최대 공간 | 정적 |
| shelf-used-space | shelf 현재 점유 공간 | 책 삽입·제거 시 증가·감소 |
| shelf-height | shelf 높이 | 정적 |
| step-boost | step의 추가 reach | 정적 |
| current-reach | robot 현재 reach | step deploy/retract 시 증가·감소 |
| total-library-time | 현재까지 누적된 실행시간 | 모든 행동에서 증가 |

`cart-load`, `shelf-used-space`, `current-reach`는 모두 되돌릴 수 있다.
`total-library-time`은 실행 가능성을 제한하는 자원이 아니라 plan 품질을 비교하는
누적 목적함수다.

## 시간 비용과 목적함수

| 행동 종류 | 시간 비용 |
|---|---:|
| robot 단독 이동 | 8 |
| cart 동반 이동 | 10 |
| cart 연결·분리 | 2 |
| 책 집기·임시보관·cart 적재/하역 | 1 |
| shelf 삽입·제거 | 2 |
| step 설치·회수 | 5 |

문제의 metric은 `(:metric minimize (total-library-time))`이다. 이는 목표 정리
plan의 예상 실행시간이며 플래너 자체의 계산시간과는 다르다. Durative action을
사용하는 temporal model이 아니라 action cost를 시간 단위로 해석한 누적 모델이다.
따라서 planner가 반환한 첫 plan이 전역 최적해임을 자동으로 보장하지는 않으며,
최적화 지원 방식에 따라 더 좋은 plan을 찾는 정도가 달라질 수 있다.

## Symbolic sequence

각 shelf는 next-to-fill position을 하나 가진다. 책은 그 position의 slot에만
꽂을 수 있고, 제거할 때도 next-to-fill 바로 앞의 마지막 책만 뺄 수 있다.

Shelf A는 처음에 A100, A120 순서이고 목표는 A100, A110, A120이다. 따라서
A120 제거, 임시 보관, A110 삽입, A120 복원 순서가 반드시 필요하다.

Shelf B는 높이 220, robot 기본 reach는 180, step boost는 60이다. Step을
deploy해 reach를 240으로 만든 뒤 B100, B110 순서로 채워야 한다.

Cart capacity는 9이고 반납 도서 A110, B100, B110의 총무게는 12라서 세 책을
한 번에 운반할 수 없다.

## 검증

| Problem | Planner | Plan 길이 | VAL |
|---|---|---:|---|
| p001 | ENHSP hadd + WA* | 32 | valid |
| p001 | Metric-FF | 22 | valid |
| p002 | ENHSP hadd + WA* | 46 | valid |
| p002 | Metric-FF | 38 | valid |

시간 metric 적용 후 p001에서 ENHSP의 첫 해는 누적시간 124, Metric-FF의 해는
누적시간 68이었다. Metric-FF plan은 반납실에서 B100과 B110을 카트에 함께 싣고
한 번에 aisle-b로 운반한다. 즉 시간 최소화가 의도한 batching을 실제로 유도했다.

<!-- AUTO-GENERATED-PROBLEM-SUMMARY:START -->
## Problem 설정 요약

> 이 구간은 generate_problem.py --summarize가 instances의 problem을
> 직접 파싱해 갱신한다.

| Problem | Books | Shelves | Rooms | Carts | Misordered shelves | High shelves |
|---|---:|---:|---:|---:|---:|---:|
| p001 | 5 | 2 | 3 | 1 | 1 | 1 |
| p002 | 10 | 3 | 3 | 1 | 2 | 1 |
| p003 | 15 | 5 | 4 | 1 | 3 | 2 |
| p004 | 20 | 5 | 4 | 1 | 3 | 2 |

| Problem | Book weight | Thickness | Cart capacity | Shelf capacity | Initial shelf use | Shelf height | Robot reach |
|---|---:|---:|---:|---:|---:|---:|---:|
| p001 | 2–5 | 2–3 | 5 | 4–8 | 2–6 | 174–234 | 180 |
| p002 | 1–5 | 1–4 | 7 | 7–9 | 4–6 | 166–221 | 180 |
| p003 | 1–5 | 1–4 | 9 | 4–10 | 3–6 | 143–220 | 180 |
| p004 | 1–5 | 1–4 | 20 | 8–11 | 2–7 | 124–224 | 180 |

<!-- AUTO-GENERATED-PROBLEM-SUMMARY:END -->
