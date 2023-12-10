["." + inputs]
| (.[0] | length) as $width | add | (./"") as $map
| [[null, match("S").offset]]
| [
  while(
    .[0][0] != .[1][0] or length != 2;
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
| .[1] = [[.[0][0][1], .[2][0][0]], [.[0][0][1], .[2][1][0]]]
| .[1:]
| map(.[1]) + (map(.[0] | reverse) | reverse)
| map(.[1]) as $path
| .[] |= [
  ([] | .[1] = [-$width, $width] | .[$width] = [1, -1] | .[$width + 1] = [$width, -$width] | .[-$width] = [-1, 1])[
    .[1] - .[0]
  ][] + .[]
]
| transpose | [.[0] + .[2], .[1] + .[3]]
| .[] |= (unique - $path | map(select(. >= 0 and . < ($map | length))))
| .[] |= last(recurse(
  . + (
    [.[] + (1, -1, $width, -$width) | select(. >= 0 and . < ($map | length))] - . - $path
    | unique | select(length > 0)
  )
))
| .[] | select(contains([0]) | not) | length

# | . as $res | $map
# | reduce $res[0][] as $x (.; .[$x] = "L")
# | reduce $res[1][] as $x (.; .[$x] = "R")
# | .[] |= (. // ".") | add | recurse(.[$width:]; length > 0)[1:$width]
