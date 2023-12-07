[inputs/" "] | sort_by(
  .[0]/"" | (
    group_by(.) | map({(.[0]): length}) | add
    | .J as $J | [del(.J)[]] | sort | reverse | .[0] += $J
  ), map({A:14,K:13,Q:12,J:1,T:10}[.] // tonumber)
) | to_entries | map((.key + 1) * (.value[1] | tonumber)) | add
