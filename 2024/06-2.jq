[0, ("=" + inputs + "=")/"", 0]
| .[0, -1] = (.[1] | map("="))
| . as $m
| {
  p: (paths(strings) as [$y, $x] | select(.[$y][$x] == "^") | [$y, $x, "^"])
}
|

until($m[.p[0]][.p[1]] == "=" or getpath(["visited"] + .p); (
# limit(78; recurse(

setpath(["visited"] + .p; true)
| [
  ., .p[2] |= {"^": ">", ">": "v", "v": "<", "<": "^"}[.]
  | .p[0] += {"^": -1, ">": 0, "v": 1, "<": 0}[.p[2]]
  | .p[1] += {"^": 0, ">": 1, "v": 0, "<": -1}[.p[2]]
  | select($m[.p[0]][.p[1]] != "#")
] | if length == 2 then
  if $m[.[0].p[0]][.[0].p[1]] == "=" then
    empty 
  elif .[1].obstacle then
    .[0]
  else 
    .[1].obstcale = true | .[]
  end
else
  .[]
end

))

# | del(.m)
# | .p | tostring
| $m[.p[0]][.p[1]]
