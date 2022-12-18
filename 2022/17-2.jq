["####", "", ".#.", "###", ".#.", "", "..#", "..#", "###", "", "#", "#", "#", "#", "", "##", "##"]
| join(",")/",," | .[] /= "," | .[][] /= "" | . as $shapes

| (
  .[] |= [.] | .[] += . | .[] |= [[.[0]] + .[1:][]]
  | .[][] |= [(([[],[],[]] + first | recurse(.[1:]; .[0])[:4]) | [.]) + [last]]
  | .[][][] |= [(first | [[],[],[]] + transpose | recurse(.[1:]; .[0])[:4] | transpose | [.]) + [last]]
  | .[][][][] |= any((first | paths(. == "#")) == (last | paths(. == "#")); .)
) as $xsect

| [{"<": -1, ">": 1}[(input/"")[]]] as $jets

| def good:
  .[-1] as [$y, $x, $shape] | .[:-1] | any(
    .[-bsearch([$y - 3.1]) - 1: -bsearch([$y + 3.1]) - 1][]
    | $xsect[$shape][.[2]][$y - .[0] + 3][.[1] - $x + 3 | select(. >= 0)];
    .
  ) | not;

{tower: [], count: 1000000000000} | last(recurse(
  .tower |= (
    . + [
      [
        (.[-1][0] // -1) + 3,
        2,
        length % ($shapes | length)
      ]
      | .[0] += ($shapes[.[2]] | length)
    ] | last(recurse(
      select(.[-1][0] - ($shapes[.[-1][2]] | length) >= -1 and good)
      | (
        .[-1][1] = ([
          0,
          .[-1][1] + $jets[.[0][3] // 0],
          7 - ($shapes[.[-1][2]][0] | length)
        ] | sort[1])
        | select(good)
      ) // .
      | .[-1][0] -= 1 | .[0][3] = (.[0][3] + 1) % ($jets | length)
    ))
    | .[-1][0] += 1
  )
  | if .tower[-1][2] == 1 then
    if .mem0[.tower[0][3]][1] == .tower[-1][1] then
      (.mem0[.tower[0][3]][3] - .count) as $cycle
      | .tower[][0] += (.count / $cycle | trunc) * (.tower[-1][0] - .mem0[.tower[0][3]][0])
      | .count %= $cycle | .mem0 = null
    else
      .mem0[.tower[0][3]] = .tower[-1] + [.count]
    end
  else
    .
  end
  | .tower |= sort
  | .count -= 1 | select(.count >= 0)
))
| .tower[-1][0] + 1
