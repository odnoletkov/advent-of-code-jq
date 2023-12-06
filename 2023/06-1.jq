reduce (
  [inputs[9:] | [scan("\\d+") | tonumber]] | transpose[]
  | [(range(.[0]) | [.]) + . | select((.[1] - .[0]) * .[0] > .[2])] | length
) as $n (1; . *= $n)
