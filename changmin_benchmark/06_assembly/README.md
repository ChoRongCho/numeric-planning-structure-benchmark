# 06 Assembly: Numeric Robotic Assembly

## 목적

로봇이 부품 선행관계, payload, 공구 호환성과 정확한 체결 작업량을 만족하면서 모든
제품을 조립하고 로봇과 공구를 정리하는 plan을 찾는다. 목적함수는 예상 실행시간
최소화다.

```lisp
(:metric minimize (total-assembly-time))
```

이는 planner의 계산시간이 아니라 로봇이 plan을 실행하는 데 걸리는 누적시간이다.

## 생성기

```bash
# p001~p004 PDDL과 PNG 생성
./changmin_benchmark/06_assembly/generator.py

# instance를 파싱하여 README 요약표 갱신
./changmin_benchmark/06_assembly/generator.py --summarize
```

- PDDL: `instances/pNNN.pddl`
- 조립 선행관계 그림: `images/pNNN.png`
- 문제별 설정: `generator.py`의 `BENCHMARK_PROFILES`

## 원본 ADL에서 바꾼 이유

기존 domain은 `forall`, `exists`, conditional effect로 resource commit과 조립 완료를
표현했다. 이 구조에 numeric까지 바로 결합하면 일부 planner의 ADL 미지원 때문에
실패할 수 있어 numeric heuristic의 한계와 언어 호환성 실패를 구별하기 어렵다.

현재 domain은 각 part가 최대 하나의 직접 predecessor를 갖는 조립 forest를 생성해
quantifier와 conditional effect 없이 선행관계를 표현한다. 원본의 조립 순서와
resource 선택 성격은 유지하면서 `:strips :typing :fluents` 범위로 제한했다.

## Symbolic 상태

- `part-available`, `holding-part`, `handempty`: 부품 파지 상태
- `part-of`, `first-part`, `predecessor`: 제품 구조와 조립 선행관계
- `placed`, `unfinished`, `fastened`: 조립 진행 단계
- `tool-available`, `tool-slot-empty`, `tool-mounted`: 공구 점유와 교체
- `compatible`: 부품과 공구의 호환성

부품을 집으려면 robot의 tool slot이 비어 있어야 한다. 따라서 단일 로봇은
`부품 pick/place → 공구 mount → 체결 → 공구 unmount` 순서를 거친다. 다중 로봇
instance에서는 한 로봇이 공구를 유지하고 다른 로봇이 부품을 배치하는 선택도 생긴다.

## Numeric 상태

| Fluent | 의미 | 역할 |
|---|---|---|
| `part-weight` | 부품 무게 | robot payload 이하일 때만 pick 가능 |
| `robot-payload` | 로봇 가반하중 | 무거운 부품의 robot 할당 제한 |
| `required-work` | 체결에 필요한 정확한 작업량 | part별 목표량 |
| `completed-work` | 현재까지 적용된 체결량 | tool 사용 시 증가 |
| `tool-work-step` | 공구 1회당 체결량 | 빠른/정밀 공구 차이 |
| `tool-operation-time` | 공구 1회 실행시간 | 공구 선택 비용 |
| `tool-change-time` | 공구 장착·해제시간 | setup 비용 |
| `total-assembly-time` | 누적 실행시간 | 최소화 목적함수 |

체결 action은 다음 상한을 지켜야 한다.

```lisp
(<= (+ (completed-work ?part) (tool-work-step ?tool))
    (required-work ?part))
```

`completed-work = required-work`일 때만 `inspect-and-finish`로 symbolic `fastened`
상태를 만들 수 있다. Generator는 step 1인 precision tool을 모든 part에 호환시켜
정확한 목표량을 항상 만들 수 있도록 보장한다.

## 공구 특성

| Tool | Work step | Operation time | Mount/unmount time |
|---|---:|---:|---:|
| precision | 1 | 2 | 1 |
| standard | 3 | 3 | 2 |
| power | 5 | 4 | 3 |
| high-torque | 7 | 5 | 4 |

큰 step 공구는 단위 작업량당 빠르지만 required work를 초과할 수 없다. 예를 들어
required work 8은 `5+3`, required work 9는 `5+3+1`처럼 조합할 수 있다. 하지만
공구를 바꾸면 mount/unmount 시간이 추가되므로 항상 가장 큰 step부터 쓰는 것이
최적이라는 보장은 없다.

## p001~p004 progression

| Problem | Parts | Products | Robots | Tools | Work range | 성격 |
|---|---:|---:|---:|---:|---:|---|
| p001 | 4 | 1 | 1 | 3 | 4~8 | 작은 단일 제품 기준선 |
| p002 | 6 | 1 | 1 | 3 | 5~10 | 더 깊고 넓은 precedence forest |
| p003 | 8 | 2 | 2 | 4 | 6~12 | 제품·로봇 할당과 공구 공유 결합 |
| p004 | 10 | 2 | 2 | 4 | 7~15 | 가장 큰 symbolic/numeric 결합 문제 |

## 난이도 조절 가이드라인

### 1. 선행관계 깊이와 폭

