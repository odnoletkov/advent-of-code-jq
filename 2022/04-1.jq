[
  inputs/","
  | map(split("-") | map(tonumber))
  | select(any(.[] == (transpose | first |= max | last |= min); .))
] | length
