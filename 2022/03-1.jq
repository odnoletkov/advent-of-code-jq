[
  inputs
  | explode
  | [.[:length/2], .[length/2:] | unique]
  | first - (first - last)
  | (first - 38) % 58
] | add
