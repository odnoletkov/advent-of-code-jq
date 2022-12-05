inputs/"" | length + 4 - first(recurse(.[1:]) | select(.[:4] | unique | length == 4) | length)
