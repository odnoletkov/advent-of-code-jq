reduce (
  inputs
  | capture("^(?<action>.*) (?<x1>\\d+),(?<y1>\\d+) through (?<x2>\\d+),(?<y2>\\d+)$")
  | .["x1","y1","x2","y2"] |= tonumber
) as {$action,$x1,$y1,$x2,$y2} (
  [range(1000) | [range(1000) | 0]];
  .[range($x1;$x2+1)] |= (.[range($y1;$y2+1)] |= ({"turn on":1,"turn off":0}[$action] // (. + 1)%2))
) | flatten | add 
