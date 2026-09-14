# Numeric Planning for Robotic Task Planning

이 저장소는 classical/numeric planner가 로봇 작업을 계획할 때 어떤 문제 구조에서
어려움을 겪는지 조사하기 위한 연구 프로젝트다. 특히 heuristic relaxation에서
사라지는 symbolic 삭제 효과와 numeric 자원 감소·상한·정확한 목표량이 search에
미치는 영향을 분석한다.

현재 목표는 새로운 학습 모델을 먼저 제안하는 것이 아니다.

> 기존 numeric planner가 무엇을 잘못 보거나 보지 못하는지 재현하고, 문제 크기와
> 분리된 통제 실험으로 그 원인을 확인한다.

## 연구 질문

1. Numeric heuristic의 relaxation에서 어떤 정보가 사라지는가?
2. 어떤 symbolic–numeric 결합 구조에서 heuristic 오차와 search 비용이 커지는가?
3. 관찰된 실패가 문제 크기, planner 구현, grounding 또는 진짜 구조적 한계 중
   어디에서 발생하는가?

상세 정의는 [연구 문제 정의](docs/01_연구_문제_정의.md)와
[문제 발견 프레임워크](docs/02_문제_발견_프레임워크.md)에 있다.

## 로봇 벤치마크

연구용 도메인은 [changmin_benchmark](changmin_benchmark/README.md)에 독립적으로
관리한다. 원본 `benchmarks/`는 수정하지 않는다.

| 번호 | Domain | 중심 구조 | 최적화 목표 | Instances |
|---:|---|---|---|---:|
| 01 | Blocksworld | 순수 symbolic 파지·적층·삭제 효과 | action cost | 4 |
| 02 | Logistics | 적재량·연료·예산과 유료/무료 경로 | 배송 실행시간 | 4 |
| 03 | Books | 서가 순서·높이·공간과 cart batching | 정리 실행시간 | 4 |
| 04 | Watering | 물·배터리의 고갈과 공간적 보충 | 급수 실행시간 | 4 |
| 05 | Barman | 양손·세척·혼합과 액체량·유한 재고 | 제조 실행시간 | 4 |
| 06 | Assembly | 선행관계·payload·공구와 정확한 체결량 | 조립 실행시간 | 4 |

`07_laboratory`는 현재 연구 범위에서 제외하며 실험에 포함하지 않는다.

02~06의 PDDL metric은 planner 계산시간이 아니라 로봇이 반환된 plan을 수행하는 데
드는 예상 실행시간이다. Planner wall-clock time은 별도의 실험 결과로 측정한다.

각 도메인의 모델과 생성 방법:

- [01 Blocksworld](changmin_benchmark/01_blocksworld/README.md)
- [02 Logistics](changmin_benchmark/02_logistics/README.md)
- [03 Books](changmin_benchmark/03_books/README.md)
- [04 Watering](changmin_benchmark/04_watering/README.md)
- [05 Barman](changmin_benchmark/05_barman/README.md)
- [06 Assembly](changmin_benchmark/06_assembly/README.md)

## 바로 실행하기

단일 문제를 GUI에서 실행한다.

```bash
./planner
```

GUI에서 benchmark collection, domain, problem, planner, heuristic, search 옵션,
timeout과 CPU core 수를 선택할 수 있다. 결과 plan과 실행 로그는 오른쪽 패널에
표시된다. 자세한 내용은 [Planner GUI 안내](src/planner_gui/README.md)를 참고한다.

명령행에서 직접 실행하는 예:

```bash
./planners/plannerctl run enhsp \
  -o "$PWD/changmin_benchmark/04_watering/domain.pddl" \
  -f "$PWD/changmin_benchmark/04_watering/instances/p001.pddl" \
  -h hadd -s WAStar -ties arbitrary
```

## Problem 재생성

```bash
./changmin_benchmark/02_logistics/generate_problem.py
./changmin_benchmark/03_books/generate_problem.py
./changmin_benchmark/04_watering/problem_generator.py
./changmin_benchmark/05_barman/generator.py
./changmin_benchmark/06_assembly/generator.py
```

각 생성기의 `--summarize` 옵션은 해당 디렉터리 README의 instance 표를 갱신한다.
Blocksworld 생성 명령은 다음과 같다.

```bash
./changmin_benchmark/01_blocksworld/generator.py
./changmin_benchmark/01_blocksworld/generator.py --summarize
```

## 배치 실험

```bash
cd scripts/run
./run
```

실험 설정과 결과 구조는 [벤치마크와 실험 실행](docs/04_벤치마크와_실험_실행.md)과
[실행 스크립트 안내](scripts/run/README.md)를 참고한다. Raw 결과는 `results/raw/`,
가공 결과는 `results/processed/`에 분리한다.

## 문서

- [문서 지도](docs/00_문서_지도.md)
- [연구 문제 정의](docs/01_연구_문제_정의.md)
- [플래너 방법론과 휴리스틱](docs/05_플래너_방법론과_휴리스틱.md)
- [실험 구현과 계측 요건](docs/06_실험_구현과_계측_요건.md)
- [플래너 자료](docs/10_플래너_자료/00_자료_안내.md)
- [다음 작업](docs/11_다음_작업/00_다음_작업.md)

## 현재 상태

- 02~06: numeric domain과 p001~p004 생성 완료
- 02~06: plan 실행시간 최소화 metric 적용
- 01, 04~06: 한 번의 명령으로 p001~p004 재현 가능
- 05·06: 모든 instance가 VAL parser를 통과
- 06: Metric-FF가 p001~p004 모두에서 첫 plan 발견
- 01: classical 대조군 generator 및 p001~p004 동일 metric 정규화 완료

Smoke test의 plan 발견은 최적성 증명이나 연구 결론이 아니다. 최종 주장은 동일한
instance에 대한 planner/heuristic 반복 실험과 state-level 분석 이후에만 내린다.
