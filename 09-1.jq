25 as $sz |
[inputs|tonumber]
| last(while(any(.[:$sz][] + .[:$sz][] == .[$sz]; .); .[1:]))[$sz + 1]
