[
  inputs | split(" (contains ") #"
  | first |= split(" ") | last |= .[:-1]/", "
]
| map(first[]) - (
  map([first] + (last[] | [.])) | group_by(last)
  | map(map(first) | reduce .[1:][] as $item (first; . - (. - $item)))
  | last(recurse(
    map(select(length == 1))[] as $exclude
    | (.[] | arrays) -= $exclude
    | (.[] | select(length == 0)) = $exclude[]
  ))
) | length
