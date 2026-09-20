# YAML 기반 실험 실행

일반 실험에서는 [experiment.yaml](./experiment.yaml)만 수정하고 `./run`만
실행합니다. planner 이름이나 timeout을 매번 명령행에 입력할 필요가 없습니다.

```bash
cd scripts/run
./run
```

다른 설정 파일을 사용할 때만 YAML 경로를 전달합니다.

```bash
./run experiments/my_experiment.yaml
```

Changmin benchmark 6개에서 13개 planner의 지원 heuristic을 모두
실행하는 전용 실험은 다음과 같다.

```bash
./run_changmin_heuristics.sh p000  # 270-case 호환성 스모크
./run_changmin_heuristics.sh all   # p000~p004, 1,350 cases
```

이 실험은 `results.csv`에 configuration, heuristic, plan length,
wall time, expanded nodes, VAL objective value를 함께 기록한다.

## Delayed numeric conflict 2×2 실험

다음 명령은 모순이 나타나는 깊이(early/deep)와 그전까지 유지되는 분기 수(low/high)를
독립적으로 바꾼 synthetic PDDL 네 개를 생성한다. Exact state oracle, 감소 효과를
무시하는 reference GBFS, 실제 Metric-FF와 VAL 검증을 한 번에 실행한다.

```bash
./delayed_conflict_experiment.py
```

출력은 `results/delayed-conflict/<timestamp>/` 아래의 `results.csv`, `summary.md`, 각
variant의 PDDL·graph·planner log로 저장된다. Planner 없이 generator와 oracle만
검사하려면 `--skip-planner`를 사용한다.

```bash
./delayed_conflict_experiment.py --depth 6 --high-branching 2 --initial-fuel 2
./delayed_conflict_experiment.py --skip-planner
```

## 파일 구성

| 파일 | 사용 여부 | 역할 |
| --- | --- | --- |
| `experiment.yaml` | 사용자가 수정 | planner, domain, problem, 실행·저장 설정 |
| `run` | 사용자가 실행 | YAML을 읽어 모든 case 반복 실행 |
| `benchmarkctl` | 선택 | catalog 조회와 고급 CLI 실행 |
| `benchmark_core.py` | 내부 | timeout, 병렬 실행, 결과 기록, VAL 검증 |
| `planner_adapters.py` | 내부 | planner별 명령과 plan 출력 변환 |
| `generate_benchmark_manifest.py` | 필요할 때 실행 | benchmark catalog 재생성 |
| `run_up_engine.py` | 내부 | TamerLite/NextFLAP 실행 helper |
| `smoke_test_plannerctl.sh` | 설치 점검용 | planner runtime 전체 저수준 검사 |
| `delayed_conflict_experiment.py` | 가설 검증용 | early/deep × low/high generator, exact oracle, Metric-FF pilot |

## experiment.yaml 설정

기본 파일에는 모든 기본값이 생략되지 않고 명시되어 있습니다.

```yaml
schema_version: 1

experiment:
  name: "numeric-planner-example"

planners:
  - "enhsp"

tasks:
  - domain: "19_COUNTERS"
    problems:
      - "p001"

planner_arguments:
  enhsp: []

execution:
  timeout_seconds: 300
  parallel_jobs: 1
  max_cpu_cores: 2
  nice_level: 10
  memory_limit_mb: 8192
  max_processes_per_case: 256
  max_log_size_mb: 64
  monitor_interval_seconds: 0.2
  minimum_available_memory_mb: 4096
  force_unsupported: false
  dry_run: false
  fail_on_case_error: true

output:
  root: "results/raw"
  run_id: "auto"
  keep_work_directories: true

validation:
  plans: true

preflight:
  regenerate_manifest: false
  validate_pddl: true
```

### Planner 선택

복수 planner를 목록에 추가하면 각 task를 planner별로 반복합니다.

```yaml
planners:
  - "metric-ff"
  - "enhsp"
  - "tamerlite"
  - "patty"
```

`./benchmarkctl planners`는 batch 실행 가능 여부와 무관하게 등록된 runtime과
공식 탐색 구성을 모두 보여줍니다. 이 중 YAML 실험에 바로 사용할 수 있는
이름은 `batch=true`인 43개 항목입니다. 이 명령의 출력이 현재 목록의 단일
진실 공급원입니다.

모두 선택하려면 wildcard를 사용합니다.

```yaml
planners: ["*"]
```

`"*"`는 adapter가 있고 실제 plan 생성까지 검증된 batch planner만 선택합니다.
다운로드된 모든 소스를 뜻하지는 않습니다. `bitblast`는 compiler이며
Aries/FAPE/SAPA는 현재 PDDL batch 대상이 아니므로 포함하지 않습니다.

### 확보 수와 YAML ID 수가 다른 이유

현재 확보량과 실행 준비 상태는 서로 다른 숫자입니다.

