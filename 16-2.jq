[inputs] | join(";")/";;" | map(split(";"))

| (
  [
    first[]/": "
    | {(first):[last | split(" or ")[] | split("-") | map(tonumber)]}
  ] | add
) as $rules

| (
  .[1][1:] | first | split(",") | map(tonumber)
) as $ticket

| [
  last[1:][] | split(",") | map(
    tonumber | [
      . as $field | $rules | to_entries[] | select(
        .value | any(first <= $field and $field <= last)
      ).key
    ]
  )
  | select(all(length != 0))
]
| transpose | map(
  reduce .[1:][] as $item (first; . - (. - $item))
)
| last(recurse(
  (.[] | select(arrays and length == 1) | first) as $match
  | (.[] | arrays) -= [$match]
  | map(select(length > 0) // $match)
))
| [., $ticket] | transpose
| map(select(first | startswith("departure")) | last)
| reduce .[] as $i (1; . * $i)
