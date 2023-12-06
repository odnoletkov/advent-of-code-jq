[inputs]
| (
  .[:-2] | map(./"")
  | map([add | match("\\S+").string | length] + .)
  | transpose
  | map([add | tostring | match("\\S+").string | length] + .)
  | transpose
) as $map
| reduce (.[-1] | scan("\\d+|R|L")) as $move (
  [1, (.[0] | match("\\.").offset + 1), 0];
  .[2] += {R: 1, L: -1}[$move] | .[2] %= 4
  | [[0, 1], [1, 0], [0, -1], [-1, 0]][.[2]] as [$y, $x]
  | reduce range($move | tonumber?) as $_ (
    .;
    (
      .[0] += $y | .[1] += $x
      | if all($map[.[0]][.[1]] != (".", "#"); .) then
        [., [($y, $x) * -$map[.[0] * (1 - ($y | fabs))][.[1] * (1 - ($x | fabs))], 0]]
        | transpose | map(add)
      else . end
      | select($map[.[0]][.[1]] != "#")
    ) // .
  )
)
| .[0] * 1000 + .[1] * 4 + .[2]

# | .[][:1] = [] | .[1:] | map(add)[]
