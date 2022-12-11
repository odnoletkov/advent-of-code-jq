[inputs] | [
  recurse(.[7:]; length > 0) | {
    items: (.[1][18:]/", " | map(tonumber)),
    operation: (.[2][23:][:1]),
    arg: (.[2][25:]),
    test: (.[3][21:] | tonumber),
    true: (.[4][29:] | tonumber),
    false: (.[5][30:] | tonumber)
  }
  | .mul = ({"*": .arg}[.operation] // 1 | tonumber? // null)
  | .add = ({"+": .arg}[.operation] // 0 | tonumber? // null)
]
| nth(
  20;
  recurse(
    reduce range(length) as $i (
      .;
      .[$i] as $m | reduce $m.items[] as $w (
        .;
        (($w * ($m.mul // $w) + ($m.add // $w))/3 | trunc) as $n
        | .[$m[$n % $m.test == 0 | tostring]].items += [$n]
      )
      | .[$i].count += (.[$i].items | length)
      | .[$i].items = []
    )
  )
)
| map(.count) | sort | .[-2] * .[-1]
