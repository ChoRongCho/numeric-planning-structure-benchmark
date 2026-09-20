# Delayed numeric conflict 2×2 결과

## 결과 읽는 법

- `early/deep`: 같은 총 연료 부족이 경로 초반/후반에 드러난다.
- `low/high`: 모순이 드러나기 전까지 선택 가능한 실패 경로가 적다/많다.
- `False-finite`: exact oracle은 dead end라고 판정하지만 감소를 무시한 relaxation은 유한한 값을 준 상태다.
- 네 조건 모두 하나의 별도 good route가 있어 전체 PDDL 문제는 solvable이다.

## 결과

| Variant | Depth | Branching | False-finite | Reference expanded | Metric-FF | VAL | Metric-FF expanded |
|---|---:|---:|---:|---:|---|---|---:|
| early-low | 3 | 1 | 1 | 10 | solved | valid | 12 |
| early-high | 3 | 2 | 2 | 11 | solved | valid | 16 |
| deep-low | 6 | 1 | 4 | 13 | solved | valid | 15 |
| deep-high | 6 | 2 | 30 | 39 | solved | valid | 72 |

## 첫 해석

- High branching에서 모순을 early에서 deep으로 옮기면 false-finite 상태가 2개에서 30개로 늘었다.
- 같은 비교에서 Metric-FF evaluated states는 16개에서 72개로 늘었다 (4.50배).
- Deep conflict에서 branching을 low에서 high로 바꾸면 Metric-FF evaluated states는 15개에서 72개로 늘었다 (4.80배).
- 이 결과는 synthetic 조작과 측정 pipeline의 sanity check이며 실제 domain 일반화 증거는 아니다.
