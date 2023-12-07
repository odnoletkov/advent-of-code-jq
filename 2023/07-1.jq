[
  inputs/" "
  | .[0] |= (
    ./"" | map({A: 14, K: 13, Q: 12, J: 11, T: 10}[.] // tonumber)
    | .[:0] = [group_by(.) | map(length) | sort | reverse]
  )
]
| sort | to_entries | map((.key + 1) * (.value[1] | tonumber)) | add
