[
  inputs/":" | select(
    last/";" | all(
      ./"," | map(capture("(?<value>\\d+) (?<key>.*)")) | from_entries
      | .[] |= tonumber | .red <= 12 and .green <= 13 and .blue <= 14
    )
  )[0][5:] | tonumber
] | add
