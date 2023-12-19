[inputs] | join(";")/";;" | map(./";")
| (
  .[0] | map(split("[{},]"; "")) | INDEX(.[0]) | map_values(
    .[1:-2][] |= (scan("(.)(.)(\\d+):(.+)") | .[2] |= tonumber)
  )
) as $work
| [
  .[1][] | [scan("([xmas])=(\\d+)") | {(.[0]): .[1] | tonumber}] | add | .w = "in"
  | until(
    .w == "A";
    select(.w != "R")
    | .w = (first($work[.w][1:-2][] as [$cat, $op, $value, $dst] | select((.[$cat] > $value) == ($op == ">")) | $dst) // $work[.w][-2])
  )
  | .[] | tonumber?
] | add
