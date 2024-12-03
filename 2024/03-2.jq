[
  inputs | foreach scan("mul\\((\\d{1,3}+),(\\d{1,3}+)\\)|(do(n't)?)\\(\\)") as [$a, $b, $do] (
    "do"; $do // .;
    select(. == "do") | ($a | tonumber?) * ($b | tonumber?)
  )
] | add
