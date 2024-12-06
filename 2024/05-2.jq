[inputs] | join(";")/";;" | map(./";" | map(split("\\||,"; "")))
| (.[0] | group_by(.[0]) | INDEX(.[0][0]) | .[][] |= .[1]) as $m
| [
  .[1][] | map([.] + $m[.] // [])
  | .[] -= (($m | keys) - map(.[0]))
  | select(map(length) | . != (sort | reverse))
  | sort_by(length)[length/2][0] | tonumber
] | add
