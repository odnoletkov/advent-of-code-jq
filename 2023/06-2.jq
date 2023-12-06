[inputs[9:]/" " | add | tonumber]
| [(range(.[0]) | [.]) + . | select((.[1] - .[0]) * .[0] > .[2])]
| length
