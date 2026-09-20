# Delayed numeric conflict 2×2 result

| Variant | Depth | Branching | False-finite | Reference expanded | Metric-FF | VAL | Metric-FF expanded |
|---|---:|---:|---:|---:|---|---|---:|
| early-low | 3 | 1 | 1 | 10 | solved | valid | — |
| early-high | 3 | 3 | 3 | 12 | crash | not-run | — |
| deep-low | 6 | 1 | 4 | 13 | solved | valid | — |
| deep-high | 6 | 3 | 120 | 129 | crash | not-run | — |

`False-finite` means the exact oracle says the state cannot reach the goal,
while the decrease-ignoring relaxation still returns a finite value.
