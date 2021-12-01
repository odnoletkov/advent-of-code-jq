[
  inputs
  | select(any(recurse(.[1:]; length > 1) | indices(.[:2]); length > 1))
  | select(any(./"" | [.[:-2],.[2:]] | transpose[]; first == last))
] | length
