[
  [""] + ["." + inputs] + [""] | recurse(.[1:]; length > 2)[:3] as $rows | {}
  | recurse(.start += .match.offset + .match.length | .match = ($rows[1][.start:] | match("\\d+")))
  | select(.match) | .match.offset += .start | .match
  | select(any($rows[][.offset - 1: .offset + .length + 1]; test("[^\\d|.]"))).string | tonumber
] | add
