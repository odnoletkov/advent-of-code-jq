[inputs | scan("(.) (.*) ") | .[1] |= tonumber]
| (
  reduce .[] as [$d, $l] (
    [];
    .[0] as $p | .[0] += {D:$l,U:-$l}[$d] + 0
    | .[1] += ($p + .[0]) * ({R:$l,L:-$l}[$d] + 0)
  ) | .[1] | fabs/2
) + (map(.[1]) | add/2) + 1
