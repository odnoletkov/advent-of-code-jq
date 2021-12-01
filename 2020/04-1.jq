(["byr","iyr","eyr","hgt","hcl","ecl","pid","cid"] - ["cid"]) as $fields |
[
  [inputs]
  | join(",") | split(",,")[] | split(",") | join(" ")
  | [split(" ")[] | split(":") | {(.[0]):.[1]}] | add
  | keys | select(contains($fields))
] | length
