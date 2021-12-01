def rot($v):
  ((360 + $v%360)%360) as $a |
  if $a == 0 then
    .
  elif $a == 90 then
    {x:.y,y:-.x}
  elif $a ==  180 then
    {x:-.x,y:-.y}
  elif $a == 270 then
    {x:-.y,y:.x}
  else
    error
  end;

reduce (inputs | [.[:1],(.[1:]|tonumber)]) as [$action,$value]
(
  {x:0,y:0,wp:{x:10,y:1}};
  if $action == "L" then
    .wp |= rot(-$value)
  elif $action == "R" then
    .wp |= rot($value)
  elif $action == "F" then
    .x += .wp.x * $value | .y += .wp.y * $value
  else
    ({"N":{y:1},"S":{y:-1},"W":{x:-1},"E":{x:1}}[$action] // error | .[] *= $value) as $d
    | .wp.x += $d.x | .wp.y += $d.y
  end
)
| (.x|fabs) + (.y|fabs)
