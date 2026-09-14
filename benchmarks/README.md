# Benchmarks

이 폴더는 실험용 PDDL benchmark를 도메인 단위로 정리한 디렉터리입니다. 각 하위 폴더는 하나의 planning domain을 나타내며, 공통적으로 `domain.pddl`과 `instances/` 아래의 problem 파일들을 가집니다.

## 폴더 구조

```text
benchmarks/
  01_LOGISTIC/
    domain.pddl
    instances/
      p001.pddl
      ...
```

- 폴더명 앞의 번호는 benchmark 정렬용 번호입니다.
- `domain.pddl`은 도메인 정의 파일입니다.
- `instances/pNNN.pddl`은 개별 problem instance입니다.
- 원본 파일명은 정리 과정에서 `p001.pddl`, `p002.pddl`처럼 순번 기반 이름으로 통일했습니다.

## 사용 예시

```bash
planner benchmarks/17_SATELLITE/domain.pddl \
        benchmarks/17_SATELLITE/instances/p001.pddl
```

사용하는 planner에 따라 명령 형식은 달라질 수 있습니다. numeric fluent, derived predicate, action cost 같은 PDDL 기능은 planner별 지원 여부를 먼저 확인해야 합니다.

전체 catalog와 자동 실행에는 다음 명령을 사용합니다.

```bash
scripts/run/generate_benchmark_manifest.py
scripts/run/benchmarkctl list
scripts/run/benchmarkctl validate-pddl
```

기계 판독 catalog는 `benchmarks/manifest.yaml`에 생성됩니다.
실험 선택은 `scripts/run/experiment.yaml`에서 설정하고 `scripts/run/run`으로
실행합니다.

## 도메인 목록

