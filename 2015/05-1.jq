[
  inputs
  | select(length - (./"" - ("aeiou"/"") | length) >= 3)
  | select(./"" | [.[:-1],.[1:]] | transpose | any(first == last))
  | select(all(contains("ab", "cd", "pq", "xy"); not))
] | length
