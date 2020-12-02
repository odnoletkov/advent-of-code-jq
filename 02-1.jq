[
  inputs
  | capture("^(?<min>\\d+)-(?<max>\\d+) (?<alpha>\\w): (?<pass>\\w+)$") // error("fail")
  | [
    .min,
    (.alpha as $alpha | .pass | indices($alpha) | length),
    .max
  ]
  | select(. == sort_by(tonumber))
] | length