| 번호 | 도메인 | 인스턴스 | 설명 |
| --- | --- | ---: | --- |
| 01 | `LOGISTIC` | 1 | 기본 logistics 계열 도메인입니다. driver, truck, package, place 사이의 이동, 탑승, 적재, 하차를 다룹니다. |
| 02 | `LOGISTIC_NEW` | 2 | 확장된 logistics 도메인입니다. derived predicate와 action cost가 포함되어 반복 운송 구조와 abstraction 실험에 적합합니다. |
| 03 | `BLOCKSWORLD` | 3 | 고전적인 block stacking 도메인입니다. 블록을 집고 쌓고 내리는 순서 제약을 통해 조합적 탐색 성능을 확인할 수 있습니다. |
| 04 | `ROVER_CHANGMIN` | 1 | Rover 계열 도메인입니다. 로버 이동, 샘플 채취, 촬영, 통신 같은 복합 작업을 다룹니다. |
| 05 | `PIPESWORLD_STRIPS` | 1 | 파이프라인 네트워크에서 batch를 이동시키는 STRIPS 계열 도메인입니다. 연결 구조와 batch ordering이 핵심입니다. |
| 06 | `TSP_NUMERIC` | 1 | Traveling Salesperson Problem을 numeric planning 형태로 표현한 도메인입니다. 방문 조건과 이동 비용을 numeric fluent로 다룹니다. |
| 07 | `TSP_CONNECTED_NUMERIC` | 1 | 연결 그래프가 명시된 numeric TSP 변형입니다. 연결성, 방문 목표, 이동 비용이 함께 계획 조건을 만듭니다. |
| 08 | `RAILWAYS_SIMPLE` | 2 | 단순화된 railway planning 도메인입니다. 기차 운행, driver/guard 배치, 연료와 보너스 같은 자원을 포함합니다. |
| 09 | `WATERING` | 1 | 식물에 물을 주는 resource planning 도메인입니다. 물의 보충, 이동, 소비를 numeric fluent로 표현합니다. |
| 10 | `EIGHT_PUZZLE` | 1 | 8-puzzle 형태의 상태 전이 도메인입니다. 타일 위치를 바꾸며 목표 배열에 도달하는 permutation search 문제입니다. |
| 11 | `SEEDSET` | 1 | seed set selection 계열 도메인입니다. 많은 predicate와 action schema가 포함되어 큰 grounded search space를 만들 수 있습니다. |
| 12 | `BOOKNEW` | 1 | book-related toy 도메인입니다. PDDL parser와 requirement compatibility를 확인하는 용도의 작은 예제입니다. |
| 13 | `GROUNDED_TRUCKS` | 1 | grounded action이 많이 직접 기술된 trucks toy 도메인입니다. regression 또는 sanity check 용도로 적합합니다. |
| 14 | `DESIRE` | 1 | 작은 STRIPS-like toy planning 도메인입니다. parser와 end-to-end 실행 확인에 사용하기 좋습니다. |
| 15 | `ISSUE49` | 2 | translator issue/regression 성격의 테스트 도메인입니다. static true/false goal 처리 같은 robustness 확인에 적합합니다. |
| 16 | `TEST1` | 1 | 임시 테스트 도메인입니다. 작은 object/action 조합과 total-cost effect를 포함합니다. |
| 17 | `SATELLITE` | 36 | IPC04 Satellite numeric variant입니다. 위성 방향 전환, 장비 보정, 이미지 촬영, 데이터 용량 같은 수치 자원을 다룹니다. |
| 18 | `BLOCK_GROUPING` | 20 | IPC23 도메인입니다. 격자 위 블록을 이동시켜 같은 색상의 블록들을 같은 위치에 모으는 문제입니다. |
| 19 | `COUNTERS` | 20 | IPC23 numeric counter 도메인입니다. 카운터 값을 증가/감소시키며 목표 수치 조건을 만족시킵니다. |
| 20 | `DELIVERY` | 20 | IPC23 delivery 도메인입니다. 로봇이 물건을 집고 운반해 목적지에 배달하며 적재 한계와 tray 사용을 고려합니다. |
| 21 | `DRONE` | 20 | IPC23 drone 도메인입니다. 3차원 좌표 공간에서 UAV가 이동하고 목표 위치 방문과 배터리 관리를 수행합니다. |
| 22 | `EXPEDITION` | 20 | IPC23 expedition 도메인입니다. 썰매가 waypoint를 따라 이동하며 보급품을 저장하거나 회수하는 탐험 계획 문제입니다. |
| 23 | `EXT_PLANT_WATERING` | 20 | IPC23 확장 plant watering 도메인입니다. 에이전트가 물을 운반해 식물에 물을 주며 이동과 물 자원을 함께 관리합니다. |
| 24 | `FARMLAND` | 20 | IPC23 farmland 도메인입니다. 농장에 인력을 배치하고 이동시키며 이득 조건을 만족시키는 문제입니다. |
| 25 | `FO_COUNTERS` | 20 | IPC23 counters 확장 도메인입니다. 카운터 값뿐 아니라 변화율까지 조절해야 하는 수치 계획 문제입니다. |
| 26 | `FO_FARMLAND` | 20 | IPC23 farmland 확장 도메인입니다. 차량 고용과 빠른 이동이 추가되어 시간/비용 선택이 중요합니다. |
| 27 | `FO_SAILING` | 20 | IPC23 sailing 확장 도메인입니다. 항해 방향뿐 아니라 가속과 감속 제어까지 계획해야 합니다. |
| 28 | `HYDROPOWER` | 20 | IPC23 hydropower 도메인입니다. 전력 가격에 따라 물을 펌핑하거나 발전해 이익을 얻는 resource flow 문제입니다. |
| 29 | `MARKETTRADER` | 19 | IPC23 market trader 도메인입니다. 여러 시장에서 상품을 사고 운반하고 팔아 수익을 내는 거래 계획 문제입니다. |
| 30 | `MPRIME` | 20 | IPC23 MPrime 도메인입니다. Mystery/MPrime 계열의 수치 자원 이동 문제로, 제한 자원을 쓰며 목표 상태에 도달합니다. |
| 31 | `PATHWAYSMETRIC` | 20 | IPC23 pathways metric 도메인입니다. 생물학적 반응 경로를 구성하는 순서를 찾는 planning 문제입니다. |
| 32 | `ROVER_IPC23` | 20 | IPC23 Rover 도메인입니다. waypoint 이동, 샘플 채취, 카메라 보정, 이미지 촬영, 통신 작업을 포함합니다. |
| 33 | `SAILING` | 20 | IPC23 sailing 도메인입니다. 보트가 바람의 영향을 받으며 해상 위치를 이동하고 사람을 구조합니다. |
| 34 | `SETTLERSNUMERIC` | 20 | IPC23 Settlers numeric 도메인입니다. 자원 운송, 건설, 생산 체인을 함께 다루는 수치 계획 문제입니다. |
| 35 | `SUGAR` | 20 | IPC23 sugar 도메인입니다. 사탕수수에서 설탕을 생산하는 산업 공정과 원료/기계/운송 흐름을 모델링합니다. |
| 36 | `TPP` | 20 | IPC23 Travelling Purchase Problem 도메인입니다. 여러 시장을 방문해 필요한 물품을 구매하며 이동비와 구매비를 고려합니다. |
| 37 | `ZENOTRAVEL` | 20 | IPC23 Zenotravel 도메인입니다. 비행기와 승객을 이동시키며 연료 소비와 빠른/느린 비행 선택을 다룹니다. |
| 38 | `SETTLERS_IPC04` | 20 | IPC04 Settlers numeric 도메인입니다. 정착지 확장, 자원 생산/운반/소비, 건설 순서를 함께 계획합니다. |
| 39 | `PSR_LARGE_IPC04` | 50 | IPC04 PSR large 도메인입니다. 전력 공급 복구 문제로, 네트워크 재구성과 derived predicate 기반 복구 조건을 다룹니다. |

## 출처별 구성

- `01_LOGISTIC`부터 `16_TEST1`까지는 `backup/00_DOMAINS_Changmin`에서 정리한 내부 실험/테스트 도메인입니다.
- `17_SATELLITE`, `38_SETTLERS_IPC04`, `39_PSR_LARGE_IPC04`는 `backup/01_DOMAINS_IPC04`에서 선택한 IPC04 도메인입니다.
- `18_BLOCK_GROUPING`부터 `37_ZENOTRAVEL`까지는 `backup/02_DOMAINS_IPC23`에서 정리한 IPC23 도메인입니다.

## 참고

이 benchmark set은 현재 39개 도메인과 526개 problem instance로 구성되어 있습니다. 도메인마다 사용하는 PDDL feature가 다르므로, 실험 전에 `domain.pddl`의 `:requirements`와 사용하는 planner의 지원 범위를 확인하는 것이 좋습니다.
