[
  [inputs | explode | unique]
  | recurse(.[3:]; length > 0)[:3]
  | first - (first - (last - (last - .[1])))
  | (first - 38) % 58
] | add
