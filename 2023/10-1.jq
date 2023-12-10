["." + inputs]
| (.[0] | length) as $width | add | (./"") as $map
| [[null, match("S").offset]]
| [
  while(
    .[0][1] != .[1][1];
    map(
      .[1:] + (
        .[0] as $prev |
        (
          [
            .[1] + {N: -$width, S: $width, W: -1, E: 1}[
              (({"|": "NS", "-": "WE", L: "NE", J: "NW", "7": "SW", F: "SE", S: "NSWE"}[$map[.[1]]] // empty)/"")[]
            ]
          ]
          | select($prev == null or .[] == $prev)
        ) - .[:1]
        | map([.])
      )[]
    )
  )
]
| length
