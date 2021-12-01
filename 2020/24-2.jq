{w:[-1,0],nw:[0,1],ne:[1,1],e:[1,0],se:[0,-1],sw:[-1,-1]} as $dirs |
[
  inputs | [
    $dirs[
      ["", .] | recurse(
        last
        | select(length > 0)
        | match($dirs | keys | join("|")).length as $l
        | [.[:$l], .[$l:]]
      ) | first
    ]
  ] | transpose | map(add)
] | group_by(.) | map(select(length % 2 == 1)[0])

| nth(100; recurse(
  . as $black
  | [[., $dirs] | combinations | transpose | map(add)]
  | group_by(.) | map(select(
    length == 2 or length == 1 and (
      first as $idx | $black | bsearch($idx) >= 0
    )
  ) | first)
)) | length
