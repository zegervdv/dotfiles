-- Inspired by https://github.com/EinfachToll/DidYouMean/blob/master/plugin/DidYouMean.vim

local filetypo = function()
  if vim.fn.filereadable(vim.fn.expand '%') == 1 then return end

  local filename = vim.fn.expand '%'
  local matching_files = vim.fn.split(vim.fn.glob(filename .. '*', 0), '\n')
  if matching_files == nil then matching_files = vim.fn.split(vim.fn.glob(filename .. '*', 1), '\n') end

  local buf = vim.api.nvim_get_current_buf()
  vim.schedule(function()
    vim.ui.select(matching_files, { prompt = 'Select File:' }, function(choice)
      vim.cmd.edit(vim.fn.fnameescape(choice))
      vim.api.nvim_buf_delete(buf, { force = true })

      vim.cmd.doautocmd { 'BufReadPre', mods = { silent = true } }
      vim.cmd.doautocmd { 'BufRead', mods = { silent = true } }
      vim.cmd.doautocmd { 'BufReadPost', mods = { silent = true } }
      vim.cmd.doautocmd { 'TextChanged', mods = { silent = true } }
    end)
  end)
end

vim.api.nvim_create_autocmd('BufNewFile', { pattern = '*', callback = filetypo })
