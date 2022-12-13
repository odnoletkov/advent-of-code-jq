[inputs | match("\\[\\]|\\d+").string | tonumber? // 0]
| (map(select(. < 2)) | length + 1) * (map(select(. < 6)) | length + 2)
