def frombits:
  reduce .[] as $b (0; . * 2 + $b);

def parse_all:
  def parse_one:
    {
      version: .[:3] | frombits,
      type: .[3:6] | frombits,
    } as $base |
    if .[3:6] | frombits == 4 then
      (.[6:] | [while(first == 1; .[5:])[1:5]]) as $body |
      {
        value: (($body | add) + .[6 + ($body | length) * 5:][1:5]) | frombits
      },
      .[6 + ($body | length + 1 | . * 5):]
    elif .[6] == 0 then
      (.[7:][:15] | frombits) as $bits |
      {
        subpackets: [.[7 + 15:][:$bits] | parse_all]
      },
      .[7 + 15 + $bits:]
    elif .[6] == 1 then
      [limit(.[7:][:11] | frombits + 1; [{}, .[7 + 11:]] | recurse(last | [parse_one]))] as $body |
      {
        subpackets: $body[1:] | map(first)
      },
      $body[-1][1]
    else
      error
    end | objects += $base;
  [parse_one] as [$one, $rest] |
  $one, ($rest | select(length > 10) | parse_all);

def calc:
  .type as $type
  | if .type == 4 then
    .value
  else
    .subpackets | map(calc)
    | if $type == 0 then
      add
    elif $type == 1 then
      reduce .[] as $e (1; . * $e)
    elif $type == 2 then
      min
    elif $type == 3 then
      max
    elif $type == 5 then
      if first > last then 1 else 0 end
    elif $type == 6 then
      if first < last  then 1 else 0 end
    elif $type == 7 then
      if first == last then 1 else 0 end
    else
      error
    end
  end;

[
  {
    "0": "0000", "1": "0001", "2": "0010", "3": "0011",
    "4": "0100", "5": "0101", "6": "0110", "7": "0111",
    "8": "1000", "9": "1001", "A": "1010", "B": "1011",
    "C": "1100", "D": "1101", "E": "1110", "F": "1111",
  }[input/"" | .[]]/"" | .[] | tonumber
] | first(parse_all) | calc
