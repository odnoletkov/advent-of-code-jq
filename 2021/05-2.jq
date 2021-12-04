[
  inputs/" -> " | map(split(",") | map(tonumber))
  | transpose | map([
    if first < last then
      range(first; last + 1)
    else
      range(first; last - 1; -1)
    end
  ])
  | if (first | length) == (last | length) then
    transpose[]
  else
    (first[] | [.]) + (last[] | [.])
  end
] | group_by(.) | map(select(length >= 2)) | length