- Chain이 길면 다음 부품을 배치하기 전에 이전 체결을 끝내야 한다.
- Branch가 넓으면 적용 가능한 다음 part가 많아져 선택지가 증가한다.
- 동일 part 수에서 chain과 wide tree를 비교해야 객체 수 효과와 precedence 효과를
  분리할 수 있다.

### 2. 작업량과 tool step의 정합성

- Easy: required work가 빠른 tool step과 정확히 일치한다.
- Medium: 빠른 tool과 precision tool을 조합해야 한다.
- Hard: 여러 조합이 가능하지만 operation+change time의 최적 조합이 다르다.

Required work 범위만 키우면 plan 길이도 함께 증가하므로, node expansion을 해석할 때
최소 필요 fastening 횟수를 같이 기록한다.

### 3. Payload tightness

- Loose: 모든 robot이 모든 part를 들 수 있다.
- Medium: 일부 무거운 part는 고용량 robot만 들 수 있다.
- Tight: 선행관계의 특정 구간이 고용량 robot에 집중된다.

Payload는 현재 감소하지 않는 정적 numeric gate다. 따라서 payload 실험은 소모성
자원보다 numeric comparison이 grounding과 helpful action에 미치는 영향을 본다.

### 4. 공구 호환성과 교체시간

- 호환 공구가 하나면 선택은 적지만 반복 체결이 늘 수 있다.
- 호환 공구가 여러 개면 branching과 numeric 조합 선택이 증가한다.
- Change time이 크면 한 공구를 오래 유지하는 plan이 유리하다.
- Operation time만 바꾸고 change time을 고정한 대조군으로 두 효과를 분리한다.

### 5. 로봇 수와 공유 공구

두 로봇이 있어도 동일 공구는 동시에 장착할 수 없다. Robot 수 증가는 가능한 할당을
늘리지만 tool availability mutex도 함께 만든다. Classical sequential plan이므로
병렬 makespan을 측정하는 모델은 아니며, 여러 로봇의 역할 분담과 setup 감소를
표현한다.

## 권장 대조군

| 실험군 | Time metric | Payload | Numeric work | Tool alternatives |
|---|---|---|---|---|
| A0 | 없음 | symbolic/없음 | 없음 | 단일 symbolic tool |
| A1 | 있음 | loose | 없음 | 있음 |
| A2 | 있음 | varied | 있음 | 있음 |
| A3 | 있음 | tight | 있음 | 많음 |

기본 p001~p004는 A2 계열의 크기 progression이다. A0~A3 인과 비교에서는 동일한
precedence graph와 part 수를 유지하고 한 축만 바꿔야 한다.

## 연구 관점

Assembly의 핵심은 **symbolic precedence 및 tool setup과 exact numeric completion의
결합**이다. Relaxation이 부품을 잡을 때 사라지는 `handempty`, 공구 장착 시 사라지는
`tool-available/tool-slot-empty`를 약화하면 실제보다 공구와 로봇을 자유롭게 사용할
수 있는 것처럼 볼 수 있다. 동시에 bounded numeric progress 때문에 빠른 tool을
무조건 반복할 수 없으며 마지막 잔여 작업량을 맞추기 위한 공구 선택이 필요하다.

다음 항목을 기록한다.

- plan 실행시간과 action 수
- robot별 pick 수와 무거운 part 할당
- tool별 mount/unmount 및 fastening 횟수
- precision tool로 처리한 잔여 작업량
- initial heuristic과 최종 metric 차이
- expanded/evaluated states, dead ends, timeout

## 생성 및 smoke test 결과

p001~p004 모두 VAL parser에서 error 0, warning 0을 확인했다. 아래는 최적성
증명이 아니라 생성된 instance의 실행 가능성과 난이도 증가를 확인한 first-plan
결과다.

| Problem | Metric-FF actions | Metric-FF time | ENHSP actions | ENHSP time |
|---|---:|---:|---:|---:|
| p001 | 35 | 90 | 37 | 90 |
| p002 | 56 | 143 | — | — |
| p003 | 76 | 210 | — | — |
| p004 | 81 | 249 | 85 | 261 |

Metric-FF는 네 문제 모두 0.01초 미만에 첫 해를 찾았다. ENHSP `hadd + WA*`는
p001을 약 0.02초, p004를 약 1.16초에 풀었으며 p004에서 21,980 nodes를 확장했다.

<!-- AUTO-GENERATED-PROBLEM-SUMMARY:START -->
## 생성된 문제 요약

| Problem | Parts | Products | Robots | Tools | Part weight | Required work | Payload |
|---|---:|---:|---:|---:|---:|---:|---:|
| `p001` | 4 | 1 | 1 | 3 | 3–7 | 5–7 | 8–8 |
| `p002` | 6 | 1 | 1 | 3 | 4–9 | 5–9 | 9–9 |
| `p003` | 8 | 2 | 2 | 4 | 3–10 | 6–12 | 6–10 |
| `p004` | 10 | 2 | 2 | 4 | 3–11 | 7–15 | 8–12 |

<!-- AUTO-GENERATED-PROBLEM-SUMMARY:END -->
