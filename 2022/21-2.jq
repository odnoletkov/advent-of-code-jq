[inputs/": "] | INDEX(first) | .[] |= last/" " | .root[1] = "=" | . as $all
| reduce (
  ["root"] | recurse(. + ($all[last] | select(length == 3) | [first], [last]))
  | select(last == "humn") | reverse | [.[:-1], .[1:]] | transpose[]
) as [$arg, $res] (.;
  .[$arg] = (
    .[$res] | {
      "+": [[3, "-", 2], 0, [3, "-", 0]], "-": [[2, "+", 3], 0, [0, "-", 3]],
      "*": [[3, "/", 2], 0, [3, "/", 0]], "/": [[2, "*", 3], 0, [0, "/", 3]],
      "=": [[2, "=", 2], 0, [0, "=", 0]],
    }[.[1]][index($arg)] | .[0, 2] |= ($all[$res] + [$res])[.]
  )
)
| . as $all | def calc($m):
  $all[$m] | (select(length == 1)[0] | tonumber) // (
    (first, last) |= calc(.) | {
      "+": (first + last), "-": (first - last),
      "*": (first * last), "/": (first / last),
      "=": first,
    }[.[1]]
  );
calc("humn")
