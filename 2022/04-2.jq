[
  inputs/","
  | map(split("-") | map(tonumber))
  | transpose | first |= max | last |= min
  | select(first <= last)
] | length
