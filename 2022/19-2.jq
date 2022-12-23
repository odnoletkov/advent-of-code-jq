[
  inputs | [
    scan("Each \\w+ robot costs ([^.]*)")[0]/" and " | map(./" " | {(.[1]): .[0] | tonumber}) | add | [.ore,.clay,.obsidian,.geode] | .[] //= 0
  ]
][:3]

| first

| (.[][] *= -1) as $cost |
def buy($i):
  .resources = ([.resources, $cost[$i]] | transpose | map(add) | select(all(. >= 0)))
  | .robots[$i] += 1;

def dfs:
  select(.minute >= 0)
  | .robots as $supply | (
    buy(.want)
    | .want = (
      (select(.robots[0] <= 2) | 0),
      (select(.resources[1] < 11) | 1),
      (select(.resources[2] < 10 and .robots[1] > 0) | 2),
      (select(.robots[2] > 0) | 3)
    )
  ) // .
  | .resources |= ([., $supply] | transpose | map(add))
  | .minute -= 1
  ;

{
  resources: [0,0,0,0],
  robots: [1,0,0,0],
  minute: 20,
  want: (0, 1),
} | dfs
