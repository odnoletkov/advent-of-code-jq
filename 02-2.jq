[
  inputs
  | capture("^(?<min>\\d+)-(?<max>\\d+) (?<alpha>\\w): (?<pass>\\w+)$") // error("fail")
  | [select(.pass[.min,.max|tonumber - 1:][:1] == .alpha)]
  | select(length == 1)
] | length
