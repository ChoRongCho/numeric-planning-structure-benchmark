# Single-case planner GUI

한 개의 domain/problem에 planner configuration 하나를 실행하고 plan과 로그를
바로 확인하는 Tk GUI다. 외부 Python GUI package는 필요하지 않는다.

## 실행

프로젝트 루트에서 다음 한 줄을 실행한다.

```bash
./planner
```

`planner`는 프로젝트 루트의 짧은 실행 링크이고, 실제 구현은 계속
`src/planner_gui/` 아래에서 관리한다.

1. `benchmarks/`와 `changmin_benchmark/`를 합친 `Domain` 목록에서 하나를 고른다.
   Domain 이름 옆에는 `instances/`에 존재하는 `p*.pddl` 개수가 표시된다.
2. 선택한 domain에 실제로 존재하는 problem instance 목록에서 하나를 고른다.
3. planner를 고른다.
4. 해당 planner에서 실제 CLI로 선택 가능한 heuristic/search/기타 옵션을 고른다.
   고정된 IPC configuration은 combobox에 `고정`으로 표시된다.
5. `Plan`을 누른다.

카탈로그 밖의 PDDL은 `직접 선택…`으로 지정할 수 있다. 이 경우에도 domain 옆의
`instances/` 디렉터리를 스캔해 problem 목록을 자동 생성한다.

사용자 제공 artifact는 GUI에서 `optic-cplex`, `popf`, `nfd`로 표시한다. 재현성을
위한 내부 실행 ID는 각각 `optic-cplex`, `popf-static-v2`,
`numeric-fast-downward-local`이며 결과 파일에는 내부 ID가 기록된다.

실행 중 로그는 실시간으로 표시된다. 완료되면 추출된 plan과 VAL 검증 결과가
`Plan` 탭에 표시된다. 모든 산출물은 아래에 남는다.

화면 왼쪽 절반은 domain/problem/planner 설정 영역이고, 오른쪽 절반은 실행 명령과
`Plan`/`실행 로그` 탭이다. 가운데 경계선을 드래그해 두 영역의 폭을 조절할 수 있다.

```text
results/gui/<timestamp>-<planner-id>/
├── command.json
├── planner.log
├── plan.val
├── result.json
└── validation.log
```

`추가 인자`는 planner-specific 선택 뒤에 그대로 추가된다. shell을 사용하지 않고
`shlex`로 인자만 분리하므로 redirection이나 pipe는 지원하지 않는다.

기본값은 timeout 60초, CPU core 2개, nice level 10이다. `중지`는 planner의 전체
process group에 종료 신호를 보내므로 child solver도 함께 중지된다.

Numeric Cartesian CEGAR 논문 구현은 `nfd-cegar`으로 선택한다.
내부 실행 ID는 `numeric-cegar`로 유지한다.
`numeric-cegar-paper` collection은 `benchmarks-oo/`의 원본 문제를 제공한다.
[설치·실험 안내](../../docs/10_플래너_자료/11_Numeric_Cartesian_CEGAR_실행.md)
