[inputs | scan("mul\\((\\d+),(\\d+)\\)") | map(tonumber) | .[0] * .[1]] | add
