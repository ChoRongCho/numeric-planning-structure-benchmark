# Planner layout and current experiment set

planner 파일은 출처와 역할에 따라 다음 위치에 둔다.

| 위치 | 내용 |
|---|---|
| `external/` | Git clone한 planner·solver·dataset 원본 및 build |
| `runtime/` | 격리 설치한 실행 runtime과 dependency |
| `archives/` | 원본 배포 archive와 과거 binary |
| `local/` | 사용자가 직접 제공하거나 수정한 로컬 artifact |
| `locks/` | source revision, checksum, dependency 기록 |
| `download-logs/` | build·smoke·검증 로그 |

모든 실험은 파일 위치가 아니라 `plannerctl`의 planner ID를 사용한다. 따라서 내부
파일을 옮겨도 YAML과 과거 결과의 planner ID는 바뀌지 않는다.

## 현재 기본 비교군: 13개

`scripts/run/experiment.yaml`은 다음 구성을 한 번에 비교한다.

| 계열 | planner ID | 현재 기본 guidance |
|---|---|---|
| Numeric subgoaling | `enhsp` | `hadd` |
| Numeric RPG | `metric-ff-cross-v1` | numeric `hFF` |
| Interval relaxation | `count-downward-agile` | `irhff` |
| Landmark cut | `planforge-ipc2026` | `lmcutnumeric()` |
| Symbolic pattern/SMT | `patty-ipc2026-agile-1` | JAIR pattern search + Z3 |
| Novelty + relaxation | `panino-lnp-agile` | novelty + `hadd` |
| Numeric heuristic search | `tamerlite-ipc2026-agile-1` | GBFS + `hadd` |
| Bounded SMT | `pattint-bitwuzla` | ARPG pattern + Bitwuzla |
| Numeric RPG | `tempest-numeric-ipc2026` | numeric `hFF` |
| Temporal/numeric RPG | `optic` | maintained CLP build |
| Temporal/numeric RPG | `optic-cplex` | local CPLEX static binary |
| Temporal/numeric RPG | `popf-static-v2` | local POPF Release 2 binary |
| Numeric LM-cut | `numeric-fast-downward-local` | `astar(lmcutnumeric)` |

`optic`과 `optic-cplex`는 알고리즘의 독립 표본이라기보다 LP backend/build 차이를
확인하는 쌍이다. 마찬가지로 전체 wildcard에는 동일 planner의 여러 search 설정이
포함되므로, 방법론 비교에는 위처럼 명시적인 ID 목록을 사용한다.

## 로컬 제공 artifact

| planner ID | 파일 |
|---|---|
| `optic-cplex` | `local/optic-cplex` |
| `popf-static-v2` | `local/popf` |
| `numeric-fast-downward-local` | `local/numeric-fast-downward/` |

세 ID 모두 공통 runner에 등록돼 있다. `popf-static-v2`는 사용자 Ubuntu host에서
실행 확인된 32-bit static binary이며 sandbox 환경에 따라 직접 smoke test가 막힐 수
있다. 생성된 plan은 batch runner가 VAL로 검증한다.

## 상태 확인

```bash
planners/plannerctl list
planners/plannerctl status optic-cplex
planners/plannerctl status popf-static-v2
planners/plannerctl status numeric-fast-downward-local
scripts/run/benchmarkctl planners
```

`batch=true`는 실행 및 plan 검증을 통과해 wildcard 대상이라는 뜻이다.
`verified-cli`, `validation-flaky`, `host-blocked`, `build-blocked` 항목은 확보돼 있어도
기본 batch에는 포함하지 않는다.

## 다른 컴퓨터에 설치

대용량 source·binary·runtime은 Git에서 제외한다. 현재 13개 실험 환경을 그대로
옮기는 방법과 공개 source 재빌드 절차는
[`docs/10_플래너_자료/10_13개_플래너_다운로드와_설치.md`](../docs/10_플래너_자료/10_13개_플래너_다운로드와_설치.md)에 정리한다.

## Numeric Cartesian CEGAR (ICAPS 2026)

`numeric-cegar`는 논문 배포본의 별도 runtime이다. 기존 13개 비교군 설정은 유지한다.
GUI, `plannerctl`, batch adapter와 논문 465개 문제용 로컬 runner에 연결돼 있다.
[빌드·실행 안내](../docs/10_플래너_자료/11_Numeric_Cartesian_CEGAR_실행.md)를 참고한다.

## Hybrid LP–RPG (LPRPG)

`lprpg`는 ICAPS 2008 Hybrid LP–RPG의 Public Release 2를 현대 Ubuntu에서
빌드한 별도 runtime이다. GUI와 `plannerctl`에서 선택할 수 있지만, 논문 구현이
가정하는 producer–consumer numeric fragment 밖에서는 동작을 보장하지 않으므로
기본 batch 비교군에는 넣지 않았다.

```bash
./scripts/setup_lprpg.sh
./planners/plannerctl status lprpg
./planners/plannerctl run lprpg /absolute/domain.pddl /absolute/problem.pddl
```

[설치·실행 및 호환성 안내](../docs/10_플래너_자료/12_LPRPG_설치와_실행.md)를 참고한다.
