[
  input
  | match("target area: x=(-?\\d+)\\.\\.(-?\\d+), y=(-?\\d+)\\.\\.(-?\\d+)").captures[].string
  | tonumber
] as [$x1, $x2, $y1, $y2]
| [
  {
    vy: range($x2/2 | trunc; $y1 - 1; -1),
    vx: range($x2 + 1),
    x: 0, y: 0,
  } | first(
    recurse(
      .x += .vx
      | .y += .vy
      | .vx |= if . > 0 then . - 1 elif . < 0 then . + 1 else 0 end
      | .vy -= 1
      | .hit = .hit or (.x >= $x1 and .x <= $x2 and .y >= $y1 and .y <= $y2)
    ) | select(.hit or .x > $x2 or .y < $y1)
  ) | select(.hit) | 1
] | length
