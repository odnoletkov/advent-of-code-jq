[inputs/" -> " | .[1] = (.[1]/", ")[]]
| transpose | .[1] = [(.[0] | INDEX(.[1:]))[.[1][]]] | transpose
| (group_by(.[0]) | INDEX(.[0][0]) | .[] |= [.[][1]]) as $outs
| group_by(.[1]) | INDEX(.[0][1] | select(.[:1] != "%")) | .[] |= INDEX(.[0])
| [
  {
    state: .,
    target: last(. as $ins | ["null"] | while(.[0][:1] != "%"; [$ins[.[]] | to_entries[].key]))[]
  }
  | until(
    .pulses[0];
    .pulses = [{to: "broadcaster", low: true}] | .step += 1
    | until(
      isempty(.pulses[]) or (.pulses[0].from == .target and .pulses[0].low);
      .pulses as [{$from, $to, $low}]
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
  ).step
] | reduce .[] as $n (1; . * $n)
