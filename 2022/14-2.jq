reduce (
  inputs/" -> " | map(./"," | map(tonumber))
  | recurse(.[1:]; .[1])[:2] | transpose | map(sort)
) as [$y, $x] ([]; .[range($x[0]; $x[1] + 1)][range($y[0]; $y[1] + 1)] = "#")
| [[]] + reverse | [recurse(
  last(
    . as $m | [length - 1, 500] | recurse(first(
      first -= 1 | last += (0, -1, 1) | select(first >= 0 and $m[first][last] == null)
    ))
  ) as [$y, $x] | .[$y][$x] = "o";
  last | length == 0
)] | length
