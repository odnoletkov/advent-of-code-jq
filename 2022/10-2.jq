[1, foreach (inputs[5:] | 0, tonumber?) as $V (1; . + $V)]
| recurse(.[40:]; length > 1)[:40] | to_entries
| map(["#", "#"][.key - .value | fabs] // ".") | add
