[inputs] | [
  [map(./"") | transpose[] | add], . | [
    [foreach map(match("#").length // 1E6)[] as $n (0; . + $n)]
    [to_entries[] | .key + (.value | scan("#") | 0)]
  ] | combinations(2) | .[0] - .[1] | fabs
] | add/2
