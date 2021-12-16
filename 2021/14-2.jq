def merge(objs):
  reduce objs as $obj (
    {};
    reduce to_entries[] as {$key, $value} ($obj; .[$key] += $value)
  );

[inputs] | first as $template
| merge(
  (
    (.[2:] | map(split(" -> ") | {(first): last}) | add) | . as $map
    | with_entries(.value = (.key/"" | group_by(.) | map({(first): length}) | add))
    | nth(40; recurse(
      . as $prev | with_entries(
        .value = merge($prev[.key[:1] + $map[.key]], $prev[$map[.key] + .key[1:]])
        | .value[$map[.key]] -= 1
      )
    ))
  )[first | while(length >= 2; .[1:])[:2]]
)
| .[($template[1:-1]/"")[]] -= 1
| [.[]] | max - min
