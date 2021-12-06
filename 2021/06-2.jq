input/"," | group_by(.) | map({(first): length})
| ({} | .[range(9) | tostring] = 0) + add
| {idx: 0, counts: flatten}
| nth(256; recurse(
  .counts[(.idx + 7) % 9] += .counts[.idx % 9] | .idx += 1
)) | .counts | add
