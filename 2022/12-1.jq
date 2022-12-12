[inputs/""]
| (.[][] |= (({S: "a", E: "z"}[.] // . | explode[0]))) as $map
| paths(. == "E") as $en
| {
  front: [paths(. == "S")]
} | .front[0] as $f | .res = ([] | setpath($f; 0))
| until(
  .front | length == 0;
  .res[.front[0][0]][.front[0][1]] as $cur
  | .res as $res
  | .front = ([
    .front[]
    | $map[first][last] as $v | [first + 1, last], [first - 1, last], [first, last + 1], [first, last - 1]
    | select((first >= 0 and first < ($map | length)) and (last >= 0 and last < ($map[0] | length)) and $map[first][last] <= $v + 1 and $res[first][last] == null)
  ] | unique)
  | .res = reduce .front[] as $c (.res; setpath($c; $cur + 1))
)
.res[$en[0]][$en[1]]
