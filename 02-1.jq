[
  inputs
  | capture("^(?<min>\\d+)-(?<max>\\d+) (?<alpha>\\w): (?<pass>\\w+)$")
  | [.min, (.pass/.alpha | length - 1), .max]
  | select(. == sort_by(tonumber))
] | length
