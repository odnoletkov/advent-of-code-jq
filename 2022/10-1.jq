reduce inputs as $cmd ([1];
  .[-1:] |= [last + (range({noop: 1, addx: 2}[$cmd[:4]] + 1) | 0)]
  | last += (($cmd | match("addx (.*)").captures[].string | tonumber) // 0) 
) | [to_entries[range(20; 220 + 1; 40) - 1] | (.key + 1) * .value] | add
