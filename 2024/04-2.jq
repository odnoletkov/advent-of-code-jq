[inputs + "."] | length as $l | add | [
  .[range(length):] | match(
    ".{\($l - 1)}A.{\($l - 1)}"
    | "^M.S\(.)M.S", "^S.M\(.)S.M", "^S.S\(.)M.M", "^M.M\(.)S.S"
  )
] | length
