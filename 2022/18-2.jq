[inputs/"," | map(tonumber)] | (flatten | [min - 1, max + 1]) as $r
| def neighbours: .[0] += (1, -1), .[1] += (1, -1), .[2] += (1, -1);
map(neighbours) - . - (
  map(neighbours) - last(
    {visited: ., front: [[$r[0,0,0]]]} | recurse(
      .front |= map(neighbours | select(all($r[0] <= . and . <= $r[1])))
      | .front |= unique | .front -= .visited | .visited += .front;
      .front | length > 0
    )
  ).visited
) | length
