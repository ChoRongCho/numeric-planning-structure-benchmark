# LPRPG 설치와 실행

## 무엇을 설치했는가

LPRPG Public Release 2는 ICAPS 2008의 Hybrid LP–RPG heuristic을 구현한 원본
플래너다. Relaxed planning graph의 명제 도달성과 LP의 수치 resource flow를 함께
사용한다. 원본 archive와 논문 배포 파일은 다음 위치에 보존했다.

| 자료 | 위치 | SHA-256 |
|---|---|---|
| LPRPG 0.2 source | `planners/archives/lprpg/lprpg-0.2.tar.bz2` | `aaefab79fe995ad7877baf5625d0d01ac2dd853e1b6efc2363b2caadcdab6716` |
| LPRPG-P IPC 2011 | `planners/archives/lprpg/lprpgp-ipc2011.tar.bz2` | `77bc53ea6765a771586620a2a0cdf0d8311084da0eb2a4abf6d81ae0d9b91c00` |
| ICAPS 2008 paper package | `planners/archives/lprpg/lprpg-icaps2008.tar.gz` | `419792129b9733fe8c8ad7b577ef413af9f85815d76828bdcd5667b33bb2a817` |

LPRPG-P는 CPLEX 12.1에 묶인 별도 preferences 플래너라서 이번 runtime에는
포함하지 않았다. 현재 GUI의 `LPRPG`는 Public Release 2다.

## 다시 설치하기

Ubuntu에 64-bit LP Solve shared library와 C++ 빌드 도구, Flex, Bison이 있어야 한다.
설치 스크립트는 archive checksum을 검사하고, 오래된 C++ 문법과 parser 생성을
현대 toolchain에 맞게 패치한 뒤 격리 runtime을 만든다.

```bash
./scripts/setup_lprpg.sh
./planners/plannerctl status lprpg
```

기본 LP Solve 위치가 다르면 다음처럼 지정한다.

```bash
LPSOLVE_SO=/path/to/liblpsolve55.so ./scripts/setup_lprpg.sh
```

완성된 실행 파일과 library는 각각
`planners/runtime/lprpg/bin/lprpg`, `planners/runtime/lprpg/lib/`에 놓인다.
실행 파일의 rpath가 이 격리 library를 가리키므로 이후에는 시스템 설치 위치에
의존하지 않는다.

## 실행하기

GUI는 프로젝트 루트에서 실행한다.

```bash
./planner
```

Planner에서 `LPRPG`, Heuristic에서 `lp-rpg`를 고른다. `Fragment handling`의
기본값 `strict (safe)`는 지원 fragment를 위반한 입력에서 실행을 중단한다.
`force (experimental)`는 원본의 `-plananyway` 옵션이며 crash나 잘못된 guidance가
가능하므로 결과를 baseline으로 쓰기 전에 반드시 VAL 검증이 필요하다.

CLI에서는 절대 경로를 사용한다.

```bash
./planners/plannerctl run lprpg /absolute/domain.pddl /absolute/problem.pddl
```

## 지원 범위와 현재 확인 결과

이 구현의 LP heuristic은 각 numeric fluent가 producer–consumer resource처럼
변하는 구조를 전제로 한다. 다른 fluent 값에 따라 변화량이 정해지는 효과,
복잡한 assignment, 이 전제를 깨는 증감 조합에서는 보장을 제공하지 않는다.

작은 producer–consumer numeric smoke problem은 계획을 생성했고 공통 adapter로
추출한 계획도 VAL에서 `valid`였다. Changmin benchmark의 `p000` strict 실행은
다음과 같았다.

| Domain | 결과 | 해석 |
|---|---|---|
| Books | 계획 생성, VAL valid | strict 실행 가능 |
| Assembly | 계획 생성, VAL valid | strict 실행 가능 |
| Barman | fragment 위반 경고 후 중단 | `liquid-volume`의 non-constant effect |
| Watering | signal 11 | 원본 구현 crash; 실험 제외 필요 |
| Blocksworld | parser 중단 | 오래된 parser가 `:numeric-fluents` requirement를 받지 않음 |
| Logistics | parser 중단 | 오래된 parser가 `:numeric-fluents` requirement를 받지 않음 |

Barman에 `force`를 적용한 시험도 signal 11로 종료됐다. 따라서 현 상태에서
LPRPG는 “goal에서 필요한 수치 resource를 LP로 역방향 반영하는 방법이 있는가”를
검증하는 역사적 구현이며, 여섯 domain 전체에 그대로 적용할 공통 baseline은 아니다.
기본 batch 대상에서 제외한 이유도 이 호환성 차이다.
