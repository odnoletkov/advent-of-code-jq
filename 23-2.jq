input/"" | map(tonumber)

# | . + [10]
| reduce ([[0] + ., . + [first]] | transpose)[] as [$a,$b] ([]; .[$a] = $b)
# | .[10:10] = [range(11;10+1)]

| min as $min | (max - $min + 1) as $range

| nth(100;
  recurse(
    first as $f | .[first] as $a | .[$a] as $b | .[$b] as $c
    | (
      first | until(
        . != $f and . != $a and . != $b and . != $c;
        (. - 1 - $min + $range)%$range + $min
      )
    ) as $dst
    | .[0,first] = .[$c] | .[$c] = .[$dst] | .[$dst] = $a
  )
)
| [limit(length - 1; . as $res | 1 | recurse($res[.]))][1:] | join("")
