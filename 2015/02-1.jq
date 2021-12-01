def comb($n):
  if n == 1 then 
    .[] | [.]
  elif length < n then
    empty
  elif length == n then
    .
  else
    [.[0]] + (.[1:] | comb($n - 1)),
    (.[1:] | comb($n))
  end;

[
  inputs
  | [split("x") | map(tonumber) | comb(2) | 2 * .[0] * .[1]]
  | add + min/2
] | add
