reduce inputs as $line ({};
  .cwd += [$line | match("cd (.*)").captures[].string]
  | (.cwd | select(last == "..")[-2:]) = []
  | getpath(.cwd).size += (($line | match("^\\d+ ").string | tonumber) // 0)
)
| walk(.size? += ([.[]?.size?] | add))
| (.size - (70000000 - 30000000)) as $target
| [.. | numbers | select(. >= $target)] | min
