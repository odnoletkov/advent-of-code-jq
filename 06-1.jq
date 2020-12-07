[
  [inputs]
  | join(",") | split(",,")[] | split(",")
  | map(split("")) | flatten(1) | unique | length
] | add
