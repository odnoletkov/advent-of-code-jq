[
  inputs/": " |  map(./" " | map(tonumber)) | . as [[$t]]
  | select(
    any(
      (
        {ops: .[1]} | until(
          .res > $t or (.ops | length == 0);
          .res += .ops[0],
          .res = (.res // 1) * .ops[0],
          .res = (.res // 1) * pow(10; .ops[0] | log10 | floor + 1) + .ops[0]
          | .ops |= .[1:]
        ).res
      );
      . == $t
    )
  )[0][0]
] | add
