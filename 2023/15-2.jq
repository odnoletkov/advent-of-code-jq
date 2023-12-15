input
| reduce scan("(\\w+)[-=](\\d*)") as [$label, $f] (
  [];
  .[$label | reduce explode[] as $c (0; (. + $c) * 17 % 256)][$label]
  |= ($f | tonumber?)
)
| to_entries
| map((.key + 1) * (.value | to_entries? | to_entries[] | (.key + 1) * .value.value))
| add
