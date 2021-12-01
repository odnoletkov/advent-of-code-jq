def tobits: [recurse(. / 2 | floor; . > 0) % 2];
def frombits: reduce reverse[] as $b (0; . * 2 + $b);
def bitand($a;$b): [$a,$b] | transpose | map(if all(. > 0) then 1 else 0 end);
def bitor($a;$b): [$a,$b] | transpose | map(if any(. > 0) then 1 else 0 end);

reduce (inputs/" = ") as [$op, $arg] (
  {};
  if $op == "mask" then
    .mask = ($arg/"" | reverse | {
      and: map({"0":0}[.]//1),
      or: map({"1":1}[.]//0)
    })
  else
    .memory[$op | capture("\\[(?<add>\\d+)\\]").add // error] =
    bitor(bitand($arg | tonumber | tobits; .mask.and); .mask.or)
  end
)
| [.memory[] | frombits] | add
