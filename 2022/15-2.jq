[
  inputs | match("x=(-?\\d+), y=(-?\\d+).*x=(-?\\d+), y=(-?\\d+)").captures | map(.string | tonumber)
  | [.[0] + (-1, 1) * .[1] + (-1, 1) * ((.[0] - .[2] | fabs) + (.[1] - .[3] | fabs))] | [.[:2], .[2:]]
] | .[] += (
  map(.[0][] -= 1 | .[1][] += 1) | flatten(1) | transpose
  | map(group_by(.) | map(select(length > 1)[0])) | combinations | [.]
) | select(map(transpose | map(last != sort[1]) | any) | all)[0][-1]
| [(add, .[1] - .[0])/2] | select(all(0 <= . and . <= 4000000)) | .[0] * 4000000 + .[1]
