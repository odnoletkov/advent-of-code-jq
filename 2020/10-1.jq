[inputs|tonumber] | . + [0, (max + 3)] | sort
| [.[:-1], .[1:]] | transpose | map(last - first)
| group_by(.) | map(select([first] | inside([1,3])) | length)
| reduce .[] as $i (1; . * $i)
