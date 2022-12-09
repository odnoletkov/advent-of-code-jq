[
  foreach (
    inputs/" "
    | {R:[1,0],L:[-1,0],U:[0,1],D:[0,-1]}[first] + (range(last | tonumber) | [])
  ) as [$x, $y] (
    {tail: {x: 0, y: 0}};
    .head.x += $x | .head.y += $y
    | .d = [.head.x - .tail.x, .head.y - .tail.y]
    | if .d | any(fabs == 2) then
      .d[] |= significand | .tail.x += .d[0] | .tail.y += .d[1]
    else . end;
    .tail
  )
] | unique | length
