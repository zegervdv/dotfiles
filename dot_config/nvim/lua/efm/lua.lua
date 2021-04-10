local languages = require 'efm/languages'

languages.lua = {}

if (vim.fn.executable('lua-format') == 1) then
  table.insert(languages.lua, {
    formatCommand = "lua-format -c ~/.config/lua-format/conf.yml",
    formatStdin = true
  })
end
