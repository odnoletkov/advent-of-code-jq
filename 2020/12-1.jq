reduce (inputs | [.[:1],(.[1:]|tonumber)]) as [$action,$value]
(
  {x:0,y:0,dir:0};
  ({
    "L":{dir:1}, "R":{dir:-1},
    "F":({"0":{x:1},"90":{y:1},"180":{x:-1},"270":{y:-1}}[(360 + .dir%360)%360 | tostring] // error),
    "N":{y:1}, "S":{y:-1}, "W":{x:-1}, "E":{x:1},
  }[$action] | .[] *= $value) as {$x,$y,$dir} |
  .x += $x | .y += $y | .dir += $dir
) | (.x|fabs) + (.y|fabs)
