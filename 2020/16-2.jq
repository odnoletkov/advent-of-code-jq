[inputs] | join(";")/";;" | map(split(";"))
| ([
  first[]/": " | {(first): [last | split(" or ")[] | split("-") | map(tonumber)]}
] | add) as $rules
| .[1:] | map([.[1:][] | split(",") | map(tonumber)])
| .[0] |= first
| .[1] |= (
  .[][] |= [
    . as $field | $rules | to_entries[] | select(
      .value | any(first <= $field and $field <= last)
    ).key
  ]
  | map(select(all(length != 0)))
  | transpose | map(
    reduce .[1:][] as $item (first; . - (. - $item))
  )
  | to_entries | sort_by(.value | length) | [
    recurse(.[].value -= first.value | .[1:]; length > 0) | first
  ] | sort_by(.key) | map(.value | first)
)
| transpose
| map(select(last | startswith("departure")) | first)
| reduce .[] as $i (1; . * $i)
