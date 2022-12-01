[inputs] | join(",")/",," | map(split(",") | map(tonumber) | add) | sort[-3:] | add
