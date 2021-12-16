[inputs]
| (.[2:] | map(split(" -> ") | {(first): (first[:1] + last)}) | add) as $m
| first | nth(10; recurse([$m[.[range(length - 1):][:2]]] + [.[-1:]] | add))
| split("") | group_by(.) | map(length) | sort | last - first
