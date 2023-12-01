["", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
| to_entries[1:] | map({(.value): .key}) | add as $digits |

def digit(f):
  f | match("\\d|\($digits | keys_unsorted | join("|") | f)").string | $digits[f] // tonumber;

[inputs | digit(.)*10 + digit(./"" | reverse | add)] | add
