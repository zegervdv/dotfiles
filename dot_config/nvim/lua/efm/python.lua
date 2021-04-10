local languages = require 'efm/languages'

languages.python = {};

if (vim.fn.executable('black') == 1) then
  table.insert(languages.python, { formatCommand = 'black -', formatStdin = true })
end

if (vim.fn.executable('flake8') == 1) then
  table.insert(languages.python, {
    lintCommand = 'flake8 --stdin-display-name ${INPUT} -',
    lintStdin = true,
    lintIgnoreExitCode = true,
    lintFormats = { '%f:%l:%c: %m' },
  })
end

