(["byr","iyr","eyr","hgt","hcl","ecl","pid","cid"] - ["cid"]) as $fields |
[
  [inputs]
  | recurse(.[(index("")//length)+1:]; length > 0) | .[:index("")] | join(" ")
  | [split(" ")[] | split(":") | {(.[0]):.[1]}] | add
  | keys | select(contains($fields))
] | length
