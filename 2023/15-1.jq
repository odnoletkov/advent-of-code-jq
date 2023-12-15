input/","
| map(reduce explode[] as $c (0; (. + $c) * 17 % 256))
| add
