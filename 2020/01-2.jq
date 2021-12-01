[
  [inputs] | INDEX(.) as $index
  | map([tonumber]) | .[] + .[]
  | select($index[2020 - add | tostring])
  | (2020 - add) * first * last
] | unique[]
