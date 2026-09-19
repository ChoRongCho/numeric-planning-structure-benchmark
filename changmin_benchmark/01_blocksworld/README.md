# 01 Blocksworld: Classical Control Domain

## 역할

Blocksworld는 numeric fluent가 핵심 제약으로 작동하지 않는 순수 classical
manipulation 대조군이다. `pickup`, `putdown`, `unstack`, `stack`에서 삭제되는
`handempty`, `clear`, 위치 정보가 delete relaxation에 어떻게 반영되는지 확인한다.

02~06처럼 로봇 실행시간을 세분화하지 않고 모든 행동 비용을 1로 둔다.

```lisp
(:metric minimize (total-cost))
```

따라서 최소 action cost와 최소 plan length가 같다.

## 현재 모델

- 하나의 gripper
- 여러 block과 table 위치
- 한 번에 block 하나만 파지
- clear block/table에만 배치 가능
- 초기 stack을 목표 stack으로 재배열

## 생성기

```bash
# p001~p004와 초기/목표 PNG 생성
./changmin_benchmark/01_blocksworld/generator.py

# instance를 파싱하여 README 요약표 갱신
./changmin_benchmark/01_blocksworld/generator.py --summarize
```

`generator.py`의 `BENCHMARK_PROFILES`와 문제 번호별 seed로 동일한 문제를
재현한다. Stack은 bottom-to-top 순서로 생성되며, 모든 block은 초기와 목표에서
정확히 한 위치에 존재한다.

## p001~p004 progression

| Problem | Blocks | Tables | Initial stacks | Goal stacks |
|---|---:|---:|---:|---:|
| p001 | 3 | 3 | 1 | 1 |
| p002 | 5 | 3 | 2 | 2 |
| p003 | 7 | 3 | 3 | 2 |
| p004 | 9 | 3 | 3 | 3 |

모든 문제에 다음 초기값과 metric을 동일하게 적용한다.

```lisp
(= (total-cost) 0)
(:metric minimize (total-cost))
```

Blocksworld에는 연료, 배터리, 용량 같은 numeric 자원을 추가하지 않는다. Assembly와
비교할 때 classical symbolic baseline이라는 역할을 보존한다.

## 생성 및 smoke test 결과

p001~p004 모두 VAL parser에서 error 0, warning 0을 확인했다. 다음은 최적성 증명이
아니라 생성 직후의 first-plan 결과다. 모든 action cost가 1이므로 plan actions와
metric 값이 같다.

| Problem | Metric-FF actions/cost | ENHSP actions/cost | ENHSP expanded |
|---|---:|---:|---:|
| p001 | 8 | 8 | 14 |
| p002 | 16 | 20 | 64 |
| p003 | 28 | 30 | 869 |
| p004 | 30 | 42 | 869 |

두 planner 모두 네 문제에서 첫 plan을 찾았다. 반환 plan의 정식 VAL validation과
reference plan 보관은 전체 24개 instance 검증 단계에서 함께 수행한다.

<!-- AUTO-GENERATED-PROBLEM-SUMMARY:START -->
## 생성된 문제 요약

| Problem | Blocks | Tables | Initial stacks | Goal stacks |
|---|---:|---:|---:|---:|
| `p000` | 1 | 1 | 1 | 0 |
| `p001` | 3 | 3 | 1 | 1 |
| `p002` | 5 | 3 | 2 | 2 |
| `p003` | 7 | 3 | 3 | 2 |
| `p004` | 9 | 3 | 3 | 3 |

<!-- AUTO-GENERATED-PROBLEM-SUMMARY:END -->
