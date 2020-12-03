[inputs] as $map |
def trees($slope):
  [
    [0,0]
    | recurse(.[0] += $slope[1] | .[1] += $slope[0] | select(.[0] < ($map|length)))
    | {"#":1}[$map[.[0]][.[1]%($map[0]|length):][:1]]
  ][1:] | add;

reduce trees([1,1],[3,1],[5,1],[7,1],[1,2]) as $i (1; . * $i)
