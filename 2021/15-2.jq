[inputs/"" | map(tonumber)] | . as $risk
| length as $length
| ($length * 5) as $target
| def risk:
  $risk[first % $length][last % $length] + (first / $length | trunc) + (last / $length | trunc) | (. - 1) % 9 + 1;

{set: {"[0,0]": 0}}
| first(
  recurse(
    .visited as $visited
    | .next = (.set | to_entries | min_by(.value).key)
    | .set[.next] as $val
    | reduce (
      .next | fromjson
      | first += (-1, 1), last += (-1, 1)
      | select(all(. >= 0 and . < $target) and $visited[tostring] == null)
    ) as $n (
      .;
      .set[$n | tostring] |= ([. // 1e9, $val + ($n | risk)] | min)
    )
    | .visited[.next] = .set[.next]
    # | del(.set[.next])
    | .set[.next] |= empty
    # | if (.visited | length) % 1000 == 0 then ([.visited, .set | length] | debug) as $_ | . else . end
  ).visited[[$target - 1, $target - 1] | tostring] | select(.)
)
