[
  inputs | [scan("(\\d+) (.)")] | group_by(last)
  | map(map(first | tonumber) | max) | .[0]*.[1]*.[2]
] | add
