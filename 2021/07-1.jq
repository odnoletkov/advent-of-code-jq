input/"," | map(tonumber) | . as $v |
def f($base):
  $v | map(. - $base | fabs) | add;
[min, max] | until(
  last - first <= 1;
  (add / 2 | trunc) as $mid | if f($mid) < f($mid + 1) then [.[0], $mid] else [$mid, .[1]] end
) | map(f(.)) | min
