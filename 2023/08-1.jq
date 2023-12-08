[inputs] | {
  network: .[2:] | INDEX(.[:3]) | map_values({L: .[7:10], R: .[12:15]}),
  instructions: (.[0]/""),
  node: "AAA",
  step: 0
}
| until(.node == "ZZZ";
  .node = .network[.node][.instructions[.step % (.instructions | length)]]
  | .step += 1
).step
