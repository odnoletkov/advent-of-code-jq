input/"," | map(tonumber)
| .[] -= sort[length/2]
| map(fabs) | add
