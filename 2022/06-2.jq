inputs/"" | length + 14 - first(recurse(.[1:]) | select(.[:14] | unique | length == 14) | length)
