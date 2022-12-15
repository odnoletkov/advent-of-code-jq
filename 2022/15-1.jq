[
  inputs | match("x=(-?\\d+), y=(-?\\d+).*x=(-?\\d+), y=(-?\\d+)").captures
  | map(.string | tonumber) | .[1,3] -= 2000000
] | (
  map(
    [((.[0] - .[2] | fabs) + (.[1] - .[3] | fabs) - (.[1] | fabs) + 1) * (-1, 1) + first]
    | .[0] += 1 | select(first < last) | [first, -1], [last, 1]
  ) | sort | reduce .[] as [$x, $d] (
    first;
    .[2] += ([0][.[1]] // $x - .[0]) | .[1] += $d | .[0] = $x
  ) | .[2]
) - (map(select(last == 0)[2:]) | unique | length)
