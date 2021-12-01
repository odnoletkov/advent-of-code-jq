[inputs]
| (map(gsub("\\\\";"\\\\") | gsub("\"";"\\\"") | "\"" + . + "\"" | length) | add)
- (map(length) | add)
