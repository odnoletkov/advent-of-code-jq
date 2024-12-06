[inputs] | join(";")/";;" | map(./";" | map(split("\\||,"; "")))
| (reduce .[0][] as $p ({}; setpath($p; 1))) as $i
| [.[1][] | select(all(.[range(length - 1):]; $i[.[0]][.[1]]))[length/2] | tonumber] | add
