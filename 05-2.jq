[
  inputs
  | reduce
    {"F": 0, "B": 1, "L": 0, "R": 1}[split("")[]] as $b
    (0; . * 2 + $b)
]
| [range(min; max + 1)] - . | .[]
