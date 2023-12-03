[
  [""] + ["." + inputs]
  | recurse(.[1:]; length > 1)[:3]
  | (.[1] | match("\\d+"; "g")) + {row: .[]}
  | .star = (.row[.offset - 1:][:.length + 2] | match("\\*"; "g"))
  | .star.offset += .offset
]
| group_by({row, star})
| map(select(length == 2) | map(.string | tonumber) | .[0] * .[1])
| add
