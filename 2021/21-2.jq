[[1, 2, 3] | combinations(3) | add] | group_by(.) | map([first, length]) as $moves
| [
  inputs | match("Player \\d starting position: (\\d+)").captures[].string | tonumber as $pos
  | [] | .[0][$pos] = 1
  | [
    recurse(
      .[:21] | select(flatten | add > 0) | . as $prev
      | reduce paths(numbers | . > 0) as [$score, $pos] (
        [];
        reduce $moves[] as [$roll, $count] (
          .;
          (($pos + $roll - 1) % 10 + 1) as $newpos |
          .[$score + $newpos][$newpos] += $prev[$score][$pos] * $count
        )
      )
    )[21:] | flatten | add // 0
  ]
] | reduce transpose[1:][] as $r (
  [0, 1];
  first += $r[0] * last
  | last *= 27
  | last -= $r[1]
) | first
