[0, ("=" + inputs + "=")/"", 0]
| .[0, -1] = (.[1] | map("="))
| . as $m
| paths(strings)
| select($m[.[0]][.[1]] == "^") + ["^"]
| [
  while(
    $m[.[0]][.[1]] != "=";
    first(
      ., .[2] |= {"^": ">", ">": "v", "v": "<", "<": "^"}[.]
      | .[0] += {"^": -1, ">": 0, "v": 1, "<": 0}[.[2]]
      | .[1] += {"^": 0, ">": 1, "v": 0, "<": -1}[.[2]]
      | select($m[.[0]][.[1]] != "#")
    )
  )[:2]
]
| unique | length