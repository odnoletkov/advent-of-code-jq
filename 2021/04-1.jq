[inputs] | join(",")/",,"
| (.[1:] | map(split(",") | map(split(" ") | map(select(length > 0))) | . + transpose)) as $board
| (first/",")
| first(
  .[:range(length) + 1] as $sel | $sel
  | map({(.):0}) | add as $hash | .
  | $board[] | select(any(all($hash[.] != null)))
  | flatten | unique - $sel | map(tonumber) | add * ($sel | last | tonumber)
)
