[inputs | [scan("-?\\d+") | tonumber]]
| [
  combinations(2)
  | [
    (reverse, .) as [[$x1, $y1, $_, $dx1, $dy1], [$x3, $y3, $_, $dx3, $dy3]]
    | $dx1 * $dy3 - $dy1 * $dx3
    | select(. != 0)
    | (($x3 - $x1) * $dy3 - ($y3 - $y1) * $dx3) / .
    | select(. > 0)
    | [$x1 + . * $dx1, $y1 + . * $dy1]
    | select(all((7 < . and . < 27) or (200000000000000 < . and . < 400000000000000)))
  ] | select(length == 2)
] | length/2
