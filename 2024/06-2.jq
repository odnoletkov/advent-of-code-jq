[0, ("=" + inputs + "=")/"", 0]
| .[0, -1] = (.[1] | map("="))
| {
  m: .,
  p: (paths(strings) as [$y, $x] | select(.[$y][$x] == "^") | [$y, $x, "^"])
}
|
until(
  .m[.p[0]][.p[1]] == "=";
  first(
    ., .p[2] |= {"^": ">", ">": "v", "v": "<", "<": "^"}[.]
    | .p[0] += {"^": -1, ">": 0, "v": 1, "<": 0}[.p[2]]
    | .p[1] += {"^": 0, ">": 1, "v": 0, "<": -1}[.p[2]]
    | select(.m[.p[0]][.p[1]] != "#")
  )
)
