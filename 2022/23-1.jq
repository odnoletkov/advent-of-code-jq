{
  dir: [
    [-1, 0], [1, 0], [0, -1], [0, 1]
    | [(.[] | select(. == 0)) += (-1, 0, 1)]
  ],
  elves: [[inputs/""] | paths(. == "#")]
}

| nth(10; recurse(
  .dir as $dir
  | .elves as $elves
  | .elves[] |= [
    first(
      select([first += (-1, 0, 1) | last += (-1, 0, 1)] - $elves | length == 8),
      ([.] + $dir[] | .[][0] += first[0] | .[][1] += first[1] | .[1:] - $elves | select(length == 3)[1])
    ),
    .
  ]
  | .dir |= .[1:] + .[:1]
  | .elves |= (group_by(first) | map(if length == 1 then map(first) else map(last) end) | flatten(1))
)).elves

| (transpose | map(max - min + 1) | first * last) - length

# | (transpose | map(min)) as [$my, $mx] | reduce .[] as $e ([]; setpath($e | first -= $my | last -= $mx; "#")) | transpose | transpose | .[][] //= "." | map(add)
