[inputs] | join(",")/",," | map(split(","))

| first += [
  "8: 42 | 42 8",
  "11: 42 31 | 42 11 31"
]

| (
  first | map(
    split(": ") | {
      key: first,
      value: (
        last | capture("\"(?<symbol>.)\"").symbol
        // {or: split(" | ") | map(split(" "))}
      )
    }
  ) | from_entries
) as $rules

| def match($rule):
  if $rule|type == "string" then
    select(startswith($rule))[$rule|length:]
  elif $rule|type == "array" then
    {rules:$rule, text:.} | until(
      .rules | length == 0;
      $rules[.rules[0]] as $head | {
        text: .text | match($head),
        rules: .rules[1:]
      }
    ).text
  else
    match($rule.or[])
  end;

last | map(select(match($rules["0"]) == "")) | length
