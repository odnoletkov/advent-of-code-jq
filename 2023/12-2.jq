[
  inputs/" " | .[1] |= (./"," | map(tonumber))
  | .[] |= [limit(5; repeat(.))] | .[0] |= join("?") | .[1] |= add
  | [
    recurse(
      .[1][0] as $n
      | (.[0] | match("^[.?]*?[#?]{\($n)}([.?]|$)")).captures[].offset as $o
      | (
        .[0] = (.[0][$o - $n:] | select(.[:1] == "?")[1:]),
        (.[0] |= .[$o + 1:] | .[1] |= .[1:])
      )
      | select((.[0] | length) + 2 > (.[1] | add + length))
      # | select((.[0] | [scan("[#?]")] | length) >= (.[1] | add))
    )
    | select((.[1] | length == 0) and (.[0] | test("#") | not))
  ] | length
] | add
