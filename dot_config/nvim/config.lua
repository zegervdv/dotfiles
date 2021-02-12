--
-- Neovim dotfiles
--
--

local execute = vim.api.nvim_command
local fn = vim.fn

-- Bootstrap package manager
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end

-- Packer configuration is compiled and only needs to be loaded on changes
function packer_enable()
  vim.cmd "packadd packer.nvim"

  require('packer').startup(function()
    use {'wbthomason/packer.nvim', opt = true}

    -- General plugins
    use {'tpope/vim-sensible'}
    use {'tpope/vim-repeat'}
    use {'tpope/vim-rsi'}
    use {'sgur/vim-editorconfig'}
    use {'ShikChen/osc52.vim'}
    use {'einfachtoll/didyoumean'}

    use {'tpope/vim-obsession'}
    use {
      'tpope/vim-eunuch',
      cmd = {
        'Remove',
        'Unlink',
        'Move',
        'Rename',
        'Mkdir',
        'Chmod',
        'Find',
        'Locate',
        'SudoEdit',
        'SudoWrite'
      }
    }

    use {'psliwka/vim-smoothie'}

    -- Spelling/autocorrection
    use {'tpope/vim-abolish'}

    -- Git/VCS
    use {'vim-scripts/gitignore'}
    use {'sjl/splice.vim', opt = true, cmd = {'SpliceInit'}}
    use {'tpope/vim-git'}

    -- Comments
    use {'tpope/vim-commentary'}

    -- Undoing
    use {'sjl/gundo.vim', cmd = {'GundoToggle'}}

    -- Parentheses etc
    use {'tpope/vim-surround'}
    use {'raimondi/delimitMate'}

    -- Moving around within lines
    use {'wellle/targets.vim', event = 'InsertEnter *'}

    -- Searching
    use {'mhinz/vim-grepper', cmd = {'Grepper'}}

    -- Indent lines
    use {'Yggdroot/indentline'}
    use {'lukas-reineke/indent-blankline.nvim', branch = 'lua'}

    -- Tmux
    function test_tmux()
      return os.getenv('TMUX') ~= nil
    end
    use {'christoomey/vim-tmux-navigator'}
    use {'tmux-plugins/vim-tmux-focus-events', cond = test_tmux}

    -- Completion/snippets/LSP
    use {'neovim/nvim-lspconfig'}
    use {
      'hrsh7th/nvim-compe',
      config = function ()
        require'compe'.setup {
          enabled = true;
          autocomplete = true;
          debug = false;
          min_length = 1;
          preselect = 'enable';
          throttle_time = 80;
          source_timeout = 2000;
          incomplete_delay = 400;
          max_abbr_width = 100;
          max_kind_width = 100;
          max_menu_width = 100;

          source = {
            path = true;
            buffer = true;
            calc = true;
            nvim_lsp = true;
            nvim_lua = true;
            spell = true;
            ultisnips = true;
            treesitter = true;
          };
        }

        vim.cmd [[ inoremap <silent><expr> <TAB> compe#complete() ]]
        vim.cmd [[ inoremap <silent><expr> <CR>      compe#confirm({ 'keys': "\<Plug>delimitMateCR", 'mode': '' }) ]]
        vim.cmd [[ inoremap <silent><expr> <C-e>     compe#close('<C-e>') ]]
      end
    }
    use {
      'nvim-treesitter/nvim-treesitter',
      'nvim-treesitter/nvim-treesitter-refactor',
      'nvim-treesitter/nvim-treesitter-textobjects',
      {'nvim-treesitter/playground', opt = true}
    }
    use {'SirVer/ultisnips'}
    use {
      'glepnir/lspsaga.nvim',
      config = function()
        require 'lspsaga'.init_lsp_saga { max_diag_msg_width = 300 }
      end
    }
    use {
      'nvim-telescope/telescope.nvim',
      requires = {
        'nvim-lua/popup.nvim',
        'nvim-lua/plenary.nvim'
      }
    }

    -- File navigation
    use {'justinmk/vim-dirvish'}

    -- Colorscheme
    use {'zegervdv/nvcode-color-schemes.vim'}

    -- Terminal
    use {'akinsho/nvim-toggleterm.lua'}

  end)
end

require'toggleterm'.setup {
  size = 20,
  open_mapping = [[<F12>]],
  shade_filetypes = {},
  shade_terminals = true,
  persist_size = true,
  direction = 'horizontal',
}

-- This came from https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/lua/lsp_config.lua
local mapper = function(mode, key, result, noremap)
  if noremap == nil then
    noremap = true
  end
  vim.fn.nvim_buf_set_keymap(0, mode, key, result, {noremap=noremap, silent=true})
end

-- LSP and Treesitter config

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
        smart_rename = "gsr",
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
      {complete_items = {'lsp'}},
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

-- Copied and modified from https://github.com/chengzeyi/.vim_runtime/blob/8a47981c81d31f88d1138211908e58fd58e4decc/lua/lsp_ext.lua

function preview_location(location, context, before_context)
  -- location may be LocationLink or Location (more useful for the former)
  context = context or 15
  before_context = before_context or 0
  local uri = location.targetUri or location.uri
  if uri == nil then
    return
  end
  local bufnr = vim.uri_to_bufnr(uri)
  if not vim.api.nvim_buf_is_loaded(bufnr) then
    vim.fn.bufload(bufnr)
  end
  local range = location.targetRange or location.range
  local contents =
  vim.api.nvim_buf_get_lines(bufnr, range.start.line - before_context, range['end'].line + 1 + context, false)
  local filetype = vim.api.nvim_buf_get_option(bufnr, 'filetype')
  return vim.lsp.util.open_floating_preview(contents, filetype)
end

function preview_location_callback(_, method, result)
  local context = 15
  if result == nil or vim.tbl_isempty(result) then
    return nil
  end
  if vim.tbl_islist(result) then
    preview_location(result[1], context, 5)
  else
    preview_location(result, context, 5)
  end
end

function peek_declaration()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, 'textDocument/declaration', params, preview_location_callback)
end

function peek_definition()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, 'textDocument/definition', params, preview_location_callback)
end

function peek_type_definition()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, 'textDocument/typeDefinition', params, preview_location_callback)
end

function peek_implementation()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, 'textDocument/implementation', params, preview_location_callback)
end

local on_attach = function(client)
  mapper('n', '<CR>', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({show_header=false})<CR>')
  mapper('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<CR>')
  mapper('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>')
  mapper('n', 'K', '<cmd>lua require"lspsaga.hover".render_hover_doc()<CR>')
  mapper('n', 'gD', '<cmd>lua vim.lsp.buf.implementation()<CR>')
  mapper('n', '1gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  mapper('n', 'gr', "<cmd>lua vim.lsp.buf.references()<CR>")
  mapper('n', 'tgr', "<cmd>lua require'telescope.builtin'.lsp_references()<CR>")
  mapper('n', 'g0', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
  mapper('i', '<c-l>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
  mapper('n', '<leader>f', '<cmd>lua vim.lsp.buf.code_action()<CR>')
  mapper('n', '<c-p>', '<cmd>lua vim.lsp.buf.formatting()<CR>')
  mapper("n", "gp", "<cmd>lua peek_definition()<CR>")
  -- mapper("n", "gp", "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>")
end


vim.lsp.handlers["textDocument/formatting"] = function(err, _, result, _, bufnr)
    if err ~= nil or result == nil then
        return
    end
    if not vim.api.nvim_buf_get_option(bufnr, "modified") then
        local view = vim.fn.winsaveview()
        vim.lsp.util.apply_text_edits(result, bufnr)
        -- Fix to reload Treesitter
        -- vim.api.nvim_command("edit")
        vim.fn.winrestview(view)
    end
end

lsp.pyright.setup{
    on_attach = on_attach;
}

if (vim.fn.executable('efm-langserver') == 1) then
  require 'efm/python'

  -- May not be installed, use pcall to handle errors
  pcall(require, 'efm/systemverilog')
  pcall(require, 'efm/flp')

  local language_cfg = require'efm/languages'

  lsp.efm.setup{
    on_attach = on_attach;
    init_options = {documentFormatting = true};
    root_dir = lsputil.root_pattern('.git', '.hg');
    settings = {
      rootMarkers = {".git/", ".hg/"},
      languages = language_cfg
    };
  }
end

-- Try importing local config
local ok, localconfig = pcall(require, 'localconfig')
if ok then
  localconfig.setup {on_attach=on_attach}
end
