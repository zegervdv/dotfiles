(subject) @markup.heading
(path) @string.special.path
(commit) @constant
(item) @markup.link.url

(change kind: "added" @diff.plus)
(change kind: "removed" @diff.minus)
(change kind: "changed" @diff.delta)

(meta
  key: (meta_key) @type
  value: (meta_value) @string)

(trailer
  key: (trailer_key) @variable.other.member
  value: (trailer_value) @string)

[":" "=" "->" (scissors)] @punctuation.delimiter
(comment) @comment
