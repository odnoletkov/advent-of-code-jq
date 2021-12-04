[inputs] | join(",")/",,"
| first(
  (.[1:][] | (split(",") | map(split(" ") | map(select(length > 0))) | . + transpose))
  + (first/"," | .[:range(length) + 1] | [.]) 
  | (last | map({(.):0}) | add) as $hash
  | .[:-1] | select(any(all($hash[.])))
  | flatten | unique - ($hash | keys) | map(tonumber)
  | add * ($hash | to_entries | last | .key | tonumber)
)
