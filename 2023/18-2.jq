reduce (
  inputs | [
    [0, 1, 0, -1, 0][.[-2:-1] | tonumber + (0, 1)],
    reduce (.[-7:-2] | explode[] - 48) as $n (0; . * 16 + $n % 39)
  ]
) as [$y, $x, $l] (
  .; .y += $y * $l | .s += .y * $x * $l - $l/2
) | .s | fabs + 1
