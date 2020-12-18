[inputs/""]

| 6 as $cycles | (length + 2*$cycles) as $sz |

def idx($x;$y;$z):
  $z*$sz*$sz + $y*$sz + $x;

. as $in | [] | .[
  $in
  | to_entries[] | .key as $x | .value
  | to_entries[] | .key as $y | .value
  | select(. == "#")
  | idx($x + $cycles; $y + $cycles; 1 + $cycles)
] = 1
| .[$sz*$sz*$sz] = null

| reduce range($cycles) as $_ (
  .;
  . as $state |
  reduce ([[range($sz)] | .,.,.] | combinations) as [$x,$y,$z] (
    .;
    idx($x;$y;$z) as $idx |
    (
      [
        $state[
          idx($x + range(3) - 1; $y + range(3) - 1; $z + range(3) - 1)
          | select(. != $idx)
        ]
      ] | add
    ) as $nbr |
    .[$idx] |= if . + 0 > 0 and $nbr != 2 and $nbr != 3 then
      0
    elif . + 0 == 0 and $nbr == 3 then
      1
    else
      .
    end
  )
)

| add

# | [range($sz) as $z | [range($sz) as $x | [range($sz) as $y | .[idx($x;$y;$z)] | if . == 1 then "#" else "." end] | join("")]]
