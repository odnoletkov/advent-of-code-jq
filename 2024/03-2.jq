[
  foreach (inputs | scan("mul\\((\\d+),(\\d+)\\)|(do(n't)?)\\(\\)")) as [$a, $b, $do] (
    "do"; $do // .; select(. == "do") | ($a | tonumber?) * ($b | tonumber?)
  )
] | add
