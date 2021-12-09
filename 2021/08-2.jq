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
      | .[[.tr, .br] | sort | join("")] = 1
      | .[[.t, .tr, .m, .bl, .b] | sort | join("")] = 2
      | .[[.t, .tr, .m, .br, .b] | sort | join("")] = 3
      | .[[.tl, .m, .tr, .br] | sort | join("")] = 4
      | .[[.t, .tl, .m, .br, .b] | sort | join("")] = 5
      | .[[.t, .tl, .m, .br, .b, .bl] | sort | join("")] = 6
      | .[[.tr, .br, .t] | sort | join("")] = 7
      | .[[.t, .tl, .m, .tr, .br, .b, .bl] | sort | join("")] = 8
      | .[[.t, .tl, .m, .tr, .br, .b] | sort | join("")] = 9
      | .[[.t, .tl, .tr, .br, .b, .bl] | sort | join("")] = 0
    )[last[] | split("") | sort | join("")]
  ] | map(tostring) | join("") | tonumber
] | add
