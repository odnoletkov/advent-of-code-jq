[inputs] | reduce (
  .[index("") + 1:][] | [match("move (\\d+) from (\\d+) to (\\d+)").captures[].string | tonumber]
) as [$count, $from, $to] (
  .[:index("") - 1] | [reverse[]/""] | transpose[1:] | [recurse(.[4:]; length > 0)[0] | .[:index(" ")]];
  .[$to - 1] += (.[$from - 1][-$count:] | reverse) | .[$from - 1] |= .[:-$count]
) | map(last) | add
