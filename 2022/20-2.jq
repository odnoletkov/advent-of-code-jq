[inputs | tonumber * 811589153] | to_entries | map(.prev = .key - 1 | .next = .key + 1)
| first.prev = length - 1 | last.next = 0
| nth(10; recurse(reduce range(length) as $from (.;
  (
    nth(
      (.[$from].value % (length - 1) + (length - 1)) % (length - 1) | select(. != 0);
      . as $r | $from | recurse($r[.].next)
    ) as $to
    | .[.[$from].prev].next = .[$from].next | .[.[$from].next].prev = .[$from].prev
    | .[.[$to].next].prev = $from | .[$from].next = .[$to].next
    | .[$to].next = $from | .[$from].prev = $to
  ) // .
)))
| [limit(length; . as $r | first | recurse($r[.next])).value]
| [.[(index(0) + (1000, 2000, 3000)) % length]] | add
