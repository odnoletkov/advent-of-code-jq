[inputs] | join(";")/";;" | map(split(";"))
| (
  [
    first[]/": " | {(first):[last | split(" or ")[] | split("-") | map(tonumber)]}
  ] | add
) as $rules
| [
  last[1:][] | split(",")[] | tonumber
  | select(. as $field | $rules | all(all(first > $field or $field > last)))
] | add
