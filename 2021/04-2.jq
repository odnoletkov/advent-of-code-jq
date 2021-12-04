[inputs] | join(",")/",,"
| (first/",") as $calls
| first(
  (.[1:][] | (split(",") | map(split(" ") | map(select(length > 0))) | . + transpose))
  + (first/"," | .[:length - range(length)] | [.]) 
  | (last | map({(.):0}) | add) as $hash
  | .[:-1] | select(any(all($hash[.])) | not)
  | flatten | unique - ($hash | keys) | map(tonumber)
  | ($calls[($hash | length)] | tonumber) as $last
  | (add - $last) * $last
)
