def rotate: map(split("")) | transpose | map(join("")) | reverse;
def flip: map(split("") | reverse | join(""));
[inputs] | join(",")/",," | map(split(","))
| INDEX(first | capture("^Tile (?<n>\\d+):$").n) | map_values(.[1:])
| map_values([.,rotate | .,flip | first,last])
| .[] -= [flatten | group_by(.)[] | select(length == 1)[]]
| map_values(select(length == 4))
| reduce (keys[] | tonumber) as $i (1; . * $i)
