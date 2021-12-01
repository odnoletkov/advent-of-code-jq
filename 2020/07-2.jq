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
| . as $map
| "shiny gold" | [
  recurse($map[.] // empty | to_entries[] | .key + (range(.value) | ""))
] | length - 1
