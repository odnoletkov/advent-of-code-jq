[
  [inputs] | join(",")/",," | map(./"," | map(./""))[] | [
    ., transpose
    | [[.[:range(length)] | reverse], [.[range(length):]]]
    | transpose[1:]
    | map(
      select(
        [.[][:[.[] | length] | min]] | .[0] == .[1]
      )[0] | length
    )[] // 0
  ] | .[0] * 100 + .[1]
] | add
