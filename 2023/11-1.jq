[inputs]
| [., (map(./"") | transpose | map(add)) | map((match("#") | 0) // 1)] as [$y, $x] | .
| [to_entries[] | [.key] + (.value | match("#"; "g") | [.offset])]
| [
  combinations(2) | transpose | map(sort)
  | .[0][1] - .[0][0] + ($y[.[0][0]:.[0][1]] | add) + .[1][1] - .[1][0] + ($x[.[1][0]:.[1][1]] | add)
]
| add/2
