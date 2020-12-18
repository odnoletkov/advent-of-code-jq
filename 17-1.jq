[inputs/""] | [
  to_entries[]
  | [.key] + (.value | to_entries[] | select(.value == "#") | [.key])
  + [0]
]
| reduce range(6) as $_ (.;
  . as $active
  | map(. as $me | map([. + range(3) - 1]) | combinations | select(. != $me))
  | group_by(.) | map(
    select(
      length == 3 or length == 2 and (
        first as $idx | $active | bsearch($idx) >= 0
      )
    ) | first
  )
) | length
