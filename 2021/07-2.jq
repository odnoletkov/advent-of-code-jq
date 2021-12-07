input/"," | map(tonumber) | . as $crabs
| def cost($base):
  $crabs | map($base - . | fabs | (. + 1)*./2) | add;
[min, max] | until(
  last - first <= 1;
  (add/2 | trunc) as $mid |
  if cost($mid) < cost($mid + 1) then last else first end = $mid
) | map(cost(.)) | min