| 구분 | 개수 | 의미 |
| --- | ---: | --- |
| 확보한 Git 소스 | 57 | planner, solver library, 도구, dataset 저장소 |
| 확보한 원본 archive/binary | 64 | IPC 배포본과 구버전 원본 포함 |
| 전체 확보 항목 | 121 | 위 두 종류의 합계 |
| YAML batch-ready 구성 | 40 | adapter, plan 추출, 실제 실행, VAL 검증 완료 |

등록 runtime/config 상태는 다음 명령으로 봅니다.

```bash
./benchmarkctl planners
```

- `verified-plan`, `batch=true`: YAML에서 실행 가능
- `verified-cli` / `verified-compiler`: 실행 파일은 확인했지만 현재 batch 대상 아님
- `host-blocked`: 현재 호스트의 32-bit 실행 제약
- `build-blocked`: legacy compiler 또는 32-bit ABI 때문에 build 차단
- `runtime-blocked`: build 후 bundled runtime 문제로 실행 차단

내려받은 Git 소스 57개와 정확한 revision/URL은 다음 명령으로 전부 봅니다.

```bash
./benchmarkctl sources
```

여기에는 POPF/OPTIC도 있습니다.

```text
popf-maintained
optic-maintained
optic-alt-fork
```

POPF와 OPTIC maintained fork는 이미 build·검증됐습니다. 별도 static
`optic-cplex` binary도 plan 생성과 VAL 검증 후 batch ID로 등록했습니다. POPF 1.1/2와
OPTIC original/CLP/GCC8 archive는 별도 보존 단위입니다. Numeric Fast
Downward, PlanForge, FerroPlan, Tempest 및 여러 IPC 2026 출전 구성도 이미
승격됐습니다. LNM-Plan은 build됐지만 회귀 검증 실패, RantanPlan/DiNo/
SMTPlan+/TFD 등은 의존성 또는 legacy runtime 검증 대상으로 남아 있어
`*`에 포함되지 않습니다.

### Domain과 problem 선택

각 domain에 서로 다른 problem 목록을 줄 수 있습니다.

```yaml
tasks:
  - domain: "19_COUNTERS"
    problems: ["p001", "p002", "p003"]

  - domain: "33_SAILING"
    problems: ["p001", "p005"]
```

모든 problem을 실행하려면 `"*"`를 사용합니다.

```yaml
tasks:
  - domain: "19_COUNTERS"
    problems: ["*"]
```

glob 패턴과 전체 경로도 사용할 수 있습니다.

```yaml
tasks:
  - domain: "benchmarks/19_COUNTERS/domain.pddl"
    problems:
      - "p00*"
      - "benchmarks/19_COUNTERS/instances/p010.pddl"
```

중복으로 선택된 problem은 한 번만 실행됩니다.

모든 domain의 `p001`만 실행할 수도 있습니다.

```yaml
tasks:
  - domain: "*"
    problems: "p001"
```

`domain: "**"`도 모든 domain과 같은 의미입니다. 따라서 모든 planner로 모든
domain의 첫 문제를 실행하려면 다음처럼 씁니다.

```yaml
planners: ["*"]

tasks:
  - domain: "**"
    problems: "p001"
```

### Planner 추가 인자

adapter가 만드는 기본 명령 뒤에 planner 고유 인자를 추가할 수 있습니다.

```yaml
planner_arguments:
  enhsp: []
  metric-ff: ["-s", "0"]
```

### 실행 설정

```yaml
execution:
  timeout_seconds: 300       # problem 하나의 제한시간
  parallel_jobs: 1           # 동시 실행 개수; 대규모 실험은 1 권장
  max_cpu_cores: 2           # runner와 모든 planner가 사용할 최대 논리 CPU 수
  nice_level: 10             # CPU 우선순위(0=기본, 19=가장 낮음)
  memory_limit_mb: 8192      # case의 전체 process group 합산 RSS 제한(MiB)
  max_processes_per_case: 256 # 비정상적인 자식 process 폭증 제한
  max_log_size_mb: 64        # planner.log 크기 제한(MiB)
  monitor_interval_seconds: 0.2 # 자원 사용량 검사 주기
  minimum_available_memory_mb: 4096 # 시작에 필요한 최소 가용 RAM(MiB)
  force_unsupported: false   # 미지원 조합 강제 실행 여부
  dry_run: false             # true이면 planner를 실행하지 않음
  fail_on_case_error: true   # 실패 case가 있으면 run도 실패 처리
```

`max_cpu_cores`는 Linux CPU affinity를 사용하므로 planner가 내부적으로 여러
스레드를 만들더라도 지정한 수의 논리 CPU 안에서만 실행됩니다. `nice_level`은
runner와 자식 planner의 CPU 스케줄링 우선순위를 함께 낮춥니다. 두 설정은
생략할 수 있으며, 생략하면 현재 프로세스의 affinity와 우선순위를 유지합니다.

