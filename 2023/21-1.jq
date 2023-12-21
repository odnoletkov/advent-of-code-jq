[inputs/""] | . as $map | [paths(. == "S")]
| nth(64; recurse(
  map(.[0] += (1, -1), .[1] += (1, -1)
  | select($map[.[0]][.[1]] != "#"))
  | unique
))
| length
