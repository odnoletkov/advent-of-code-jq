reduce (
  inputs/" -> " | map(./"," | map(tonumber))
  | recurse(.[1:]; .[1])[:2] | transpose | map(sort)
) as [$y, $x] ([]; .[range($x[0]; $x[1] + 1)][range($y[0]; $y[1] + 1)] = "#")
| reverse | [recurse(
  (last(. as $m | [length, 500] | recurse(first(
    first -= 1 | last += (0, -1, 1) | select(first >= 0 and $m[first][last] == null)
  ))) | select(first > 0)) as $c | .[$c[0]][$c[1]] = "o"
)] | length - 1

# | transpose | transpose | .[][] |= (. // ".") | map(.[484:] | add)[]
