20201227 as $mod |

def transform($s):
  1 | recurse(. * $s % $mod);

def fast($s; $n):
  if $n == 0 then
    1
  elif $n % 2 == 0 then
    fast($s * $s % $mod; $n/2)
  else
    $s * fast($s; $n - 1) % $mod
  end;

[inputs | tonumber] as $public
| try reduce transform(7) as $r (
  0; if $public[] == $r then error else . + 1 end
) catch fast($public - [fast(7; .)] | first; .)
