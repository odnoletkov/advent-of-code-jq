def transform($subj): 1 | recurse(. * $subj % 20201227);
[inputs | tonumber] as $pub
| try reduce transform(7) as $r (
  0; if any($pub[] == $r; .) then error else . + 1 end
) catch .
| nth(.; transform($pub - [nth(.; transform(7))] | first))
