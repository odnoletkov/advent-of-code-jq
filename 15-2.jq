# (30000000/1) as $sz |
(300000/1) as $sz |
input/"," | .[] |= tonumber
| reduce range(length; $sz) as $turn (
  last as $last
  | reduce to_entries[] as {$key,$value} ([]; .[$value] = $key)
  | .[$sz] = $last;
  .[last] as $prev
  | .[last] = $turn - 1
  | if $prev == null then
    last = 0
  else 
    last = $turn - 1 - $prev
  end
)
| last
