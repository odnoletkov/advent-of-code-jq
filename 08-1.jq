[inputs | split(" ") | .[1] |= tonumber] as $p |
0 | try reduce
  recurse(. + {nop:1,acc:1,jmp:$p[.][1]}[$p[.][0]])
as $s ({}; if .[$s|tostring] then error else .[$s|tostring] = 1 end)
catch [$p[keys[]|tonumber] | select(.[0] == "acc")[1]] | add
