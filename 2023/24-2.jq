[inputs | [scan("-?\\d+") | tonumber]]
| [
  map([.[:3], .[3:]] | transpose) | transpose[]
  | group_by(.[1]) | map(combinations(2)) as $pairs
  | range(1000) - 500
  | select(. as $v | $pairs | all((.[0][0] - .[1][0]) % ($v - .[0][1] | select(. != 0)) == 0))
] as [$vx, $vy, $vz]
| .[][3] -= $vx | .[][4] -= $vy | .[][5] -= $vz
| . as [[$x1, $y1, $z1, $vx1, $vy1, $vz1], [$x2, $y2, $_, $vx2, $vy2]]
| (($x2 - $x1) * $vy2 - ($y2 - $y1) * $vx2) / ($vx1 * $vy2 - $vy1 * $vx2)
| $x1 + $y1 + $z1 + ($vx1 + $vy1 + $vz1) * .
