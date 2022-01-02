reduce (
  inputs
  | [match("(on|off) x=(-?\\d+)\\.\\.(-?\\d+),y=(-?\\d+)\\.\\.(-?\\d+),z=(-?\\d+)\\.\\.(-?\\d+)").captures[].string]
  | .[1:][] |= tonumber + 50
  | .[2, 4, 6] += 1
  | .[1:][] |= ([0, .] | max)
  | .[1:][] |= ([100, .] | min)
) as [$on, $x1, $x2, $y1, $y2, $z1, $z2] (
  [];
  .[range($x1; $x2)][range($y1; $y2)][range($z1; $z2)] = {off: 0, on: 1}[$on]
) | flatten | flatten | flatten | add
