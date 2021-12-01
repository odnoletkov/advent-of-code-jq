def intersection:
  reduce .[1:][] as $item (.[0] | unique; . - (. - $item));

[
  [inputs]
  | join(",") | split(",,")[] | split(",")
  | map(split("")) | intersection | length
] | add
