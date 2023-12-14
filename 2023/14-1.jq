[
  [inputs/""] | reverse | transpose[] | add
  | [scan("(#*)([^#]*)") | .[1] |= (./"" | sort | add)]
  | add | add | match("O"; "g").offset + 1
] | add
