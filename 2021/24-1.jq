reduce inputs as $cmd (
  {input: ("99999999999999"/"" | map(tonumber)), w: 0, x: 0, y: 0, z: 0};
  (
    ($cmd | match("inp (.*)").captures[].string) as $inp
    | .[$inp]  = .input[0] | .input[:1] = []
  )
  //
  (
    ($cmd | match("add (.*) (.*)").captures | map(.string)) as [$a, $b]
    | .[$a] += (.[$b | strings] // ($b | tonumber))
  )
  //
  (
    ($cmd | match("mul (.*) (.*)").captures | map(.string)) as [$a, $b]
    | .[$a] *= (.[$b | strings] // ($b | tonumber))
  )
  //
  (
    ($cmd | match("div (.*) (.*)").captures | map(.string)) as [$a, $b]
    | .[$a] = (.[$a] / (.[$b | strings] // ($b | tonumber)) | trunc)
  )
  //
  (
    ($cmd | match("mod (.*) (.*)").captures | map(.string)) as [$a, $b]
    | .[$a] %= (.[$b | strings] // ($b | tonumber))
  )
  //
  (
    ($cmd | match("eql (.*) (.*)").captures | map(.string)) as [$a, $b]
    | .[$a] = if .[$a] == (.[$b | strings] // ($b | tonumber)) then 1 else 0 end
  )
  //
  error($cmd)
)
