[inputs/" | " | last/" "] | flatten | map(length)
| map(select([.] | inside([2, 3, 4, 7]))) | length
