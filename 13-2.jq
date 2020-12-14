[inputs] | last/"," | to_entries
| map(.value = (.value | tonumber?) | .key %= .value)
| reduce .[1:][] as {$key, $value} (
  first;
  until(.key % $value == $key; .key += .value) | .value *= $value
) | .value - .key
