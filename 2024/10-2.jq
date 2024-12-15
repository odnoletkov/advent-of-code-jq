[inputs/"" | map(tonumber)]
| nth(4; recurse(.[][:0] = [-1] | transpose | reverse))
| . as $map
| reduce range(8; -1; -1) as $n (
  .[][] = 1;
  reduce ($map | paths(. == $n)) as $path (
    .;
    setpath(
      $path;
        [getpath($path | .[0] += (1, -1), .[1] += (1, -1) | select(. as $p | $map | getpath($p) == $n + 1))]
        | add
    )
  )
)
| [getpath(($map | paths(. == 0))) | length] | add
