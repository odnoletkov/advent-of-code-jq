[
  [inputs/"" | map(tonumber)] | . as $map
  | (range(length) | [.]) + (range(first | length) | [.])
  | [
    ., first += 1, first -= 1, last += 1, last -= 1
    | select(all(. >= 0))
    | $map[first][last] // empty
  ] | select(first == min and first != .[1]) | first + 1
] | add
