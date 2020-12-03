[inputs] as $map |
[
  [0,0]
  | recurse(.[0] += 1 | .[1] += 3 | select(.[0] < ($map|length)))
  | {"#":1}[$map[.[0]][.[1]%($map[0]|length):][:1]]
][1:] | add
