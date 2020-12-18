def neighbours:
  . as $me | map([. + range(3) - 1]) | combinations | select(. != $me);
[inputs/""] | [
  to_entries[]
  | [.key]
  + (.value | to_entries[] | select(.value == "#") | [.key])
  + [0] + [0]
] | sort
| reduce range(6) as $_ (.;
  . as $s | def active: . as $in | $s | bsearch($in) >= 0;
  map(neighbours) | unique
  | map(select(
    ([neighbours | select(active)] | length) as $n |
    $n == 3 or $n == 2 and active
  ))
) | length
