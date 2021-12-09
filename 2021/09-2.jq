[
  [inputs/"" | map(tonumber)] | . as $map
  | (range(length) | [.]) + (range(first | length) | [.])
  | select(
    [
      ., first += 1, first -= 1, last += 1, last -= 1
      | select(all(. >= 0))
      | $map[first][last] // empty
    ] | select(first == min and first != .[1])
  ) | [
    recurse(
      . as [$y, $x]
      | first += 1, first -= 1, last += 1, last -= 1
      | select(all(. >= 0) and ($map[first][last] | . < 9 and . > $map[$y][$x]))
    )
  ] | unique | length
] | sort[-3:] | .[0] * .[1] * .[2]
