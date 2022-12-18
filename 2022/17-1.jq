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

[] | nth(2022; recurse(
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
        .[-1][1] + $jets[(.[0][3] // 0) % ($jets | length)],
        7 - ($shapes[.[-1][2]][0] | length)
      ] | sort[1])
      | select(good)
    ) // .
    | .[-1][0] -= 1 | .[0][3] += 1
  ))
  | .[-1][0] += 1 | sort
))
| .[-1][0] + 1
