def dijkstra(step):
  {todo: .} | until(
    isempty(.todo[]);
    reduce .todo[] as $todo (
      .todo = [];
      if .state | getpath($todo[:-1]) | not or . > $todo[-1] then
        .state |= setpath($todo[:-1]; $todo[-1])
        | .todo += [$todo]
      end
    ) | .todo |= (reverse | unique_by(.[:-1]) | map(step))
  ).state;

[(inputs/"" | map(tonumber) + [null]), []] as $map
| [[0, 1, ">", $map[0][1]], [1, 0, "v", $map[1][0]]]
| dijkstra(
  .[2] = (
    .[2] | . + select(length < 10)[-1:],
    ({">": "^v", "<": "^v", "v": "<>", "^": "<>"}[select(length > 3)[-1:]]/"")[]
  )
  | .[0] += {"v": 1, "^": -1}[.[2][-1:]] 
  | .[1] += {">": 1, "<": -1}[.[2][-1:]] 
  | .[3] += ($map[.[0]][.[1]] // empty)
)
| [.[-1][-1] | to_entries[] | select(.key | length > 3).value]
| min
