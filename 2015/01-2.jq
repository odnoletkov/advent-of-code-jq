[try foreach {"(":1,")":-1}[input | split("")[]] as $s (0; . + $s; . >= 0 // error(""))] | length + 1
