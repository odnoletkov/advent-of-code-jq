[
  inputs
  | empty
  // (capture("^(?<from>\\w+) -> (?<to>[a-z]+)$") | {lhs:.from,rhs:.from,op:"AND",to})
  // (capture("^NOT (?<v>\\w+) -> (?<to>[a-z]+)$") | {lhs:.v,rhs:.v,op:"NOT",to})
  // capture("^(?<lhs>\\w+) (?<op>\\w+) (?<rhs>\\w+) -> (?<to>[a-z]+)$")
  | (.lhs,.rhs) |= if test("^[a-z]+$") then . else tonumber end
] | INDEX(.to) as $ops |

def tobits: [recurse(. / 2 | floor; . > 0) % 2];
def frombits: reduce reverse[] as $b (0; . * 2 + $b);
def lshift($lhs; $rhs): $lhs | [range($rhs) | 0] + tobits | frombits;
def rshift($lhs; $rhs): $lhs | tobits[$rhs:] | frombits;

def calc: #debug |
  $ops[.]
  | (.lhs,.rhs) |= (numbers // calc)
  | if .op == "AND" then
    [.lhs,.rhs] | map(tobits) | transpose | map(if all(. > 0) then 1 else 0 end) | frombits
  elif .op == "OR" then
    [.lhs,.rhs] | map(tobits) | transpose | map(if any(. > 0) then 1 else 0 end) | frombits
  elif .op == "LSHIFT" then
    lshift(.lhs; .rhs)
  elif .op == "RSHIFT" then
    rshift(.lhs; .rhs)
  elif .op == "NOT" then
    65535 - .lhs
  else
    error
  end
;

$ops[] | select([(.lhs,.rhs)|numbers]|length==2).to | calc

# [[.[].to] | unique[] | {(.): calc}] | add

# .[].to

# "hf" | calc

# .[] | "\(.to): " + ([(.lhs|strings)//empty,(.rhs|strings)//empty] | join(" "))

# ["a"]
# | limit(20000; recurse(
#   . + ($ops[last] | (.lhs,.rhs) | strings | [.]);
#   if indices(last) | length != 1 then error else . end
# ))
