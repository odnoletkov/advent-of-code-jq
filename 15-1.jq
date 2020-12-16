input/","
| {
  turn: length,
  number: last,
  memory: with_entries(.tmp = .key | .key = .value | .value = .tmp)
} | until(.turn == 2020;
  .prev = .memory[.number]
  | .memory[.number] = .turn - 1
  | .number = (.turn - 1 - (.prev // .turn - 1) | tostring)
  | .turn += 1
).number | tonumber
