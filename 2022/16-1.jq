[
  inputs | capture("Valve (?<key>..) has flow rate=(?<rate>\\d+); tunnels? leads? to valves? (?<to>.*)")
  | .rate |= tonumber | .to |= (./", " | map({(.): 1}) | add) | .value = {rate, to}
] | from_entries
| . as $m | .[].to |= until(
  length == ($m | length);
  (to_entries | map(.to = $m[.key].to | .to[] += .value | .to) | add) + .
)
| {AA} + (.[] |= select(.rate > 0))
| . as $m | {pos: "AA", open: ["AA"], time: 30} | reduce recurse(
  .pos as $from | .pos = (($m | keys) - .open)[] | .open += [.pos]
  | .time -= $m[$from].to[.pos] + 1 | .pressure += $m[.pos].rate * .time;
  .time >= 0 
) as {$pressure} (0; if $pressure > . then $pressure else . end)
