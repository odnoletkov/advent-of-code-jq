[inputs] | join(",")/",," | map(split(",")[1:] | map(tonumber))
| until(last == []; sort | reverse | first += map(first) | map(.[1:]))
| first | reverse | to_entries | map((.key + 1) * .value) | add
