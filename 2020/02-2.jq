[
  inputs
  | capture("^(?<min>\\d+)-(?<max>\\d+) (?<alpha>\\w): (?<pass>\\w+)$")
  | [select(.pass[.min,.max|tonumber - 1:][:1] == .alpha)]
  | select(length == 1)
] | length
