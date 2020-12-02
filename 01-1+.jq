# TODO: generalize to N terms
INDEX(inputs|tonumber;.) as $set
| $set[]
| . * ($set[2020 - . | tostring] // empty)
