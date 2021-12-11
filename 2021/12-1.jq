[inputs/"-" | ., reverse] | group_by(first)
| map({(.[0][0]): map(last)})
| {moves: add, pos: "start"}
| [
  recurse(
    if .pos == "end" then empty else . end
    | .move = .moves[.pos][]?
    | .moves[.pos | select(. == ascii_downcase)] |= empty
    | .pos = .move
  ) | select(.pos == "end")
] | length
