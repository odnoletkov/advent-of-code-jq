[
  [inputs] | {
    network: .[2:] | map({(.[:3]): {L: .[7:10], R: .[12:15]}}) | add,
    ops: .[0], step: 0, node: .[2:][][:3] | scan("..A")
  }
  | until(.node[-1:] == "Z";
    .node = .network[.node][.ops[.step % (.ops | length):][:1]]
    | .step += 1
  ).step
]
| until(length == 1;
  .[:2] = [.[0] * .[1] / until(.[0] == 0; [.[1] % .[0], .[0]])[1]]
)[]
