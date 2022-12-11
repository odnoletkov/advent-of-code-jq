[inputs] | [
  recurse(.[7:]; length > 0) | {
    items: (.[1][18:]/", "),
    mul: ({"*": .[2][25:]}[.[2][23:][:1]] // 1 | tonumber? // null),
    add: ({"+": .[2][25:]}[.[2][23:][:1]] // 0 | tonumber? // null),
    test: .[3][21:],
    true: .[4][29:],
    false: .[5][30:]
  } | walk(tonumber? // .)
]
| (reduce .[].test as $t (1; .*$t)) as $k
| nth(10000; recurse(
    reduce range(length) as $i (.;
      reduce .[$i].items[] as $w (.;
        ($w * (.[$i].mul // $w) + (.[$i].add // $w)) as $w
        | .[.[$i][$w % .[$i].test == 0 | tostring]].items += [$w % $k]
      )
      | .[$i].count += (.[$i].items | length)
      | .[$i].items = []
    )
))
| map(.count) | sort | .[-2] * .[-1]
