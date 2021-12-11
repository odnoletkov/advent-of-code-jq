[inputs/"-" | ., reverse]
| group_by(first)
| map({(.[0][0]): map(last)}) | add

| {moves: ., pos: "start", path: ["start"]}

| [
  recurse(
    if .pos == "end" then empty else . end
    | .move = .moves[.pos][]?
    | .path += [.move]
    | if .pos == (.pos | ascii_downcase) then
      if .pos == "start" or .pos == "end" or .flag then
        .moves[.pos] |= empty
      else
        (.flag = true), (.moves[.pos] |= empty)
      end
    else
      .
    end
    | .pos = .move
  ) | select(.pos == "end").path
  # | join(",")
]
# | sort
| unique | length
# | length
