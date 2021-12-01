[
  inputs |
  split("x") |
  map(tonumber) |
  (sort[:2] | add * 2) + reduce .[] as $s (1; . * $s)
] | add
