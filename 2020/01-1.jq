[
  [inputs|[tonumber]]
  | .[] + .[]
  | select(add == 2020)
  | first * last
] | unique[]
