[
  inputs/" " | map(tonumber) | [recurse(.[1:]; length > 1) | .[0] - .[1]]
  | select(inside([1, 2, 3]) or inside([-1, -2, -3]))
] | length
