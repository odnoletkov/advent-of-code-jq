{map: [inputs/""]} | until(
  .cycle and (1000000000 - .seen[.key]) % .cycle == 0;
  .seen[.key // ""] = (.seen | length)
  | .map |= nth(4; recurse(
    reverse | transpose
    | map(add | [scan("(#*)([^#]*)") | .[1] |= (./"" | sort | add)] | add | add/"")
  ))
  | .key = (.map | map(add) | add)
  | .cycle //= ((.seen | length) - (.seen[.key] // empty) // null)
).map
| [reverse | transpose[] | add | match("O"; "g").offset + 1]
| add
