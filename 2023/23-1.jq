{map: [inputs/""], y: 1, x: 1}
| [
  until(
    .map[.y][.x] | not;
    .map[.y][.x] as $tile
    | .map[.y][.x] = "O"
    | .step += 1
    | (
      .y += {".": [-1, 1], "v": [1]}[$tile][]?,
      .x += {".": [-1, 1], ">": [1]}[$tile][]?
    )
  ).step
] | max
