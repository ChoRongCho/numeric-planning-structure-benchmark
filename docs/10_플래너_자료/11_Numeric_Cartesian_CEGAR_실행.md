# Numeric Cartesian CEGAR — ICAPS 2026 배포본

논문: [Cartesian Abstraction Refinement for Simple Numeric Planning](https://ai.dmi.unibas.ch/papers/schindler-et-al-icaps2026.pdf), Tanja Schindler, David Speck, Malte Helmert.
[공식 코드·벤치마크·실험 artifact](https://zenodo.org/records/18999077), v1.

사용자가 내려받은 원본을 아래 위치에 그대로 사용한다. 기존
`planners/local/numeric-fast-downward`와 별개의 구현이다.

| 경로 | 용도 |
|---|---|
| `numeric-fast-downward/` | 논문의 Numeric CEGAR 소스와 `builds/release64` 빌드 |
| `benchmarks-oo/` | 논문 배포 벤치마크 |
| `experiment-scripts/` | 원본 실험 스크립트 |

세 폴더는 외부 artifact로 Git에서 제외한다. 다른 PC에서는 위 artifact의
`numeric-fast-downward.zip`, `benchmarks.zip`, `experiment-scripts.zip`을 받아 같은
위치에 압축 해제한다(`benchmarks` 폴더는 `benchmarks-oo`로 둔다).
원본 소스와 실험 스크립트는 수정하지 않는다.

## 빌드와 단일 실행

프로젝트 루트에서 실행한다. Python 3, CMake, C++ compiler, make가 필요하다.

```bash
bash scripts/setup_numeric_cegar.sh

# 기본값: A* + CEGAR, MIN_UNWANTED, abstraction 생성 제한 900초
./planners/plannerctl run numeric-cegar \
  "$PWD/benchmarks-oo/counters/domain.pddl" \
  "$PWD/benchmarks-oo/counters/pfile1.pddl"
```

직접 실행 시 현재 작업 디렉터리에 `sas_plan`, `output.sas`, `output`이 생긴다.
여러 실행의 결과를 보존하려면 아래 local runner 또는 GUI를 사용한다.
`--search`를 명시하면 논문 소스의 다른 heuristic/search 설정도 전달할 수 있다.

GUI는 `./planner`로 열고 planner **nfd-cegar**, domain collection
**numeric-cegar-paper**를 선택한다. Refinement는 `MIN_UNWANTED`,
`MAX_UNWANTED`, `RANDOM`을 선택할 수 있다. Abstraction time은 heuristic 생성
시간이며 GUI의 전체 실행 timeout과 별개다.

## 논문 설정의 로컬 실행

원본 `experiment.py`는 Downward Lab, Git revision `main`, Basel Slurm 환경을
전제로 한다. 아래 runner는 원본을 실행·수정하지 않고 AST로 `CONFIG_NICKS`와
`DEFAULT_NUMERIC_SUITE`를 읽어 동일한 search 설정을 로컬에서 실행한다.
추가 Python 패키지나 Slurm, 소스 폴더의 Git 초기화가 필요 없다.

```bash
# 기본 smoke: counters/pfile1, cegar-min
python3 scripts/run/numeric_cegar.py

# 세 refinement 방식 비교
python3 scripts/run/numeric_cegar.py \
  --configs cegar-min cegar-max cegar-random \
  --domains counters mprime --timeout 60

# 논문 suite 465개 문제의 실행 목록 확인
python3 scripts/run/numeric_cegar.py --suite --problems '*.pddl' --dry-run

# 원본 11개 설정 전체 × 논문 suite (장시간 실험)
python3 scripts/run/numeric_cegar.py \
  --suite --problems '*.pddl' --configs all
```

`--configs all`에는 blind, CEGAR 3종 및 시간 무제한 변형 3종, LM-cut,
PDB, canonical PDB, iPDB가 포함된다. 기본 전체 실행 제한은 case당 wall time
1800초, memory 3947 MiB다. 저자의 Slurm CPU 시간 제한과 동일한 계측은 아니므로
논문 실행시간과 직접 비교할 때 구분한다. `--timeout`, `--memory-mb`로 조절한다.

각 실행은 `results/raw/numeric-cegar-*` 아래에 설정, 입력 hash, 로그, plan,
VAL 검증 결과와 `results.csv`를 저장한다. Timeout/unsupported/실패도 CSV에
남으며, 모든 case가 solved/valid일 때만 exit code 0이다(dry-run 제외).
기존 batch YAML의 `planners`에도 `numeric-cegar`를 추가할 수 있다.

## 지원 범위

논문은 integer-restricted simple numeric planning을 대상으로 한다.
일반 비선형 numeric PDDL 전체에 대한 지원을 뜻하지 않는다. CEGAR는 conditional
effects와 axioms를 지원하지 않는다. 현재 capability의 numeric 표시는 이런 세부
수치 제약을 모두 판별하지 않으므로 새 도메인은 작은 instance부터 검증한다.
일반 NFD README의 오래된 Python 2 안내와 달리 이번 배포본의 로컬 실행은 Python 3를 사용한다.

## 로컬 검증 기록 (2026-09-19)

- Release64 빌드 성공. 배포 ZIP의 소스 673개 파일을 비교해 수정이 없음을 확인했다.
- 원본 suite 465개 문제의 dry-run 성공(전체 해결 실험은 미실행).
- CEGAR min/max/random × counters/pfile1 및 mprime/pfile1: 6/6 solved, VAL valid.
- 논문 설정 11종 × counters/pfile1: 11/11 solved, VAL valid.
- 기존 batch runner의 changmin_04_watering/p000: solved, VAL valid.
- GUI 관련 unit test 11개 통과. 그래픽 창의 수동 조작 검증은 수행하지 않았다.

소스 hash와 결과 경로는 [artifact 기록](../../planners/locks/numeric-cegar-artifact.json)에 있다.
Setup 스크립트는 빌드 후 counters smoke/VAL 검증이 통과하면 runtime을
`verified-plan`으로 등록한다. 이 검증에는 저장소의 VAL 실행 파일이 필요하다.

기존 NFD와의 공통점·dependency 차이는 [소스 비교](12_NFD와_Numeric_CEGAR_코드_비교.md)에 정리했다.
