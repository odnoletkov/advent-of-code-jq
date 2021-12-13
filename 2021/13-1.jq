[inputs] | join(";")/";;" | map(split(";"))
| reduce (
  last[:1][]
  | capture("fold along (?<dir>[xy])=(?<n>\\d+)")
  | .n |= tonumber
) as {$dir, $n} (
  first | map(split(",") | map(tonumber));
  map(
    .[["x", "y"] | index($dir)] |=
    if . == $n then
      empty
    elif . > $n then
      $n * 2 - .
    else
      .
    end
  ) | unique
) | length
