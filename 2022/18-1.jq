[inputs/"," | map(tonumber)]
| [.[] | .[0] += (1, -1), .[1] += (1, -1), .[2] += (1, -1)] - .
| length
