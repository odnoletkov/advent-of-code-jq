def tobits: [recurse(. / 2 | floor; . > 0) % 2];
reduce (inputs/" = ") as [$op, $arg] (
  {};
  if $op == "mask" then
    .mask = ($arg/"" | reverse)
  else
    .memory += [{}]
    | .memory[-1][
      [
        ($op | capture("\\[(?<add>\\d+)\\]").add | tonumber | tobits),
        .mask
      ]
      | transpose | map({"0":first}[last] // last) | join("")
      | until(test("X") | not; sub("X";"0","1"))
    ] = ($arg | tonumber)
  end
) | .memory | add | add
