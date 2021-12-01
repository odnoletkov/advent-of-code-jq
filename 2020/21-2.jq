[
  inputs | split(" (contains ") #"
  | first |= split(" ") | last |= .[:-1]/", "
]
| map([first] + (last[] | [.])) | group_by(last)
| map({(first | last): map(first)}) | add
| map_values(reduce .[1:][] as $item (first; . - (. - $item)))
| last(recurse(
  map(select(length == 1))[] as $exclude
  | (.[] | arrays) -= $exclude
  | (.[] | select(length == 0)) = $exclude[]
)) | join(",")
