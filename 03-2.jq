[inputs] as $map |
def trees($slope):
  [
    $slope | recurse(
      .[0] += $slope[0] | .[1] += $slope[1];
      .[1] < ($map|length)
    )
    | {"#":1}[$map[.[1]][.[0]%($map[1]|length):][:1]]
  ] | add;

reduce trees([1,1],[3,1],[5,1],[7,1],[1,2]) as $i (1; . * $i)
