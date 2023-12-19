[inputs | capture("(?<key>.+)\\{(?<value>.+)\\}")]
| from_entries | .[] |= [scan("(?:(.)(.)(\\d+):)?(\\w+)")]
| .[][:-1][][2] |= tonumber | . as $wfs
| {wf: $wfs["in"]} + ([{x,m,a,s} | .[] = [0, 4001]] | add)
| [
  until(
    .wf == null;
    (true, false) as $skip
    | if .wf | length > 1 then
      .wf[0] as [$cat, $op, $value]
      | .[$cat] |= if $op == "<" | if $skip then not else . end then
        .[1] |= ([., if $skip then $value + 1 else $value end] | min)
      else
        .[0] |= ([., if $skip then $value - 1 else $value end] | max)
      end
    else
      select($skip | not)
    end
    | if $skip then
      del(.wf[0])
    else
      .wf = $wfs[.wf[0][3] | select(. != "R")]
    end
  )
  | [del(.wf)[]]
]
| map(reduce map(.[1] - .[0] - 1)[] as $n (1; . * $n)) | add
