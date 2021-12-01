[inputs]
| (map(length) | add)
- (map(gsub("^\"|\"$";"") | gsub("\\\\(\\\\|\"|x[[:xdigit:]]{2})";"1") | length) | add)
