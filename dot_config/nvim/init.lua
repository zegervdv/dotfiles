local lsp = require'lspconfig'
local lsputil = require'lspconfig.util'

require "nvim-treesitter.highlight"

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    }
  },
  refactor = {
    highlight_definitions = { enable = true },
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "grr",
      },
    },
    navigation = {
      enable = true,
      keymaps = {
        goto_definition = "gnd",
        list_definitions = "gnD",
      },
    },
  },
  textobjects = {
    move = {
      enable = true,
      goto_next_start = {
        ["]]"] = "@block.outer",
      },
      goto_previous_start = {
        ["[["] = "@block.outer",
      },
      goto_next_end = {
        ["]["] = "@block.outer",
      },
      goto_previous_end = {
        ["[]"] = "@block.outer",
      },
    },
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25,
    persist_queries = false
  }
}

local chain_complete_list = {
  default = {
    default = {
      {complete_items = {'lsp', 'snippet', 'ts', 'buffer'}},
      {complete_items = {'path'}, triggered_only = {'/'}},
      {complete_items = {'ts'}},
    },
    string = {
      {complete_items = {'path'}, triggered_only = {'/'}},
    },
    comment = {},
  }
}

local on_attach = function(client)
  require'completion'.on_attach({
    sorting = 'alphabet',
    matching_strategy_list = {'exact', 'fuzzy'},
    chain_complete_list = chain_complete_list,
  })
  -- This came from https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/lua/lsp_config.lua
  local mapper = function(mode, key, result)
    vim.fn.nvim_buf_set_keymap(0, mode, key, result, {noremap=true, silent=true})
  end

  vim.api.nvim_command('autocmd CursorHold <buffer> lua vim.lsp.diagnostic.show_line_diagnostics()')
  mapper('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<CR>')
  mapper('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>')
  mapper('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
  mapper('n', 'gD', '<cmd>lua vim.lsp.buf.implementation()<CR>')
  mapper('n', '1gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  mapper('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
  mapper('n', 'g0', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
  mapper('i', '<c-l>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
  mapper('n', '<leader>f', '<cmd>lua vim.lsp.buf.code_action()<CR>')
  mapper('n', '<c-p>', '<cmd>lua vim.lsp.buf.formatting()<CR>')
end

lsp.pyls.setup{
    cmd = {"pyls"},
    on_attach = on_attach;
}

if (vim.fn.executable('veridian') == 1) then
  lsp.veridian.setup{
    on_attach = on_attach;
  }
end

if (vim.fn.executable('efm-langserver') == 1) then
  lsp.efm.setup{
    on_attach = on_attach;
    root_dir = lsputil.root_pattern('.git', '.hg');
  }
end
