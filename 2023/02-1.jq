[
  inputs/":" | select(
    all(last | scan("(\\d+) (.)"); (first | tonumber) <= {r: 12, g: 13, b: 14}[last])
  )[0][5:] | tonumber
] | add
