[inputs] | join(";")/";;" | map(split(";"))
| (
  [
    first[]/": " | [last | split(" or ")[] | split("-") | map(tonumber)]
  ] | add
) as $rules
| [
  last[1:][] | split(",")[] | tonumber
  | select(. as $field | $rules | any(first <= $field and $field <= last) | not)
] | add
