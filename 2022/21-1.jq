[inputs/": "] | INDEX(first) | .[] |= last | . as $all |
def calc($m):
  $all[$m] | tonumber? // (
    split(" ")
    | first = calc(first) | last = calc(last)
    | {
      "+": (first + last), "-": (first - last),
      "*": (first * last), "/": (first / last)
    }[.[1]]
  );
calc("root")
