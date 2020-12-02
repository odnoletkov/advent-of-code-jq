[inputs|[tonumber]]
| .[] + .[]
| select(add == 2020)
| reduce .[] as $x (1; . *= $x)
