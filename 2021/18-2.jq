def updatepath($p; f): setpath($p; getpath($p) | f);
def normalize:
  last(recurse(
    . as $in |
    def get: . as $p | $in | getpath($p);
    (
      [paths] as $paths
      | first(
        $paths | to_entries[] | select(.value | length > 3 and (get | arrays and all(numbers)))
      ).key as $target
      | getpath($paths[$target]) as [$left, $right]
      | updatepath(first($paths[:$target] | reverse[] | select(get | numbers)); . + $left) // .
      | updatepath(first($paths[$target + 3:][] | select(get | numbers)); . + $right) // .
      | setpath($paths[$target]; 0)
    ) // updatepath(first(paths(numbers and . > 9)); . / 2 | [trunc, ceil])
  ));

[
  [inputs | fromjson] | combinations(2) | normalize
  | walk((select(all(numbers)?) | first * 3 + last * 2) // .)
] | max
