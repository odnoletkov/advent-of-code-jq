def trees($slope):
  $slope as [$right, $down] |
  [
    recurse(.[$down:] | .[] |= .[$right:] + .[:$right] | select(length > 0))
    | {"#":1}[.[0][:1]]
  ][1:] | add;

[inputs] | reduce trees([1,1],[3,1],[5,1],[7,1],[1,2]) as $i (1; . * $i)
