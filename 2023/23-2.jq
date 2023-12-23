[inputs/""] | {y: length, x: last | indices(".")[]} as $end
| {map: ., todo: [{y: 1, x: 1}]}
| until(
  isempty(.todo[]);
  if .map[.todo[0].y][.todo[0].x] | .  == "O" or . == null then
    .nodes += [.todo[0]] | del(.todo[0])
  else
    .map[.todo[0].y][.todo[0].x] = "O"
    | .map as $map | [ 
      .todo[0] | .prev as $prev | .prev = {y, x}
      | .y += (1, -1), .x += (1, -1) | .step += 1
      | select({y, x} != $prev and $map[.y][.x] != "#")
    ] as $next
    | if $next | length == 0 then
      del(.todo[0])
    elif $next | length == 1 then
      .todo[0] = $next[0]
    else 
      .nodes += [.todo[0]]
      | ($next | .[].from = .[0].prev | .[].step = 1) as $next
      | .todo[0] = $next[0]
      | .todo += $next[1:]
    end
  end
)
| .nodes | map(select(.step > 1))
| . + map(. as {$y, $x} | .y = .from.y | .x = .from.x | .from.y = $y | .from.x = $x)
| reduce group_by({y, x})[] as $group ([]; .[$group[0].y][$group[0].x] = $group)
| . as $graph | {y: 1, x: 1}
| [
  until(
    {y, x} == $end;
    $graph[.y][.x][] as $next
    | select(.seen[$next.from.y][$next.from.x] | not)
    | .y = $next.from.y | .x = $next.from.x
    | .seen[.y][.x] = true | .dist += $next.step
  ).dist
] | max
