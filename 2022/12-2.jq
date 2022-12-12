[inputs] | (first | length) as $len | add/""
| map({S: "a", E: "z"}[.] // . | explode[0]) as $map
| {front: paths(. == "E")} | first(
  recurse(
    .count += 1 | .dist as $dist | .front |= [
      .[] | $map[.] as $height | . + (1, -1) * (1, $len)
      | select(. >= 0 and $map[.] + 1 >= $height and $dist[.] == null)
    ] | .front |= unique | .dist[.front[]] = 1
  ) | select($map[.front[]] == 97).count
)
