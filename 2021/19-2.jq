def transform($m):
  [[.] + ($m[] | [.]) | transpose | map(first * last) | add];

[inputs] | join(";")/";;" | map(
  split(";")[1:] | map(split(",") | map(tonumber))
  | [
    [.] + (.[] | [.]) | {
      xyz: last,
      sig: [(first[] | [.]) + [last] | transpose | map(last - first | fabs) | add]
    }
  ]
  | {points: .}
)
| first.done = false | first.origin = [0, 0, 0]
| nth(length; recurse(
  first(.[] | select(.done == false)) as $target
  | first(.[] | select(.done == false)).done = true
  | (.[] | select(.done == null)) |= (
    (
      [
        limit(
          2;
          ($target.points[] | [.]) + (.points[] | [.])
          | select((first.sig | length) - (first.sig - last.sig | length) >= 12)
          | map(.xyz)
        )
      ] as $match
      | (
        $match | select(length > 0)
        | transpose | map(transpose | map(first - last)) | . as [$from, $to]
        | [[1, 0, 0], [-1, 0, 0], [0, 1, 0], [0, -1, 0], [0, 0, 1], [0, 0,-1]]
        | map([.]) | .[] + .[] + .[]
        | select(. as $m | $from == ($to | transform($m)))
      ) as $tx
      | ($match[0] | last |= transform($tx) | transpose | map(last - first)) as [$x, $y, $z]
      | .origin = [$x, $y, $z]
      | .points[].xyz |= (transform($tx) | .[0] -= $x | .[1] -= $y | .[2] -= $z)
      | .done = false
    ) // .
  )
)) | [
  map([.origin]) | .[] + .[] | transpose | map(last - first | fabs) | add
] | max
