def cmp:
  if any(arrays) then
    map(arrays // [.])
    | .[][map(length) | min:] |= [length]
    | first(transpose[] | cmp | values)
  else
    if first == last then null else first < last end
  end;

[
  [inputs] | recurse(.[3:]; first)[:2] | map(fromjson) | cmp
] | to_entries | map(select(.value != false).key + 1) | add
