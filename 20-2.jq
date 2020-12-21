def rotate: map(split("")) | transpose | map(join("")) | reverse;
def flip: map(split("") | reverse | join(""));

[inputs] | join(",")/",," | map(split(","))
| INDEX(first | capture("^Tile (?<n>\\d+):$").n)
| map_values(.[1:]) | . as $tiles
| map_values([.,rotate | .,flip | first,last])
| (
  [to_entries[] | {key:.value[],value:.key}] | group_by(.key)
  | map({key:first.key,value:map(.value)}) | from_entries
) as $edgetotile

| def restore:
  {next:.} | recurse(
    .prevtile = ($edgetotile[.next] - [.prevtile] | first // empty)
    | .tile = (
      .next as $next
      | $tiles[.prevtile]
      | limit(4; recurse(rotate)) | .,flip
      | select(first == $next)
    )
    | .next = (.tile | last)
  ).tile // empty; .

| [flatten | group_by(.)[] | select(length == 1)[]] as $border
| map(. - (. - $border) | select(length == 4))
| first | . - (. - map(first(restore) | rotate | first)) | first
| [restore | rotate | last | restore | .[1:-1] | map(.[1:-1])]
| (length | sqrt) as $size
| [recurse(.[$size:]; length > 0)[:$size] | add]
| transpose | map(add)

| [
  "                  # ",
  "#    ##    ##    ###",
  " #  #  #  #  #  #   "
] as $monster
| (
  ([limit(length - ($monster[0] | length); repeat("."))] | join("")) as $fill
  | $monster | join($fill) | gsub(" ";".")
) as $re
| def roughness($str): $str | gsub("\\."; "") | length; .

| roughness(join("")) - (
  [
    limit(4; recurse(rotate)) | .,flip
    | "x" + join("")
    | [recurse(.[match($re).offset + ($monster[0] | length):])]
    | length - 1
  ] | max
) * roughness($re)
