input/"" | map(tonumber)
| min as $min | (max - $min + 1) as $range
| nth(100;
  recurse(
    first(
      index(
        first | recurse(
          (. - 1 - $min + $range)%$range + $min
        )
      ) | select(. > 3)
    ) as $idx
    | .[4:$idx+1] + .[1:4] + .[$idx+1:] + .[:1]
  )
) | .[index(1) + 1:] + .[:index(1)] | join("")
