[
  inputs | match("Player \\d starting position: (\\d+)").captures[0].string
  | {pos: tonumber}
] | {players: ., turn: 0}
| until(
  any(.players[].score; . >= 1000); 
  ([range(3) + (.turn * 3) + 1] | add) as $roll
  | .players[.turn % 2] |= (
    .pos += $roll
    | .pos |= (. - 1) % 10 + 1
    | .score += .pos
  )
  | .turn += 1
) | .players[.turn % 2].score * .turn * 3
