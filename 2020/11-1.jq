[inputs/""]

| [
  ((range(first|length)|[.]) + (range(length)|[.])) as [$y,$x]
  | [ . as $map
    | [-1,0,1] | [.,.] | combinations
    | select(. != [0,0])
    | [$x+first,$y+last]
    | select(first >= 0 and last >= 0)
    | select($map[first][last] == "L")
    | first*($map|first|length) + last
  ]
] as $edges

| flatten

| try reduce
    recurse([
      range(length) as $i
      | ([.[$edges[$i][]] | select(. == "#")] | length) as $empty
      | if .[$i] == "L" and $empty == 0 then
          "#"
        elif .[$i] == "#" and $empty >= 4 then
          "L"
        else
          .[$i]
        end
    ])
as $step (null; if . == $step then error else $step end) catch .

| [select(.[] == "#")] | length
