(30000000/1) as $sz |
input/"," | .[] |= tonumber
| reduce range(length; $sz) as $turn (
  last as $last
  | reduce to_entries[] as {$key,$value} ([]; .[$value] = $key)
  | .[$sz] = $last;
  .[$sz] as $number 
  | .[$number] as $prev
  | .[$number] = $turn - 1
  | if $prev == null then
    .[$sz] = 0
  else 
    .[$sz] = $turn - 1 - $prev
  end
) | .[$sz]
