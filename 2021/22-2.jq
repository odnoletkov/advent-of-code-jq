def intersect:
  transpose | first |= max | last |= min | select(first < last);
def intersect3:
  transpose | map(intersect) | select(length == 3);

reduce (
  inputs
  | [match("(on|off) x=(-?\\d+)\\.\\.(-?\\d+),y=(-?\\d+)\\.\\.(-?\\d+),z=(-?\\d+)\\.\\.(-?\\d+)").captures[].string]
  | .[1:][] |= tonumber
  | .[2, 4, 6] += 1
  | first |= {off: -1, on: 1}[.]
  | (.[5:7],.[3:5],.[1:3]) |= [.]
  | .[1:4] |= [.]
) as $n (
  [];
  . + [$n | select(first == 1)] + map(
    first *= -1 | last = ([last, $n[1]] | intersect3)
  )
  | group_by(last) | map([(map(first) | add), first[1]])
)
| .[][1] |= (map(last - first) | .[0] * .[1] * .[2])
| map(first * last) | add
