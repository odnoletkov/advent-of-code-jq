reduce (inputs/" ") as [$dir, $n] (
  [0, 0];
  [.] + [
    {
      "forward": [1, 0],
      "down": [0, 1],
      "up": [0, -1]
    }[$dir] | map (. * ($n | tonumber))
  ] | transpose | map(add)
) | .[0] * .[1]
