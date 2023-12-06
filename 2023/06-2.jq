[inputs[9:]/" " | add | tonumber]
| .[0] * .[0] - 4 * .[1] | sqrt/2
| floor + ceil
