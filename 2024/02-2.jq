[
  inputs/" " | map(tonumber) | select(any(
    delpaths(range(length + 1) | [[.]]) | [.[range(length - 1):] | .[0] - .[1]];
    inside([1, 2, 3], [-1, -2, -3])
  ))
] | length
