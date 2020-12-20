[inputs] | join(",")/",," | map(split(","))
| (
  first | map(
    split(": ")
    | first |= tonumber
    | last |= (
      capture("\"(?<symbol>.)\"").symbol
      // {or: split(" | ") | map(split(" ") | map(tonumber))}
    )
  ) | sort_by(first) | map(last)
) as $rules

| def match($rule):
  if $rule|type == "string" then
    select(startswith($rule))[$rule|length:]
  elif $rule|type == "array" then
    label $out | reduce $rules[$rule[]] as $sub (.; match($sub) // break $out)
  else
    first(match($rule.or[]))
  end;

last | map(select(match($rules[0]) == "")) | length
