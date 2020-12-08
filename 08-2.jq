[inputs | split(" ") | {op:first,arg:last|tonumber}] as $program |
{ip:0,acc:0,visited:{},swap:true} | try (
  recurse(
    .step = $program[.ip]
    | ., (select(.swap) | .swap = false | .step.op = ({"nop":"jmp","jmp":"nop"}[.step.op] // empty))
    | .acc += {nop:0,jmp:0,acc:.step.arg}[.step.op]
    | .ip += {nop:1,acc:1,jmp:.step.arg}[.step.op]
    | if .ip == ($program|length) then error else . end
    | if .visited[.ip|tostring] then empty else .visited[.ip|tostring] = 1 end
  ) | empty
) catch .acc
