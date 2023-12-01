[inputs/"" | map(tonumber)] | . as $risk
| {set: {"[0,0]": 0}}
| first(
  recurse(
    .visited as $visited
    | .next = (.set | to_entries | min_by(.value).key)
    | reduce (
      .next | fromjson
      | first += (-1, 1), last += (-1, 1)
      | select(all(. >= 0) and $risk[first][last] != null and $visited[tostring] == null)
    ) as [$y, $x] (
      .;
      .set[.next] as $val |
      .set[[$y, $x] | tostring] |= ([. // 1e9, $val + $risk[$y][$x]] | min)
    )
    | .visited[.next] = .set[.next]
    | .set[.next] |= empty
  ).visited[last($risk | paths(scalars)) | tostring] | select(.)
)
