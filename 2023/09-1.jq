[
  inputs/" " | map(tonumber)
  | while(length > 1; [while(length > 1; .[1:]) | .[1] - .[0]])[-1]
] | add
