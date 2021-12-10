[
  inputs/""
  | try reduce .[] as $i (
    [];
    {"]": "[", ")": "(", "}": "{", ">": "<"}[$i] as $match
    | if $match == null then
      . += [$i]
    elif $match == last then
      last |= empty
    else
      error
    end
  ) | reduce {"(": 1, "[": 2, "{": 3, "<": 4}[reverse[]] as $i (0; . * 5 + $i)
] | sort[length/2 | trunc]
