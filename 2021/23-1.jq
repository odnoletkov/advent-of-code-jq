{A: 2, B: 4, C: 6, D: 8} as $room_pos |
{A: 1, B: 10, C: 100, D: 1000} as $cost |

def moves($i):
  .hall as $hall |
  ($i - 1 | while(. >= 0 and $hall[.] == "."; . - 1)),
  ($i + 1 | while(. < ($hall | length) and $hall[.] == "."; . + 1));

def tohall($room):
  $room_pos[$room] as $from
  | select(.hall[$from] == ".")
  | (.[$room] | last // empty) as $e
  | .cost += ([$cost[.[$room][]]] | add)
  | .[$room][-1] |= empty
  | moves($from) as $m
  | .hall[$m] = $e
  | .cost += ($cost[$e] * ($from - $m | fabs));

def toroom($from):
  .hall[$from] as $e
  | $room_pos[$e] as $pos
  | select(
    $e != "."
    and (.[$e] | length == 0)
    and (any(moves($from); . == $pos))
  )
  | .hall[$from] = "."
  | .cost += ($cost[$e] * (($from - $pos | fabs) + if (.done | contains($e)) then 1 else 2 end))
  | .done += $e;

def complete:
  .done | length == 8;

def clean($room):
  (
    select(.[$room][0] == $room)
    | .[$room][0] |= empty
    | .done += $room
    | clean($room)
  ) // .;

[inputs/""]
| {
  hall: .[1][1:12],
  A: [.[3][3], .[2][3]],
  B: [.[3][5], .[2][5]],
  C: [.[3][7], .[2][7]],
  D: [.[3][9], .[2][9]],
  done: ""
}
| (.A, .B, .C, .D) |= map(select(. != "."))
| clean("A") | clean("B") | clean("C") | clean("D")

# | tohall("D")
# | toroom(range(11))

| [
  limit(
    100;
    recurse(
      select(complete | not)
      | first(toroom(range(11)))
      // tohall("A", "B", "C", "D")
    )
    | select(complete).cost
  )
]
| (length | debug) as $_ | min

| (.. | arrays) |= join("")
