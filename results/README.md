# Results

- `raw/`: planner가 출력한 변경하지 않은 결과
- `processed/`: 분석 가능한 정규화 데이터
- `tables/`: 논문·보고서용 표
- `figures/`: 논문·보고서용 그림

대용량 생성 결과는 Git에 넣지 않고, 각 실험의 설정과 seed로 재현합니다.

통합 실행은 `scripts/run/benchmarkctl`을 사용합니다. 각 실행은
`raw/<run-id>/results.csv`와 case별 원본 로그, resource 사용량, 추출 plan,
VAL 검증 결과를 생성합니다. 자세한 사용법은 `docs/benchmark_execution.md`에
정리되어 있습니다.
