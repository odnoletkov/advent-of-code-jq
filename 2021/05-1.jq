[
  inputs/" -> " | map(split(",") | map(tonumber))
  | transpose | map([range(min; max + 1)])
  | select(map(length) | contains([1]))
  | (first[] | [.]) + (last[] | [.])
] | group_by(.) | map(select(length  >= 2)) | length
