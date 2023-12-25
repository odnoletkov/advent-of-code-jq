[inputs/" " | [.[0][:3]] + (.[1:][] | [.]) | reverse, .]
| group_by(.[0]) | INDEX(.[0][0]) | (.[] |= [.[][1]]) as $graph
| .[] = 0
| until(
  add == 3;
  (to_entries | max_by(.value)) as {$key}
  | .[$graph[$key][]] |= values + 1
  | del(.[$key])
)
| length | (($graph | length) - .) * .
