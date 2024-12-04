[
  [inputs/""]
  | limit(4; recurse(transpose | reverse))
  | ., ([range(length) as $d | [range(length) as $x | .[$x][$x + $d]]] | ., map(reverse)[1:])
  | map(add)[]
  | scan("XMAS")
] | length
