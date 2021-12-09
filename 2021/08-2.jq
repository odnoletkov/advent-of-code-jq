[
  inputs/" | " | map(split(" ")) |
  [
    (
      first | group_by(length) | map({(first | length | tostring): map(split(""))}) | add
      | {p: .}
      | .t = (.p."3"[0] - .p."2"[0])[0]
      | .b = (.p."6"[] - .p."4"[0] - [.t] | select(length == 1)[0])
      | .bl = ([.p."6"[] - .p."4"[0] - [.t, .b]] | flatten | unique[0])
      | .m = ((.p."5" | flatten | group_by(.) | map(select(length == 3)[0])) - [.t, .b])[0]
      | .tl = ((.p."5" | flatten | group_by(.) | map(select(length == 1)[0])) - [.bl])[0]
      | .tr = ((.p."6" | flatten | group_by(.) | map(select(length == 2)[0])) - [.m, .bl])[0]
      | .br = (.p."2"[0] - [.tr])[0]
      | [
        [.t, .tl, .tr, .br, .b, .bl],
        [.tr, .br],
        [.t, .tr, .m, .bl, .b],
        [.t, .tr, .m, .br, .b],
        [.tl, .m, .tr, .br],
        [.t, .tl, .m, .br, .b],
        [.t, .tl, .m, .br, .b, .bl],
        [.tr, .br, .t],
        [.t, .tl, .m, .tr, .br, .b, .bl],
        [.t, .tl, .m, .tr, .br, .b]
      ] | to_entries | map({(.value | sort | join("")): .key}) | add
    )[last[] | split("") | sort | join("")]
  ] | map(tostring) | join("") | tonumber
] | add
