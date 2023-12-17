[inputs/"" | map(tonumber) + [null]] + [[]]
| {
  map: .,
  heat: [[{"": 0}]],
  todo: [[0, 0]],
}
| until(
  .todo | length == 0;
  reduce .todo[] as [$y, $x] (
    .todo = [];
    reduce (.heat[$y][$x] | to_entries[]) as {key: $path, value: $distance} (
      .;
      reduce (
        $path + (">v<^"/"" - [{">": "<", "v": "^", "<": ">", "^": "v"}[$path[-1:]]])[]
        | scan("\\\(.[-1:])+$")
        | select(length < 4)
      ) as $path (
        .;
        ($y + {"v": 1, "^": -1}[$path[-1:]]) as $y
        | ($x + {">": 1, "<": -1}[$path[-1:]]) as $x
        | .map[$y][$x] as $step
        | if $step and (.heat[$y][$x][$path] | not or . > $distance + $step) then
          .heat[$y][$x][$path] = $distance + $step
          | .todo += [[$y, $x]]
        end
      )
    )
  )
  | .todo |= unique
)
| [.heat[-1][-1][]] | min
