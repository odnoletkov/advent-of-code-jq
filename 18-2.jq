def parse:
  {ast:[],text:.} | until(
    (.text | length) == 0 or .text[:1] == ")";
    if .text[:1] == "(" then    # ")"
      (.text[1:] | parse) as {$ast,$text} |
      .ast += [$ast] | .text = $text[1:]
    else
      .ast += [.text[:1]] | .text |= .[1:]
    end
  );

[
  inputs | gsub(" ";"") | parse.ast

  | walk((
    arrays | last(recurse(
      (index("+") // empty) as $i
      | .[$i - 1:][:3] |= [.]
    ))
  ) // .)

  | walk((
    arrays | reduce (
      .[1:] | while(length > 0; .[2:])
    ) as [$op, $arg] (
      first; if $op == "+" then . + $arg else . * $arg end
    )
  ) // tonumber? // .)
] | add
