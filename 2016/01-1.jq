{
  "+0+1R": "+1+0",
  "+0-1R": "-1+0",
  "+1+0R": "+0-1",
  "-1+0R": "+0+1",
  "+0+1L": "-1+0",
  "+0-1L": "+1+0",
  "+1+0L": "+0+1",
  "-1+0L": "+0-1"
} as $rot |

reduce (input/", ")[] as $step (
  {dir: "+0+1", px: 0, py: 0};

  .dir |= $rot[. + $step[:1]]
  | .px = .px + ($step[1:] | tonumber) * (.dir[:2] | tonumber)
  | .py = .py + ($step[1:] | tonumber) * (.dir[2:4] | tonumber)
)
| (.px | fabs) + (.py | fabs)
