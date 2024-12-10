[
  inputs/": " |  map(./" " | map(tonumber))
  | select(any(
    ({ops: .[1]} | until(.ops | length == 0; .res += .ops[0], .res = (.res // 1) * .ops[0] | .ops |= .[1:]).res) == .[0][0]; .
  ))[0][0]
] | add
