[inputs/"" | map(tonumber)]
| nth(4; recurse(.[][:0] = [-1] | transpose | reverse))
| . as $map
| reduce range(9; -1; -1) as $n (
  .;
  reduce ($map | paths(. == $n)) as $path (
    .;
    setpath(
      $path;
      if $n == 9 then
        [$path]
      else
        [getpath($path | .[0] += (1, -1), .[1] += (1, -1) | select(. as $p | $map | getpath($p) == $n + 1))[]]
        | unique
      end
    )
  )
)
| [getpath(($map | paths(. == 0))) | length] | add