`memory_limit_mb`와 `max_processes_per_case`는 planner의 process group 전체를
`/proc`에서 주기적으로 합산해 감시합니다. 제한을 넘기면 해당 case의 자식
프로세스를 모두 종료하고 결과 상태를 각각 `memory-limit`, `process-limit`으로
기록합니다. `max_log_size_mb` 초과는 `output-limit`으로 기록합니다. 이것은
0.2초 간격의 watchdog이므로 kernel cgroup처럼 순간적인 초과까지 원자적으로
차단하는 hard limit은 아니지만, 현재 runner에서 외부 권한 없이 사용할 수 있는
안전장치입니다. 대규모 실험은 `parallel_jobs: 1`을 유지해야 case별 8 GiB 제한이
곧 전체 planner 작업의 8 GiB 제한이 됩니다.

### 저장 설정

```yaml
output:
  root: "results/raw"          # 프로젝트 루트 기준 기본 위치
  run_id: "auto"               # 실험명과 시각으로 자동 생성
  keep_work_directories: true  # 실행에 사용한 PDDL 사본 보존
```

`run_id`를 직접 고정할 수도 있습니다. 같은 이름이 이미 있으면 기존 결과를
덮어쓰지 않고 `-2`, `-3`을 붙입니다.

### 검증과 사전 검사

```yaml
validation:
  plans: true

preflight:
  regenerate_manifest: false
  validate_pddl: true
```

- `plans`: planner 출력을 plan으로 추출한 뒤 VAL로 검증
- `validate_pddl`: 실험 전에 전체 benchmark 문법 검사
- `regenerate_manifest`: PDDL을 변경한 경우 catalog 자동 재생성

## 반복 실행 방식

planner 3개와 problem 20개를 선택하면 `3 × 20 = 60`개 case가 자동
생성됩니다. `parallel_jobs`만큼 동시에 실행하고 나머지는 계속 처리합니다.

```yaml
planners: ["metric-ff", "enhsp", "tamerlite"]

tasks:
  - domain: "19_COUNTERS"
    problems: ["*"]

execution:
  timeout_seconds: 300
  parallel_jobs: 4
  force_unsupported: false
  dry_run: false
  fail_on_case_error: true
```

## 결과 구조

```text
results/raw/<run-id>/
  experiment.yaml        # 실행 당시 YAML 사본
  manifest.json          # 실제 실행 metadata
  results.csv            # 전체 case 요약
  terminal.log           # 터미널 진행 상황과 case별 실행시간
  cases/<planner>/<domain>/<problem>/
    command.json
    planner.log
    resource.txt
    result.json
    plan.val
    validation.log
    work/
```

`results.csv`에는 상태, 실행시간, 최대 메모리, plan 길이, metric 값과 VAL 검증
결과가 기록됩니다.

터미널의 각 완료 행에는 `wall_seconds`(해당 planner/problem 실행시간)와
`elapsed_seconds`(실험 시작 이후 누적시간)가 표시됩니다. 같은 출력은 실행과
동시에 `terminal.log`에 저장되므로 별도의 `tee` 명령은 필요하지 않습니다.

## 권장 사용 순서

1. `experiment.yaml`에서 planner와 task를 수정합니다.
2. 처음에는 `problems: ["p001"]`로 실행합니다.
3. `./run`을 실행합니다.
4. 생성된 `results.csv`와 실패 case의 `planner.log`를 확인합니다.
5. 문제가 없으면 `problems: ["*"]`로 바꿔 전체 실험을 실행합니다.

PyYAML이 없는 환경에서는 한 번만 설치합니다.

```bash
python3 -m pip install -r requirements.txt
```

## 고급 명령

YAML 없이 즉석에서 한 번 실행해야 할 때만 `benchmarkctl`을 사용합니다.

```bash
./benchmarkctl list
./benchmarkctl planners
./benchmarkctl sources
./benchmarkctl validate-pddl
./benchmarkctl run --planner enhsp --benchmark 19_COUNTERS --instance p001
```

## Delayed-conflict 교차 분석

Barman stock 실험과 Watering·Logistics 2×2 실험을 같은 형식으로 다시 집계하고,
Metric-FF 로그의 evaluated states까지 복원하려면 다음을 실행합니다.

```bash
python3 scripts/run/analyze_delayed_conflict_evidence.py
```

결과는 기본적으로 `results/delayed-conflict/cross-domain-evidence/`에 생성됩니다.
`contrasts.csv`에는 paired comparison이, `summary.md`에는 해석과 한계가 기록됩니다.

Watering·Logistics 원본 action schema로 revelation position과 side branching을 직접
바꾸는 micro 실험은 다음처럼 실행합니다.

```bash
python3 scripts/run/delayed_conflict_domain_micro.py
python3 scripts/run/delayed_conflict_domain_micro.py \
  --planner numeric-fast-downward-local --heuristic irhadd --search astar
```

용량과 총소모량은 고정되며 early 조건은 두 번째 edge, deep 조건은 네 번째 edge에서
막힙니다. 생성된 problem과 planner별 원자료는
`results/delayed-conflict-domain-micro/`에 저장됩니다.
