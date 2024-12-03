[inputs/"   "] | transpose | [(.[1] | group_by(.) | INDEX(.[0]))[.[0][]][]? | tonumber] | add
