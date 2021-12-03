def calc(selector):
  {numbers: ., idx: 0} | first(
    recurse(
      .idx as $idx | .idx += 1 |
      (.numbers | transpose[$idx] | group_by(.) | sort_by([length, first]) | selector | last) as $v | 
      .numbers |= map(select(.[$idx] == $v))
    ) | .numbers | select(length == 1)
  ) | first | reduce .[] as $b (0; . * 2 + ($b | tonumber));

[inputs/""] | calc(first) * calc(last)
