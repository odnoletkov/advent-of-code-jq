[inputs/""] | . as $map | length as $length
| 26501365 as $target | 2 as $fill

| (2 * $fill * $length + ($target - 2 * $fill * $length) % (2 * $length)) as $sample

# | ($sample - $length) as $sample

| (($target - $sample) / 2 / $length) as $cycles
| debug({$target, $sample, $length, $cycles})

| [paths(. == "S")] as [$start] | [$start]

| [
  nth(
    $sample, $sample + 2 * $length;
    recurse(
      map(.[0] += (1, -1), .[1] += (1, -1)
      | select($map[.[0] % $length][.[1] % $length] != "#"))
      | unique
    )
  )
]
| . + [.[0] | map(select(0 <= .[0] and .[0] < $length and 0 <= .[1] and .[1] < 2 * $length))]

| map(length)

# N(M) = N(L) + (N(L + 1) - N(L)  - 4 * 2xMAP) * CYCLES + 4 * 2xMAP * CYCLES^2
| .[0] + (.[1] - .[0] - 4 * .[2]) * $cycles + 4 * .[2] * $cycles * $cycles
