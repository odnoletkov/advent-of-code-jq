25 as $sz |
[inputs|tonumber] as $in | $in
| last(while(any(.[:$sz][] + .[:$sz][] == .[$sz]; .); .[1:])[$sz + 1])
| {left:0,right:0,sum:0,target:.} | try (
  recurse(
    if .sum < .target then
      .sum += $in[.right] | .right += 1
    elif .sum > .target then
      .sum -= $in[.left] | .left += 1
    else
      error
    end
  ) | empty
) catch $in[.left:.right] | min + max
