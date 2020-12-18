def parse:
  {ast:[],text:.}
  | try last(recurse(
    if (.text | length) == 0 or .text[:1] == ")" then
      .text |= .[1:] | error
    elif .text[:1] == "(" then    # ")"
      (.text[1:] | parse) as $sub |
      .ast += [$sub.ast] | .text = $sub.text
    else
      .ast += [.text[:1]] | .text |= .[1:]
    end
  )) catch .;

[
  inputs | gsub(" ";"") | parse.ast
  | walk((
    arrays | reduce (
      .[1:] | recurse(.[2:]; length > 0)
    ) as [$op, $arg] (
      first; if $op == "+" then . + $arg else . * $arg end
    )
  ) // tonumber? // .)
] | add
