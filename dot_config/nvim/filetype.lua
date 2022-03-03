vim.g.did_load_filetypes = 0
vim.g.do_filetype_lua = 1

vim.filetype.add {
  extension = { xdc = 'xdc', ['do'] = 'tcl', make = 'make' },
}
