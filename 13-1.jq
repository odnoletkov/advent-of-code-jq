[inputs]
| (first | tonumber) as $target
| last | split(",")
| map(tonumber? | [., . - $target % .])
| min_by(last) | first * last
