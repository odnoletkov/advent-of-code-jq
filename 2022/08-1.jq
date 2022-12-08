[inputs/""] | (length - 1) * 4 + (
  [., ., ., ., .]
  | .[2] |= map(reverse) | .[3] |= transpose | .[4] |= (transpose | map(reverse))
  | .[1:][][] |= ["0", recurse(.[:2] |= [max]; length > 1)[0]]
  | .[2] |= map(reverse) | .[3] |= transpose | .[4] |= (map(reverse) | transpose)
  | (.[][], .[]) |= .[1:-1]
  | map(add) | [transpose[] | select(first > (.[1:] | min))] | length
)
