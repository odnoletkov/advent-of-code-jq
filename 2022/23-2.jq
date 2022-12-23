{
  dir: [[-1, 0], [1, 0], [0, -1], [0, 1] | [(.[] | select(. == 0)) += (-1, 0, 1)]],
  elves: [[inputs/""] | paths(. == "#")]
} | last(recurse(
  .count += 1 | .count as $offset
  | (reduce .elves[] as $e ([]; setpath($e | .[] += $offset; 1))) as $set
  | def sub: [.[] | select($set[first + $offset][last + $offset] == null)]; .
  | .dir as $dir | .elves[] |= [
    (
      select([first += (-1, 0, 1) | last += (-1, 0, 1)] | sub | length != 8)
      | first(
        [.] + $dir[] | .[][0] += first[0] | .[][1] += first[1]
        | .[1:] | sub | select(length == 3)[1]
      )
    ),
    .
  ]
  | select(any(.elves[]; length > 1))
  | .elves |= (group_by(first) | map(if length == 1 then map(first) else map(last) end) | flatten(1))
  | .dir |= .[1:] + .[:1]
)).count + 1
