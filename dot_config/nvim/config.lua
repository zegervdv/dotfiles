--
-- Neovim dotfiles
--
--
local execute = vim.api.nvim_command
local fn = vim.fn

-- Bootstrap package manager
local install_path = fn.stdpath 'data' .. '/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

-- Packer configuration is compiled and only needs to be loaded on changes
vim.cmd 'packadd packer.nvim'

require('packer').startup(function()
  use { 'wbthomason/packer.nvim', opt = true }

  -- General plugins
  use { 'tpope/vim-sensible' }
  use { 'tpope/vim-repeat' }
  use { 'tpope/vim-rsi' }
  use { 'sgur/vim-editorconfig' }
  use { 'ShikChen/osc52.vim' }
  use { 'einfachtoll/didyoumean' }

  use { 'tpope/vim-obsession' }
  use {
    'tpope/vim-eunuch',
    cmd = {
      'Delete',
      'Unlink',
      'Move',
      'Rename',
      'Mkdir',
      'Chmod',
      'Cfind',
      'Clocate',
      'Lfind',
      'Llocate',
      'SudoEdit',
      'SudoWrite',
      'Wall',
    },
  }

  use { 'psliwka/vim-smoothie' }

  use { 'nvim-lua/plenary.nvim' }

  -- Spelling/autocorrection
  use { 'tpope/vim-abolish' }

  -- Git/VCS
  use { 'vim-scripts/gitignore' }
  use { 'sjl/splice.vim', opt = true, cmd = { 'SpliceInit' } }
  use { 'tpope/vim-git' }

  -- Comments
  use { 'b3nj5m1n/kommentary' }

  -- Undoing
  use { 'sjl/gundo.vim', cmd = { 'GundoToggle' } }

  -- Parentheses etc
  use { 'tpope/vim-surround' }
  use { 'raimondi/delimitMate' }

  -- Moving around within lines
  use { 'wellle/targets.vim', event = 'InsertEnter *' }

  -- Searching
  use { 'mhinz/vim-grepper', cmd = { 'Grepper' } }

  -- Keymaps TODO: to be removed when #13823 is merged
  use {
    'tjdevries/astronauta.nvim',
    config = function()
      require 'astronauta.keymap'
    end,
  }

  -- Opening files
  use { 'wsdjeg/vim-fetch' }

  -- Indent lines
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      vim.g.indent_blankline_buftype_exclude = { 'terminal', 'help', 'nofile' }
      vim.g.indent_blankline_show_first_indent_level = false
    end,
  }

  -- Increment/decrement
  use {
    'zegervdv/nrpattern.nvim',
    requires = 'tpope/vim-repeat',
    config = function()
      local nrpattern = require 'nrpattern'
      local defaults = require 'nrpattern.default'

      defaults[{ 'input', 'output' }] = { priority = 12, filetypes = { 'verilog', 'systemverilog' } }
      defaults[{ "'1", "'0" }] = { priority = 9, filetypes = { 'verilog', 'systemverilog' } }

      nrpattern.setup(defaults)
    end,
  }

  -- Tmux
  use {
    'numtostr/navigator.nvim',
    config = function()
      require('Navigator').setup { auto_save = 'current', disable_on_zoom = true }

      local nnoremap = vim.keymap.nnoremap
      nnoremap { '<c-h>', require('Navigator').left, silent = true }
      nnoremap { '<c-j>', require('Navigator').down, silent = true }
      nnoremap { '<c-k>', require('Navigator').up, silent = true }
      nnoremap { '<c-l>', require('Navigator').right, silent = true }
    end,
    requires = 'tjdevries/astronauta.nvim',
    after = 'astronauta.nvim',
  }

  -- Completion/snippets/LSP
  use { 'neovim/nvim-lspconfig' }
  use {
    'hrsh7th/nvim-compe',
    config = function()
      require('compe').setup {
        enabled = true,
        autocomplete = true,
        debug = false,
        min_length = 1,
        preselect = 'enable',
        throttle_time = 80,
        source_timeout = 1000,
        incomplete_delay = 400,
        max_abbr_width = 100,
        max_kind_width = 100,
        max_menu_width = 100,
        documentation = true,

        source = {
          path = true,
          buffer = true,
          nvim_lsp = true,
          nvim_lua = true,
          spell = false,
          vsnip = true,
        },
      }

      vim.cmd [[ inoremap <silent><expr> <C-y> compe#complete() ]]
      vim.cmd [[ inoremap <silent><expr> <CR>      compe#confirm({ 'keys': "\<Plug>delimitMateCR", 'mode': '' }) ]]
      vim.cmd [[ inoremap <silent><expr> <C-e>     compe#close('<C-e>') ]]
    end,
  }
  use {
    {
      'nvim-treesitter/nvim-treesitter',
      config = function()
        require 'nvim-treesitter.highlight'

        require('nvim-treesitter.configs').setup {
          highlight = { enable = false },
          incremental_selection = {
            enable = true,
            keymaps = {
              init_selection = 'gnn',
              node_incremental = 'grn',
              scope_incremental = 'grc',
              node_decremental = 'grm',
            },
          },
          refactor = {
            highlight_definitions = { enable = true },
            smart_rename = { enable = true, keymaps = { smart_rename = 'gsr' } },
            navigation = {
              enable = true,
              keymaps = { goto_definition = 'gnd', list_definitions = 'gnD' },
            },
          },
          textobjects = {
            move = {
              enable = true,
              goto_next_start = { [']]'] = '@block.outer' },
              goto_previous_start = { ['[['] = '@block.outer' },
              goto_next_end = { [']['] = '@block.outer' },
              goto_previous_end = { ['[]'] = '@block.outer' },
            },
          },
          playground = { enable = true, disable = {}, updatetime = 25, persist_queries = false },
        }
      end,
    },
    'nvim-treesitter/nvim-treesitter-refactor',
    'nvim-treesitter/nvim-treesitter-textobjects',
    { 'nvim-treesitter/playground', opt = true },
  }
  use { 'hrsh7th/vim-vsnip', requires = 'hrsh7th/vim-vsnip-integ' }
  use {
    'glepnir/lspsaga.nvim',
    config = function()
      require('lspsaga').init_lsp_saga {}
    end,
  }
  use {
    'rmagatti/goto-preview',
    config = function()
      require('goto-preview').setup {}
    end,
  }
  use {
    'jose-elias-alvarez/null-ls.nvim',
    requires = 'nvim-lua/plenary.nvim',
  }

  -- Vanity
  use {
    'yamatsum/nvim-web-nonicons',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require 'nvim-nonicons'
    end,
  }

  use {
    'glepnir/galaxyline.nvim',
    branch = 'main',
    -- your statusline
    config = function()
      local gl = require 'galaxyline'
      local colors = require('galaxyline.theme').default
      local condition = require 'galaxyline.condition'
      local gls = gl.section

      colors.bg = '#2C323C'

      gls.left[1] = {
        RainbowRed = {
          provider = function()
            return '▊ '
          end,
          highlight = { colors.blue, colors.bg },
        },
      }

      gls.left[2] = {
        FileIcon = {
          provider = 'FileIcon',
          condition = condition.buffer_not_empty,
          highlight = { require('galaxyline.provider_fileinfo').get_file_icon_color, colors.bg },
        },
      }

      gls.left[3] = {
        FileName = {
          provider = 'FileName',
          condition = condition.buffer_not_empty,
          highlight = { colors.magenta, colors.bg, 'bold' },
        },
      }

      gls.right[1] = {
        ShowLspClient = {
          provider = 'GetLspClient',
          condition = function()
            local tbl = { ['dashboard'] = true, [''] = true }
            if tbl[vim.bo.filetype] then
              return false
            end
            return true
          end,
          icon = require('nvim-nonicons').get 'server' .. ' LSP:',
          highlight = { colors.green, colors.bg, 'bold' },
        },
      }

      gls.right[2] = {
        LineInfo = {
          provider = 'LineColumn',
          separator = ' ',
          separator_highlight = { 'NONE', colors.bg },
          highlight = { colors.fg, colors.bg },
        },
      }

      gls.right[3] = {
        PerCent = {
          provider = 'LinePercent',
          separator = ' ',
          separator_highlight = { 'NONE', colors.bg },
          highlight = { colors.fg, colors.bg, 'bold' },
        },
      }
      gls.right[8] = {
        RainbowBlue = {
          provider = function()
            return ' ▊'
          end,
          highlight = { colors.blue, colors.bg },
        },
      }

      gls.short_line_left[1] = {
        BufferType = {
          provider = 'FileTypeName',
          separator = ' ',
          separator_highlight = { 'NONE', colors.bg },
          highlight = { colors.blue, colors.bg, 'bold' },
        },
      }

      gls.short_line_left[2] = {
        SFileName = {
          provider = 'SFileName',
          condition = condition.buffer_not_empty,
          highlight = { colors.fg, colors.bg, 'bold' },
        },
      }

      gls.short_line_right[1] = {
        BufferIcon = { provider = 'BufferIcon', highlight = { colors.fg, colors.bg } },
      }
    end,
  }

  -- File navigation
  use { 'justinmk/vim-dirvish' }

  -- Colorscheme
  use {
    'zegervdv/one-lush',
    requires = 'rktjmp/lush.nvim',
    config = function()
      require 'lush_theme.one-lush'
      vim.cmd [[ colorscheme one-lush ]]
    end,
  }

  -- Terminal
  use {
    'akinsho/nvim-toggleterm.lua',
    config = function()
      require('toggleterm').setup {
        size = 15,
        open_mapping = [[<F12>]],
        shade_filetypes = { 'none' },
        shade_terminals = true,
        persist_size = true,
        direction = 'horizontal',
      }
    end,
  }

  -- Filetypes
  use { 'Glench/Vim-Jinja2-Syntax' }
end)

-- LSP config
local lsp = require 'lspconfig'
local lsputil = require 'lspconfig.util'
local null_ls = require 'null-ls'

local on_attach = function(client)
  local nnoremap = vim.keymap.nnoremap
  local inoremap = vim.keymap.inoremap
  -- nnoremap { '', require'lspsaga.diagnostic'.show_line_diagnostics, silent = true }
  nnoremap { 'gd', vim.lsp.buf.declaration, silent = true }
  nnoremap { '<c-]>', vim.lsp.buf.definition, silent = true }
  nnoremap { 'K', require('lspsaga.hover').render_hover_doc, silent = true }
  nnoremap { 'gD', vim.lsp.buf.implementation, silent = true }
  nnoremap { '1gD', vim.lsp.buf.type_definition, silent = true }
  nnoremap { 'gr', vim.lsp.buf.references, silent = true }
  nnoremap { 'g0', vim.lsp.buf.document_symbol, silent = true }
  nnoremap {
    '<c-p>',
    function()
      vim.lsp.buf.formatting_sync({}, 5000)
    end,
    silent = true,
  }
  -- nnoremap { 'gp', require'lspsaga.provider'.preview_definition, silent = true }
  nnoremap { 'gp', require('goto-preview').goto_preview_definition, silent = true }
  nnoremap { 'gP', require('goto-preview').close_all_win, silent = true }

  inoremap { '<c-l>', vim.lsp.buf.signature_help, silent = true }

  vim.fn.sign_define(
    'LspDiagnosticsSignError',
    { texthl = 'LspDiagnosticsSignError', linehl = '', numhl = '', text = '▎' }
  )
  vim.fn.sign_define('LspDiagnosticsSignWarning', {
    texthl = 'LspDiagnosticsSignWarning',
    linehl = '',
    numhl = '',
    text = '▎',
  })
  vim.fn.sign_define('LspDiagnosticsSignInformation', {
    texthl = 'LspDiagnosticsSignInformation',
    linehl = '',
    numhl = '',
    text = '▎',
  })
  vim.fn.sign_define(
    'LspDiagnosticsSignHint',
    { texthl = 'LspDiagnosticsSignHint', linehl = '', numhl = '', text = '▎' }
  )
end

vim.lsp.handlers['textDocument/formatting'] = function(err, _, result, _, bufnr)
  if err ~= nil or result == nil then
    return
  end
  if not vim.api.nvim_buf_get_option(bufnr, 'modified') then
    local view = vim.fn.winsaveview()
    vim.lsp.util.apply_text_edits(result, bufnr)
    -- Fix to reload Treesitter
    -- vim.api.nvim_command("edit")
    vim.fn.winrestview(view)
  end
end

vim.lsp.handlers['textDocument/publishDiagnostics'] = function(...)
  vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { underline = true, update_in_insert = false })(...)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  },
}

lsp.pyright.setup { on_attach = on_attach, capabilities = capabilities }

null_ls.setup {
  on_attach = on_attach,
  sources = {
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.stylua,
  },
}

-- Try importing local config
local ok, localconfig = pcall(require, 'localconfig')
if ok then
  localconfig.setup { on_attach = on_attach, capabilities = capabilities }
end
