inputs
| [foreach {"<":[-1,0],">":[1,0],"^":[0,1],"v":[0,-1]}[split("")[]] as $m ([0,0]; .[0] += $m[0] | .[1] += $m[1])]
| ([[0, 0]] + .) | unique | length
