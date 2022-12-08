[inputs/""] | [., ., ., .]
| .[1] |= map(reverse) | .[2] |= transpose | .[3] |= (transpose | map(reverse))
| .[][] |= [
  . as $arr | foreach range(length) as $i (
    []; map(select($arr[.] >= $arr[$i])) + [$i]
  ) | last - (.[-2] // 0)
]
| .[1] |= map(reverse) | .[2] |= transpose | .[3] |= (map(reverse) | transpose)
| map(flatten) | transpose | map(.[0]*.[1]*.[2]*.[3]) | max
