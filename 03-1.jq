[
  [inputs]
  | recurse(.[1:] | .[] |= .[3:] + .[:3] | select(length > 0))
  | {"#":1}[.[0][:1]]
][1:] | add
