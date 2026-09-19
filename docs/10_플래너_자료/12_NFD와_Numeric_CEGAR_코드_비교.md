# 기존 NFD와 Numeric Cartesian CEGAR 배포본 비교

검사일: 2026-09-19. 비교 대상은 이 PC의 실제 소스 두 개다.

- 기존: `planners/local/numeric-fast-downward/`
- 논문: `numeric-fast-downward/` (Zenodo 18999077 v1)

## 결론

같은 Numeric Fast Downward 기반이며, 기존 NFD로 이식할 수 있는 구조로 판단한다.
다만 CEGAR 폴더나 heuristic 등록만 복사하는 변경으로 끝나지 않는다. 논문 구현은
공유 numeric helper와 task 인터페이스에 의존한다. 이식·재빌드 검증은 이번 작업에서
수행하지 않았고, 두 소스는 변경하지 않았다.

GUI는 `nfd-cegar`으로 표시하며 내부 runtime ID
`numeric-cegar`를 유지한다. 기존 배포본은 `nfd`다. 두 항목은 독립 알고리즘
계열이 아니라 NFD의 서로 다른 배포본이다.

## 차이 규모

`src/`, `driver/`를 파일별 byte 비교했다. Python cache, object/static library,
CMakeFiles, 생성된 Bliss 실행 파일을 제외했다. 공통 경로의 텍스트 파일 661개 중
621개가 동일하고 40개가 다르다. 그중 16개가 `src/search/cegar/`에 있다.
40개에는 formatting, 주석 및 미사용 인자 정리도 포함되므로 모두 기능 변경은 아니다.

- `src/translate/`의 공통 파일은 동일하다. 기존 쪽에 regression PDDL 16개가 더 있다.
- `search_engine.cc`, `search_engines/eager_search.cc`는 동일하다.
- `numeric_pdbs/pattern_database.cc`는 동일하지만 공유 numeric helper는 다르다.
- `tasks/projected_task.cpp` → `tasks/projected_task.cc`는 내용이 같은 파일명 변경이다.
- 논문 쪽 신규 파일은 `tasks/predicate_abstracted_task.{h,cc}`와
  `utils/task_dump.{h,cc}`다(위 이름 변경 별도).

## 이식 시 함께 검토해야 할 부분

| 부분 | 관찰한 차이와 영향 |
|---|---|
| `cegar/` | NumericDomains, 수치 구간 분할, numeric refinement hierarchy 및 전이 처리 추가 |
| `cegar/additive_cartesian_heuristic.cc` | `verify_no_axioms` 대신 `verify_no_non_numeric_axioms`; 수치 axiom 허용 경로 |
| `numeric_pdbs/numeric_helper.{h,cc}` | numeric goal 추출, simple effect 검사, 정수 normalization 검사 및 numeric goal accessor 변경; PDB 등과 공유 |
| `numeric_pdbs/numeric_condition.h` | CEGAR 구간 변환이 쓰는 `get_compare_operator()` 추가 |
| `numeric_pdbs/arithmetic_expression.{h,cc}` | `is_simple()` 및 타입 정보 API 추가 |
| `numeric/interval.{h,cc}` | interval 포함 검사 overload와 const 인터페이스 추가 |
| `numeric/interval_add_heuristic.{h,cc}` | CEGAR가 호출하는 State 기반 평가 및 초기화 API 추가 |
| `task_proxy.h`, `abstract_task.*` | Fact accessor 및 출력 기능 추가 |
| `DownwardFiles.cmake`, 신규 task/debug 파일 | 빌드 등록과 부가 dependency |
| `open_lists/bucket_open_list.cc` | bucket 초기값이 `numeric_limits<ap_float>`에서 `numeric_limits<int>`로 변경 |

따라서 이식은 CEGAR와 실제 dependency를 선별 적용하고 기존 LM-cut/PDB/interval
구성도 회귀 검증해야 한다. 논문 배포본 전체를 기존 NFD에 덮어쓰면 공유 helper의
정수/simple-task 검사까지 바뀌므로 기존 지원 범위가 그대로 유지된다고 볼 수 없다.

동일 엔진에서 heuristic만 비교하려는 목적이라면 논문 배포본에서 CEGAR와 LM-cut,
PDB, interval heuristic을 함께 실행하는 방법도 있다. 앞선 설치 검증에서 논문
배포본의 blind, LM-cut, PDB/canonical PDB/iPDB와 CEGAR 변형 11개 설정은
counters/pfile1에서 VAL 검증을 통과했다. 기존 GUI NFD의 모든 옵션과 모든 도메인에
대한 동등성 검증을 의미하지는 않는다.

## 실제 실행 비교

동일한 `benchmarks-oo/counters/{domain,pfile1}.pddl`과 다음 옵션을 두 runtime에
각각 임시 작업 디렉터리에서 실행했다.

```text
astar(cegar(subtasks=[original()],pick=MIN_UNWANTED,max_time=10))
```

- 기존 `numeric-fast-downward-local`: exit 3,
  `This configuration does not support axioms!`로 종료.
- 논문 `numeric-cegar`: exit 0, 12-step plan, cost 12.

즉 기존 binary에도 `cegar` 이름은 등록돼 있지만 이 numeric 문제를 처리하는
논문 구현은 아니다. GUI에 옵션 이름만 추가하면 사용할 수 있다는 의미가 아니다.

## 내용이 다른 공통 텍스트 파일

- `driver/arguments.py`
- `driver/run_components.py`
- `src/search/DownwardFiles.cmake`
- `src/search/abstract_task.cc`
- `src/search/abstract_task.h`
- `src/search/cegar/abstract_state.cc`
- `src/search/cegar/abstract_state.h`
- `src/search/cegar/abstraction.cc`
- `src/search/cegar/abstraction.h`
- `src/search/cegar/additive_cartesian_heuristic.cc`
- `src/search/cegar/additive_cartesian_heuristic.h`
- `src/search/cegar/domains.cc`
- `src/search/cegar/domains.h`
- `src/search/cegar/refinement_hierarchy.cc`
- `src/search/cegar/refinement_hierarchy.h`
- `src/search/cegar/split_selector.cc`
- `src/search/cegar/split_selector.h`
- `src/search/cegar/subtask_generators.cc`
- `src/search/cegar/subtask_generators.h`
- `src/search/cegar/utils.cc`
- `src/search/cegar/utils.h`
- `src/search/heuristic.cc`
- `src/search/numeric/interval.cc`
- `src/search/numeric/interval.h`
- `src/search/numeric/interval_add_heuristic.cc`
- `src/search/numeric/interval_add_heuristic.h`
- `src/search/numeric_landmarks/bound_test.cc`
- `src/search/numeric_pdbs/arithmetic_expression.cc`
- `src/search/numeric_pdbs/arithmetic_expression.h`
- `src/search/numeric_pdbs/numeric_condition.h`
- `src/search/numeric_pdbs/numeric_helper.cc`
- `src/search/numeric_pdbs/numeric_helper.h`
- `src/search/open_lists/bucket_open_list.cc`
- `src/search/search_progress.cc`
- `src/search/state_registry.cc`
- `src/search/task_proxy.h`
- `src/search/task_tools.cc`
- `src/search/task_tools.h`
- `src/search/transformation/numeric_explicit_task.cc`
- `src/search/transformation/resource_transformation.cc`
