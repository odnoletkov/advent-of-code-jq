[
  inputs/""
  | try (
    reduce .[] as $i (
      [];
      {"]": "[", ")": "(", "}": "{", ">": "<"}[$i] as $match
      | if $match == null then
        . += [$i]
      elif $match == last then
        last |= empty
      else
        error($i)
      end
    ) | 0
  ) catch {")": 3, "]": 57, "}": 1197, ">": 25137}[.]
] | add
