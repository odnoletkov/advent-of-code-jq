def number($range): tonumber | $range[0] <= . and . <= $range[1];
{amb,blu,brn,gry,grn,hzl,oth} as $ecls |
[
  [inputs]
  | join(",") | split(",,")[] | split(",") | join(" ")
  | [split(" ")[] | split(":") | {(.[0]):.[1]}] | add
  | try [
    (.byr | number([1920,2002])),
    (.iyr | number([2010,2020])),
    (.eyr | number([2020,2030])),
    (.hgt | if endswith("cm") then .[:-2] | number([150,193]) elif endswith("in") then .[:-2] | number([59,76]) else false end),
    (.hcl | test("^#[0-9a-f]{6}$")),
    (.ecl | in($ecls)),
    (.pid | length == 9 and tonumber),
    true
  ] | select(all)
] | length
