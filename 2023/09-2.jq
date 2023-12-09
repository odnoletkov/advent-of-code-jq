[
  inputs/" " | map(tonumber) | reverse
  | while(length > 1; [.[range(length - 1):] | .[1] - .[0]])[-1]
] | add
