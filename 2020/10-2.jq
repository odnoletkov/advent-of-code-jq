[inputs|tonumber] | . + [0, (max + 3)] | sort
| reduce .[] as $i ([];
  map(select($i - first <= 3)) | . + [[$i, (map(last) | add // 1)]]
) | last | last
