[inputs] | join(",")/",," | reduce (
  (.[1:][]/",")[1:] | map(./" " | map(tonumber))
) as $ranges (
  .[0][7:]/" " | map(tonumber);
  map(([.] + $ranges[] | select(.[2] <= .[0] and .[0] < .[2] + .[3]) | .[0] + .[1] - .[2]) // .)
) | min
