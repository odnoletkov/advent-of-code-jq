reduce inputs as $line ({};
  .cwd += [$line | match("cd (.*)").captures[].string]
  | (.cwd | select(last == "..")[-2:]) = []
  | getpath(.cwd).size += (($line | match("^\\d+ ").string | tonumber) // 0)
)
| walk(.size? += ([.[]?.size?] | add))
| [.. | numbers | select(. <= 100000)] | add
