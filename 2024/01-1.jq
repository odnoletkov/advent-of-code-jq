[inputs/"   " | map(tonumber)] | transpose | map(sort) | transpose
| map(.[0] - .[1] | fabs) | add
