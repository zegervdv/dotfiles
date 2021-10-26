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

vim.defer_fn(function()
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
    use {
      'sjl/splice.vim',
      opt = true,
      cmd = { 'SpliceInit' },
      config = function()
        vim.g.splice_initial_diff_grid = 1
        vim.g.splice_initial_diff_compare = 1
        vim.g.splice_initial_diff_path = 0
        vim.g.splice_initial_scrollbind_grid = 1
        vim.g.splice_initial_scrollbind_compare = 1
        vim.g.splice_initial_scrollbind_path = 1
        vim.g.splice_wrap = 'nowrap'
      end,
    }
    use { 'tpope/vim-git', ft = { 'gitcommit', 'gitrebase' } }

    -- Comments
    use {
      'b3nj5m1n/kommentary',
      config = function()
        require('kommentary.config').configure_language('default', { prefer_single_line_comments = true })
      end,
      keys = {
        { 'n', 'gcc' },
        { 'v', 'gc' },
      },
    }

    -- Undoing
    use { 'sjl/gundo.vim', cmd = { 'GundoToggle' } }

    -- Parentheses etc
    use { 'tpope/vim-surround' }
    use {
      'windwp/nvim-autopairs',
      config = function()
        local npairs = require 'nvim-autopairs'
        local Rule = require 'nvim-autopairs.rule'

        require('nvim-autopairs.completion.cmp').setup {
          map_cr = true, --  map <CR> on insert mode
          map_complete = true, -- it will auto insert `(` after select function or method item
          auto_select = false, -- automatically select the first item
        }

        npairs.setup {
          ignored_next_char = string.gsub([[ [%w%%%'%[%.] ]], '%s+', ''),
        }

        npairs.add_rules {
          Rule(' ', ' '):with_pair(function(opts)
            local pair = opts.line:sub(opts.col - 1, opts.col)
            return vim.tbl_contains({ '()', '[]', '{}' }, pair)
          end),
          Rule('( ', ' )')
            :with_pair(function()
              return false
            end)
            :with_move(function(opts)
              return opts.prev_char:match '.%)' ~= nil
            end)
            :use_key ')',
          Rule('{ ', ' }')
            :with_pair(function()
              return false
            end)
            :with_move(function(opts)
              return opts.prev_char:match '.%}' ~= nil
            end)
            :use_key '}',
          Rule('[ ', ' ]')
            :with_pair(function()
              return false
            end)
            :with_move(function(opts)
              return opts.prev_char:match '.%]' ~= nil
            end)
            :use_key ']',
        }

        npairs.get_rule('`'):with_pair(function()
          return vim.bo.filetype ~= 'systemverilog'
        end)

        npairs.get_rule("'")[1]:with_pair(function()
          return vim.bo.filetype ~= 'systemverilog'
        end)
      end,
      after = { 'nvim-cmp' },
    }

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

    -- session management
    use {
      'folke/persistence.nvim',
      event = 'BufReadPre',
      module = 'persistence',
      config = function()
        require('persistence').setup()
      end,
    }

    -- Indent lines
    use {
      'lukas-reineke/indent-blankline.nvim',
      config = function()
        vim.g.indent_blankline_buftype_exclude = { 'terminal', 'help', 'nofile' }
        vim.g.indent_blankline_show_first_indent_level = false
        vim.g.indent_blankline_char = '│'
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
      'hrsh7th/nvim-cmp',
      requires = { 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-vsnip', 'hrsh7th/cmp-path' },
      config = function()
        local cmp = require 'cmp'
        cmp.setup {
          snippet = {
            expand = function(args)
              vim.fn['vsnip#anonymous'](args.body)
            end,
          },
          mapping = {
            ['<C-p>'] = cmp.mapping.select_prev_item(),
            ['<C-n>'] = cmp.mapping.select_next_item(),
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-y>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.close(),
            ['<CR>'] = cmp.mapping.confirm {
              behavior = cmp.ConfirmBehavior.Replace,
            },
          },
          sources = {
            { name = 'nvim_lsp' },
            { name = 'buffer', keyword_length = 5 },
            { name = 'vsnip' },
            { name = 'path' },
          },
          experimental = {
            native_menu = false,
            ghost_text = true,
          },
        }
      end,
    }
    use { 'ray-x/lsp_signature.nvim' }
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
      'rmagatti/goto-preview',
      config = function()
        require('goto-preview').setup {}
      end,
    }
    use {
      'jose-elias-alvarez/null-ls.nvim',
      requires = 'nvim-lua/plenary.nvim',
    }
    use { 'folke/lua-dev.nvim' }

    use { 'vimjas/vim-python-pep8-indent', ft = { 'python' } }

    -- Vanity
    use {
      'yamatsum/nvim-web-nonicons',
      requires = 'kyazdani42/nvim-web-devicons',
      config = function()
        require 'nvim-nonicons'
      end,
    }

    use {
      'NTBBloodbath/galaxyline.nvim',
      branch = 'main',
      -- your statusline
      config = function()
        local gl = require 'galaxyline'
        local colors = require('galaxyline.themes.colors').default
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
          FileName = {
            provider = function()
              return require('galaxyline.providers.fileinfo').get_current_file_name '⊙'
            end,
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
    use { 'justinmk/vim-dirvish', opt = true }

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
      keys = { [[<F12>]] },
    }

    -- Filetypes
    use { 'lepture/vim-jinja' }
  end)
end, 0)

-- Configuration
local opt = vim.opt

opt.backspace = { 'indent', 'eol', 'start' } -- Backspace everything

opt.autoread = true -- Read changed files
opt.hidden = true -- Allow to move away from modified files
opt.autowriteall = true -- Write changes when losing focus

-- Visuals
opt.number = true
opt.relativenumber = true
opt.scrolloff = 4
opt.showcmd = true -- Show incomplete commands while typing

opt.termguicolors = true
opt.background = 'dark'

opt.showmatch = true -- Highligh matching braces

opt.wrap = true -- Wrap lines
opt.wrapmargin = 2 -- Stay 2 chars from side
opt.textwidth = 79
opt.colorcolumn = '81' -- Show indication of 81 chars
opt.linebreak = true -- Smarter wrapping
opt.breakindent = true -- Indent wrapped lines to same level

opt.fixendofline = true -- Add EOL when missing

opt.expandtab = true -- Add spaces when pressing tab
opt.tabstop = 2 -- Tab is 2 spaces
opt.shiftwidth = 2 -- Shift per 2 spaces
opt.shiftround = true -- Round shifts to allign (1 space + tab = 2 spaces)

-- Searching and substitute
opt.magic = true -- Enable regexes
opt.hlsearch = true -- Highlight all matches
opt.incsearch = true -- Show matches while typing
opt.ignorecase = true
opt.smartcase = true -- When search pattern contains cases, be case sensitive
opt.gdefault = true -- Use global flag for substitute: replace all matches on line
opt.inccommand = 'nosplit' -- Show live replacements directly in text

opt.autoindent = true
opt.cindent = true -- C-syntax based indenting

opt.updatetime = 300 -- Faster triggering of CursorHold events

opt.errorbells = false -- Don't you beep to me
opt.title = true -- Set the title for WezTerm to detect

opt.history = 1000 -- Remember last commands

opt.wildmenu = true -- Command completion
opt.wildmode = 'longest:full,full'
opt.shortmess:append 'c' -- Hide ins-completion messages

opt.ttyfast = true -- fast terminal
opt.lazyredraw = true
opt.ttimeoutlen = -1 -- Minimum timeout

opt.diffopt:append 'iwhite' -- Ignore whitespace in diffs
opt.diffopt:append 'internal' -- Internal diff engine
opt.diffopt:append 'algorithm:patience' -- Use patience algorithm

opt.tags = { '.git/tags', 'tags' }

opt.path:append '**' -- Recursively search current directory

opt.formatoptions = {
  c = true, -- Wrap comments
  r = true, -- Continue comments
  o = true, -- Insert comment with o/O
  q = true, -- Format comments with gq
  n = true, -- Indent numbered lists
  [2] = true, -- Indent from 2nd line of paragraph
  [1] = true, -- Don't break before one letter words
}

opt.signcolumn = 'yes' -- Always show signcolumn

opt.cursorline = true

-- Show certain characters
opt.list = true
opt.listchars = { trail = '·', extends = '>', precedes = '<', nbsp = '+' }

opt.sessionoptions:remove 'options' -- Remove options from saved sessions (reload from config)

opt.completeopt = { 'menu', 'menuone', 'noselect' }

opt.splitright = true -- Open new splits to right
opt.virtualedit = 'block' -- Enable block editting

opt.conceallevel = 0 -- Disable conceal

opt.pastetoggle = '<F2>' -- Enable paste mode

opt.undofile = true -- Persistently remember undos
opt.undolevels = 1000
if os.getenv 'HOME' ~= nil then
  opt.undodir = os.getenv 'HOME' .. '/.config/nvim/tmp/undo//'
end
opt.swapfile = false -- Disable swap files
opt.backup = true -- Keep backups
if os.getenv 'HOME' ~= nil then
  opt.backupdir = os.getenv 'HOME' .. '/.config/nvim/tmp/backup//'
end

-- Files to ignore from completion
opt.wildignore:append {
  '*/tmp/*',
  '*.so',
  '*.swp',
  '*.zip',
  '*.o',
  '*.bin',
  '*.elf',
  '*.hex',
  '*.eps',
  '.git/*',
  '*.dup',
  '.hg/**',
  '*.orig',
  '*.*~',
}

opt.mouse = {
  n = true, -- Normal mode
  i = true, -- Insert mode
  c = true, -- Commandline mode
}

opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'
opt.foldnestmax = 3
opt.foldminlines = 1
opt.foldtext =
  [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
opt.foldenable = false

-- LSP config
local lsp = require 'lspconfig'
local null_ls = require 'null-ls'

-- Use builtin tagfunc to query LSP
-- source: https://github.com/mfussenegger/dotfiles/blob/076d77eafabe90327d1355dfbfb807085a795367/vim/.config/nvim/lua/me/lsp/ext.lua#L54
local function make_tag_item(name, range, uri)
  local start = range.start
  return {
    name = name,
    filename = vim.uri_to_fname(uri),
    cmd = string.format('call cursor(%d, %d)', start.line + 1, start.character + 1),
  }
end

local function tag_definition_request(pattern)
  local params = vim.lsp.util.make_position_params()
  local results, err = vim.lsp.buf_request_sync(0, 'textDocument/definition', params, 10000)
  if err then
    print(vim.inspect(err))
  end

  local tags = {}

  for _, lsp_result in pairs(results) do
    local result = lsp_result.result or {}
    if result.range then
      table.insert(tags, make_tag_item(pattern, result.range, result.uri))
    else
      for _, item in pairs(result) do
        if item.range then
          table.insert(tags, make_tag_item(pattern, item.range, item.uri))
        else
          table.insert(tags, make_tag_item(pattern, item.targetSelectionRange, item.targetUri))
        end
      end
    end
  end
  return tags
end

local function tag_symbol_request(pattern)
  local results, err = vim.lsp.buf_request_sync(0, 'workspace/symbol', { query = pattern }, 10000)
  if err then
    print(vim.inspect(err))
  end

  local tags = {}

  for _, symbols in pairs(results) do
    for _, symbol in pairs(symbols.result or {}) do
      local loc = symbol.location
      local item = make_tag_item(symbol.name, loc.range, loc.uri)
      item.kind = (vim.lsp.protocol.SymbolKind[symbol.kind] or 'Unknown')[1]
      table.insert(tags, item)
    end
  end
  return tags
end

_G.tagfunc = function(pattern, flags)
  if flags == 'c' then
    return tag_definition_request(pattern)
  elseif flags == '' or flags == 'r' then
    return tag_symbol_request(pattern)
  else
    return vim.NIL
  end
end

local on_attach = function(client)
  local nnoremap = vim.keymap.nnoremap
  local inoremap = vim.keymap.inoremap

  vim.bo.tagfunc = 'v:lua.tagfunc'

  nnoremap { 'gd', vim.lsp.buf.declaration, silent = true, buffer = 0 }
  nnoremap { 'K', vim.lsp.buf.hover, silent = true, buffer = 0 }
  nnoremap { 'gD', vim.lsp.buf.implementation, silent = true, buffer = 0 }
  nnoremap { '1gD', vim.lsp.buf.type_definition, silent = true, buffer = 0 }
  nnoremap { 'gr', vim.lsp.buf.references, silent = true, buffer = 0 }
  nnoremap { 'g0', vim.lsp.buf.document_symbol, silent = true, buffer = 0 }
  nnoremap {
    '<c-p>',
    function()
      vim.lsp.buf.formatting_sync({}, 5000)
    end,
    silent = true,
    buffer = 0,
  }
  nnoremap { 'gp', require('goto-preview').goto_preview_definition, silent = true, buffer = 0 }
  nnoremap { 'gP', require('goto-preview').close_all_win, silent = true, buffer = 0 }

  inoremap { '<c-l>', vim.lsp.buf.signature_help, silent = true, buffer = 0 }

  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' })
  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' })
  -- require "lsp_signature".on_attach()
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
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

lsp.pyright.setup { on_attach = on_attach, capabilities = capabilities }

null_ls.config {
  sources = {
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.stylua,
  },
}
lsp['null-ls'].setup {
  on_attach = on_attach,
  root_dir = require('lspconfig.util').root_pattern('.hg', '.git'),
}

local luadev = require('lua-dev').setup {
  lspconfig = {
    cmd = { 'lua-language-server' },
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'use' },
        },
      },
    },
  },
}

lsp.sumneko_lua.setup(luadev)

-- Populate quickfix with all locations of rename
function LspRename()
  local params = vim.lsp.util.make_position_params()
  params.newName = vim.fn.input('Rename: ', vim.fn.expand '<cword>')
  vim.lsp.buf_request(0, 'textDocument/rename', params, function(err, result, ctx, ...)
    vim.lsp.handlers['textDocument/rename'](err, result, ctx, ...)
    local changed = {}
    for uri, changes in pairs(result.changes) do
      local bufnr = vim.uri_to_bufnr(uri)
      for _, edits in ipairs(changes) do
        table.insert(changed, {
          bufnr = bufnr,
          lnum = edits.range.start.line + 1,
          col = edits.range.start.character + 1,
          text = vim.api.nvim_buf_get_lines(bufnr, edits.range.start.line, edits.range.start.line + 1, false)[1],
        })
      end
    end
    vim.fn.setqflist(changed, 'r')
  end)
end

vim.cmd [[command! LspRename lua LspRename()]]

local au = require 'au'

au.TextYankPost = function()
  vim.highlight.on_yank { timeout = 120 }
end

vim.diagnostic.config {
  underline = true,
  update_in_insert = false,
  virtual_text = { severity = { min = vim.diagnostic.severity.WARN }, source = 'always' },
  severity_sort = true,
}

vim.fn.sign_define('DiagnosticSignError', { texthl = 'DiagnosticSignError', linehl = '', numhl = '', text = '▎' })
vim.fn.sign_define('DiagnosticSignWarn', {
  texthl = 'DiagnosticSignWarn',
  linehl = '',
  numhl = '',
  text = '▎',
})
vim.fn.sign_define('DiagnosticSignInfo', {
  texthl = 'DiagnosticSignInfo',
  linehl = '',
  numhl = '',
  text = '▎',
})
vim.fn.sign_define('DiagnosticSignHint', { texthl = 'DiagnosticSignHint', linehl = '', numhl = '', text = '▎' })

-- Try importing local config
local ok, localconfig = pcall(require, 'localconfig')
if ok then
  localconfig.setup { on_attach = on_attach, capabilities = capabilities }
end
