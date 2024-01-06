(section
  (name) @namespace)

(option
  (option_name) @keyword)

(path) @string.special.path
(string) @string
(bool) @constant.builtin.boolean

(comment) @comment

(template
  "{" @punctuation.special
  "}" @punctuation.special)

(template (number) @number)
(template (bool) @constant.builtin.boolean)

(function) @function
(keyword) @keyword

(operator) @operator

(string (escape) @constant.character.escape)

(regex) @string
