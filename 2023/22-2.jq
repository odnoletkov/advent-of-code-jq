[inputs/"~" | map(./"," | map(tonumber)) | transpose] | sort_by(.[2][1])
| reduce to_entries[] as {$key, value: [$x, $y, $z]} (
  {stack: [[[[0, 9], [0, 9]]]]};
  first(
    .stack
    | (length - range(length) - 1) as $level
    | [.[$level][]? | select($x[1] < .[0][0] or .[0][1] < $x[0] or $y[1] < .[1][0] or .[1][1] < $y[0] | not)[2]]
    | select(length > 0)
    | [$level, .]
  ) as [$level, $ids]
  | .hold[$ids[]]? += [$key]
  | .stack[$level + $z[1] - $z[0] + 1] += [[$x, $y, $key]]
)
| .hold | . as $hold
| (reduce to_entries[] as {$key, $value} ([]; .[$value[]?] += [$key])) as $lean
| [
  range(length)
  | {fall: [.], check: $hold[.]}
  | until(
    isempty(.check[]?);
    if $lean[.check[0]] - .fall | length == 0 then
      .check += $hold[.check[0]] | .check |= unique
      | .fall += [.check[0]]
    end
    | del(.check[0])
  ).fall | length - 1
] | add
