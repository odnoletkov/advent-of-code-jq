def tobits: [recurse(. / 2 | floor; . > 0) % 2];
def frombits: reduce reverse[] as $b (0; . * 2 + $b);

def mask($value; $mask):
  [$value, $mask] | transpose | map({"0":first}[last] // last)
  | {d:0,b:reverse} | recurse(
    if (.b | length) == 0 then
      empty
    elif .b[0] == "X" then
      .b[0] = ("0","1")
    else
      .d = .d * 2 + (.b[0] | tonumber) |
      .b = .b[1:]
    end
  ) | select(.b | length == 0).d
  ;

reduce (inputs/" = ") as [$op, $arg] (
  {};
  if $op == "mask" then
    .mask = ($arg/"" | reverse)
  else
    .memory[
      mask($op | capture("\\[(?<add>\\d+)\\]").add | tonumber | tobits; .mask)
      | tostring
    ] = ($arg | tonumber)
  end
)

| .memory | add
