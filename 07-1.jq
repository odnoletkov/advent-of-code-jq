[
  inputs
  | capture("^(?<parent>.*) bags contain (?<children>.*).$") // error
  | .children |= [
    split(", ")[]
    | capture("(?<count>\\d+) (?<color>.*) bags?$") // if . == "no other bags" then empty else error end
    | {(.color): .count | tonumber}
  ]
  | {(.parent): .children | add | select(.)}
] | add
| reduce to_entries[] as $e ({}; .[$e.value | keys[]] += [$e.key])
| . as $parent_map
| "shiny gold" | [recurse(($parent_map[.] // empty)[])][1:] | unique | length
