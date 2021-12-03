[inputs/""] | transpose
| map(group_by(.) | sort_by(length) | last | first | tonumber)
| [(., map((. + 1) % 2)) | reduce .[] as $b (0; . * 2 + $b)]
| first * last
