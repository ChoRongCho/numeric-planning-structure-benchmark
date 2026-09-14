# Source Code

코드가 생기면 역할별 Python package로 확장합니다.

```text
src/
├── benchmark/   # instance 생성과 feature 추출
├── evaluation/  # planner 실행, metric, 결과 수집
├── analysis/    # ranking, plateau, heuristic error 분석
├── planner_gui/ # 단일 domain/problem GUI 실행기
└── utils/       # 공통 유틸리티
```

초기에는 실제로 필요한 모듈만 만들고 빈 package는 만들지 않습니다.

현재 구현된 `planner_gui/`는 domain, problem, planner, heuristic와 search 옵션을
선택해 단일 planning case를 실행하고 plan/로그/VAL 결과를 보여줍니다.
