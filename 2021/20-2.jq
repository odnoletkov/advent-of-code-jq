[inputs] | join(",")/",," | map(split(",") | map([{"#": 1, ".": 0}[split("")[]]]))
| first[0] as $algo | last | length as $init_len
| nth(50; recurse(
  (length - $init_len | . / 2 % 2 * $algo[0]) as $pad
  | [first | map($pad)] + . + [first | map($pad)] | .[] |= [$pad] + . + [$pad]
  | length as $len | [
    [first | map($pad)] + . + [first | map($pad)] | .[] |= [$pad] + . + [$pad]
    | . as $in
    | (range(1; length - 1) | [.]) + (range(1; length - 1) | [.])
    | [
      (range(first - 1; first + 2) | [.]) + (range(last - 1; last + 2) | [.])
      | $in[last][first]
    ] | $algo[reduce .[] as $b (0; . * 2 + $b)]
  ] | [while(length > 0; .[$len:])[:$len]]
)) | flatten | add
