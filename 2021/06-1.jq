input/"," | map(tonumber)
| nth(80/7 | trunc; recurse(map(. % 7) + map(select(. < 7) | . + 2)))
| length + (map(select(. < 80 % 7)) | length)
