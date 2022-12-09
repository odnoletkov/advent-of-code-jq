[
  foreach (
    inputs/" "
    | {R:[1,0],L:[-1,0],U:[0,1],D:[0,-1]}[first] + (range(last | tonumber) | [])
  ) as [$x, $y] (
    [range(10) | [0, 0]];
    first[0] += $x | first[1] += $y
    | reduce range(length - 1) as $i (.;
      .[$i:$i + 2] |= [first[0] - last[0], first[1] - last[1]] as $d
        | if $d | any(fabs == 2) then
          last[0] += ($d[0] | significand) | last[1] += ($d[1] | significand)
        else . end
    );
    last
  )
] | unique | length
