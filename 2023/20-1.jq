[inputs/" -> " | .[1] = (.[1]/", ")[]]
| transpose | .[1] = [(.[0] | INDEX(.[1:]))[.[1][]]] | transpose
| (group_by(.[0]) | INDEX(.[0][0]) | .[] |= [.[][1]]) as $outs
| (group_by(.[1]) | INDEX(.[0][1] | select(.[:1] == "&")) | .[] |= INDEX(.[0]))
| {state: .}
| nth(1000; recurse(
  .pulses = [{to: "broadcaster", low: true}]
  | until(
    isempty(.pulses[]);
    .pulses as [{$from, $to, $low}]
    # | debug("\($from) -\(if $low then "low" else "high" end)-> \($to)")
    | .sent[$low | tostring] += 1
    | if $to[:1] == "%" then
      if $low then
        .state[$to] |= not | .send = (.state[$to] | not)
      else
        .send = null
      end
    elif $to[:1] == "&" then 
      .state[$to][$from] = $low | .send = all(.state[$to][]; not)
    else
      .send = $low
    end
    | .pulses += [{from: $to, to: $outs[$to]?[], low: .send | values}]
    | del(.pulses[0])
  )
))
| [.sent[]] | .[0] * .[1]
