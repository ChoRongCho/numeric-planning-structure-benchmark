# Delayed numeric conflict 2×2 result

| Variant | Depth | Branching | False-finite | Reference expanded | Metric-FF | VAL | Metric-FF expanded |
|---|---:|---:|---:|---:|---|---|---:|
| early-low | 3 | 1 | 1 | 10 | solved | valid | 12 |
| early-high | 3 | 2 | 2 | 11 | solved | valid | 16 |
| deep-low | 6 | 1 | 4 | 13 | solved | valid | 15 |
| deep-high | 6 | 2 | 30 | 39 | solved | valid | 72 |

`False-finite` means the exact oracle says the state cannot reach the goal,
while the decrease-ignoring relaxation still returns a finite value.
