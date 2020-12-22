[inputs] | join(",")/",," | map(split(",")[1:] | map(tonumber))

| def play:
  label $out | last(
    foreach recurse(
      select(all(. != []))
      | (
        if all(first < length) then
          map(.[1:][:first])
          | (map(max) + [map(length) | add - 1] | max == first)
          or (play // [[],[]] | last == [])
        else
          first[0] > last[0]
        end | not
      ) as $swap
      | if $swap then reverse else . end
      | first += map(first)
      | if $swap then reverse else . end
      | map(.[1:])
    ) as $s ({}; .[$s|tostring] |= (not or break $out); $s)
  );

play | flatten | reverse | to_entries | map((.key + 1) * .value) | add
