# 02 Logistics

## Problem generator

전역 설정은 `generate_problem.py` 상단에서 변경한다.

- `NUM_PROBLEMS`, `START_INDEX`
- `NUM_PACKAGES`, `NUM_TRUCKS`, `NUM_PLACES`
- `NUM_HIGHWAYS`, `NUM_LOCAL_ROADS`
- `RANDOM_SEED`
- truck/package 무게 범위, manual capacity, highway budget 비율,
  fuel-station 최소 비율

실행:

```bash
./changmin_benchmark/02_logistics/generate_problem.py
```

현재 생성된 모든 problem을 파싱해 이 README의 요약표를 갱신:

```bash
./changmin_benchmark/02_logistics/generate_problem.py --summarize
```

출력:

- PDDL: `02_logistics/instances/pNNN.pddl`
- 환경 이미지: `02_logistics/images/pNNN.png`

같은 설정과 seed를 사용하면 같은 문제가 생성된다. Local-road graph는 항상 연결되며,
모든 도로는 PDDL에서 양방향으로 생성된다. Highway와 local road는 같은 두 place
사이에 병렬로 존재할 수 있다.

## 자동 초기값

- fuel station 수: `max(NUM_TRUCKS, ceil(NUM_PLACES * 0.30))`
  - 전체 place의 최소 30%를 유지
  - 모든 truck이 fuel station에서 시작할 수 있도록 truck 수보다 적어지지 않음
- truck 시작 위치: fuel station
- truck capacity: 환경 크기와 무관하게 800~1200kg에서 무작위 결정
- truck load 초기값: 0kg
- manual capacity: 100kg
- package weight: 50~130kg; 첫 package는 반드시 101~130kg
- 초기 fuel: 생성된 fuel capacity와 같은 full 상태
- fuel capacity: fuel을 가장 많이 소비하는 도로 3개의 `distance` 합에
  100%~120%의 난수를 곱해 결정. 도로가 3개 미만이면 존재하는 도로를 모두 사용
- refuel cost/time: place 수에 따라 증가
- budget: 모든 truck의 1회 refuel 비용과 전체 highway toll의 일정 비율
- 첫 package: manual capacity보다 무겁게 생성하여 truck 사용이 반드시 필요

`HIGHWAY_BUDGET_RATIO`가 현재 budget 난이도를 조절하는 핵심 값이다.

## PNG 표기

- 굵은 회색선: 느리고 무료이며 도보 이동이 가능한 local road
- 붉은 점선: 빠르고 toll이 있으며 도보 이동이 불가능한 highway
- 노란 node: fuel station
- `L d13/t16`: local road의 distance 13, time 16
- `H d7/t4/USD3`: highway의 distance 7, time 4, toll 3
- node 내부: truck/driver 시작점, package 시작점과 goal

## 시간 모델

- load/unload: 각각 고정 시간 1
- board/get-out: 각각 시간 1
- highway: `distance * 0.35~0.60`을 올림한 시간
- local road: `distance + 3~8` 시간
- 빈손 도보: local-road 시간의 1.5배
- package 운반 도보: local-road 시간의 2배
- refuel: place 수에 따라 증가하는 service time

목적함수는 목표 배송 plan의 예상 실행시간인 `total-delivery-time` 최소화다.
플래너의 계산시간은 이 목적함수에 포함되지 않으며 별도의 실험 지표로 측정한다.

기본 설정으로 다시 생성한 `p002`는 VAL parser를 통과했다.

<!-- AUTO-GENERATED-PROBLEM-SUMMARY:START -->
## Problem 설정 요약

> 이 구간은 `generate_problem.py --summarize`가 instances의 p001~pNNN을
> 직접 파싱해 갱신한다. 수동으로 편집하지 않는다.

### 환경 크기와 예산

| Problem | Packages | Trucks | Places | Highways | Local roads | Fuel stations | Budget |
|---|---:|---:|---:|---:|---:|---:|---:|
| `p000` | 1 | 1 | 2 | 0 | 1 | 1 | 10 |
| `p001` | 3 | 1 | 5 | 1 | 6 | 3 | 8 |
| `p002` | 3 | 2 | 8 | 5 | 10 | 3 | 23 |
| `p003` | 6 | 2 | 8 | 5 | 10 | 3 | 24 |
| `p004` | 9 | 2 | 8 | 5 | 10 | 3 | 23 |

### Numeric 초기값 범위

| Problem | Package kg | Manual kg | Truck capacity kg | Initial load kg | Fuel initial | Fuel capacity | Toll | Highway time | Local time |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| `p000` | 50 | 100 | 1000 | 50 | 10 | 10 | - | - | 2 |
| `p001` | 63–101 | 100 | 863 | 0 | 37 | 37 | 2 | 3 | 11–19 |
| `p002` | 101–123 | 100 | 862–1042 | 0 | 44 | 44 | 2–5 | 2–6 | 7–20 |
| `p003` | 51–130 | 100 | 906–1062 | 0 | 37 | 37 | 3–4 | 3–6 | 8–17 |
| `p004` | 53–103 | 100 | 929–1138 | 0 | 44 | 44 | 2–5 | 3–8 | 10–20 |

### 배송 설정

- `p000`: pack1:?→place2
- `p001`: pack1:place2→place1, pack2:place1→place2, pack3:place2→place4
- `p002`: pack1:place3→place4, pack2:place5→place7, pack3:place1→place6
- `p003`: pack1:place3→place8, pack2:place8→place6, pack3:place4→place7, pack4:place8→place2, pack5:place5→place1, pack6:place2→place6
- `p004`: pack1:place6→place7, pack2:place2→place7, pack3:place5→place4, pack4:place6→place8, pack5:place4→place6, pack6:place7→place1, pack7:place1→place7, pack8:place5→place8, pack9:place6→place4

<!-- AUTO-GENERATED-PROBLEM-SUMMARY:END -->
