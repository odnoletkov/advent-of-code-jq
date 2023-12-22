def intersects($x; $y):
  .[0][0] > $x[1] or .[0][1] < $x[0] or .[1][0] > $y[1] or .[1][1] < $y[0] | not
  ;

[inputs/"~" | map(./"," | map(tonumber)) | transpose]
| sort_by(.[2][1])
| reduce .[] as [$x, $y, $z] (
  [[[[0, 9], [0, 9], []]]];
  first(
    (length - range(length) - 1) as $level
    | [.[$level][]? | select(intersects($x; $y))]
    | length
    | select(. > 0)
    | [$level, .]
  ) as [$level, $count]
  | (.[$level][] | select(intersects($x; $y)))[2] += [$count]
  | .[$level + $z[1] - $z[0] + 1] += [[$x, $y, []]]
)
| [.[1:][][]? | select(.[2] | all(. > 1))] | length
