[
  [inputs] | join(",")/",," | map(./"," | map(./""))[] | [
    ., transpose
    | [[.[:range(length)] | reverse], [.[range(length):]]]
    | transpose[1:]
    | map(
      select(
        [.[][:[.[] | length] | min] | flatten]
        | transpose | map(select(.[0] != .[1])) | length == 1
      )[0] | length
    )[] // 0
  ] | .[0] * 100 + .[1]
] | add
