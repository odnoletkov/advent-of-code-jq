[inputs/"   "] | transpose
| (.[1] | group_by(.) | map({(.[0]): length}) | add) as $idx
| [.[0][] | tonumber * ($idx[.] // 0)] | add
