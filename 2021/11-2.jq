[inputs/"" | map(tonumber)] | {map: .}
| [
  while(
    .flash | length != 100;
    .map[][] += 1 | .flash = [] | .new = [[]]
    | until(
      .new | length == 0;
      .new = [.map | paths(numbers > 9)] - .flash
      | .map = reduce .new[] as [$y, $x] (
        .map;
        .[$y + range(3) - 1 | select(. >= 0)][$x + range(3) - 1 | select(. >= 0)] |= (.//empty) + 1
      )
      | .flash += .new
    )
    | .map = reduce .flash[] as $f (.map; setpath($f; 0))
  )
] | length
