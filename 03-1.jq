[
  [inputs]
  | recurse(.[1:] | map(.[3:] + .[:3]); length > 0)
  | {"#":1}[first[:1]]
][1:] | add
