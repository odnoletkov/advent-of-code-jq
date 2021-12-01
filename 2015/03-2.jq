inputs | split("") | [recurse(.[2:]; length > 0)[:2]] | transpose
| .[] |= [[0,0]] + [foreach {"<":[-1,0],">":[1,0],"^":[0,1],"v":[0,-1]}[.[]] as $m ([0,0]; .[0] += $m[0] | .[1] += $m[1])]
| flatten(1) | unique | length
