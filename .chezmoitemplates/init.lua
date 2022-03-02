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

  -- Smooth scrolling
  use {
    'karb94/neoscroll.nvim',
    config = function()
      require('neoscroll').setup {}
    end,
  }

  -- Faster lua package loading (until 15436 is merged)
  use {
    'lewis6991/impatient.nvim',
    module = { 'impatient' },
    setup = function()
      require 'impatient'
    end,
  }

  -- Library with lua functions
  use { 'nvim-lua/plenary.nvim' }

  -- Spelling/autocorrection
  use { 'tpope/vim-abolish' }

  -- Git/VCS
  use { 'vim-scripts/gitignore' }
  use {
    'sjl/splice.vim',
    disable = true,
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
  use {
    'zegervdv/merge.nvim',
    opt = true,
    cmd = { 'MergeInit' },
    config = function()
      require('merge').setup {
        wrap = true,
        pre_hook = function()
          -- disable dirvish
          vim.api.nvim_del_keymap('n', '-')
        end,
      }
    end,
  }
  use { 'tpope/vim-git', ft = { 'gitcommit', 'gitrebase' } }

  -- Comments
  use {
    'numToStr/Comment.nvim',
    config = function()
      local ft = require 'Comment.ft'
      ft.systemverilog = { '//%s', '/*%s*/' }
      ft.verilog = { '//%s', '/*%s*/' }

      require('Comment').setup {
        padding = true,
        sticky = true,
        ignore = '^(%s*)$',
        mappings = {
          basic = true,
          extra = true,
        },
      }
    end,
    keys = {
      { 'n', 'gc' },
      { 'n', 'gb' },
      { 'v', 'gc' },
      { 'v', 'gb' },
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

      local cmp = require 'nvim-autopairs.completion.cmp'

      require('cmp').event:on('confirm_done', cmp.on_confirm_done())

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
  use {
    'mhinz/vim-grepper',
    cmd = { 'Grepper', 'Ag' },
    keys = { { 'n', 'gs' }, { 'x', 'gs' } },
    config = function()
      vim.g.grepper = {
        tools = { 'ag', 'hg' },
        highlight = 1,
        ag = {
          grepprg = 'rg --vimgrep',
        },
      }

      vim.keymap.set({ 'x', 'n' }, 'gs', '<plug>(GrepperOperator)')
      vim.api.nvim_add_user_command(
        'Ag',
        'Grepper -noprompt -tool ag -grepprg rg --vimgrep <args>',
        { complete = 'file', nargs = '*' }
      )
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

      local nmap = function(lhs, rhs, opts)
        return vim.keymap.set('n', lhs, rhs, opts)
      end
      nmap('<c-h>', require('Navigator').left, { silent = true })
      nmap('<c-j>', require('Navigator').down, { silent = true })
      nmap('<c-k>', require('Navigator').up, { silent = true })
      nmap('<c-l>', require('Navigator').right, { silent = true })
    end,
  }

  -- Completion/snippets/LSP
  use { 'neovim/nvim-lspconfig' }
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp-signature-help',
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
      end

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
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
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, {
            'i',
            's',
          }),

          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, {
            'i',
            's',
          }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'buffer', keyword_length = 5 },
          { name = 'luasnip' },
          { name = 'path' },
        },
        experimental = {
          native_menu = false,
          ghost_text = true,
        },
      }

      cmp.setup.cmdline(':', {
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          { name = 'cmdline', keyword_length = 4 },
        }),
      })
    end,
    after = 'luasnip',
  }
  use {
    {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = function()
        require 'nvim-treesitter.highlight'

        require('nvim-treesitter.configs').setup {
          ensure_installed = {
            'python',
            'lua',
            'verilog',
            'json',
            'yaml',
            'bash',
            'dockerfile',
            'c',
            'cpp',
            'regex',
          },
          indent = {
            enable = false,
          },
          highlight = {
            enable = true,
            disable = { 'systemverilog', 'verilog' },
          },
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
            select = {
              enable = true,
              lookahead = true,
              keymaps = {
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
              },
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
  use { 'L3MON4D3/luasnip' }
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
  use {
    'lukas-reineke/lsp-format.nvim',
    config = function()
      require('lsp-format').setup {}
    end,
  }
  use { 'folke/lua-dev.nvim' }

  use { 'vimjas/vim-python-pep8-indent', ft = { 'python' } }

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
  use {
    'elihunter173/dirbuf.nvim',
    opt = true,
    config = function()
      require('dirbuf').setup {
        hash_padding = 2,
        show_hidden = true,
      }
    end,
  }

  -- Colorscheme
  use {
    'navarasu/onedark.nvim',
    config = function()
      require('onedark').setup {
        style = 'dark',
        code_style = {
          comments = 'italic',
        },
        ending_tildes = true,
        diagnostics = {
          darker = false,
          undercurl = false,
          background = false,
        },
      }
      require('onedark').load()
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

vim.cmd [[ packadd dirbuf.nvim ]]

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
opt.title = false -- Don't set the shell title

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

opt.startofline = false -- When moving try to keep cursor in column

-- Show certain characters
opt.list = true
opt.listchars = { trail = '·', extends = '>', precedes = '<', nbsp = '+', tab = '▸ ' }

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

-- Clean up terminal codes from strings
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- General keymaps
local map = vim.keymap.set

-- Set leader to space
map({ 'n', 'v', 'i', 'x' }, '<space>', '<leader>', { remap = true })

-- Move while in insert mode
map('i', '<C-f>', '<right>')

-- Keep search matches centered
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

-- Very magic search patterns
map({ 'n', 'v' }, '/', '/\\v')

-- Move through long lines as breaks
map('n', 'j', '(v:count ? "j" : "gj")', { expr = true })
map('n', 'k', '(v:count ? "k" : "gk")', { expr = true })

-- Command line search for commands
map('c', '<c-n>', '<down>')
map('c', '<c-p>', '<up>')

-- Clear highlighs
map('n', '<leader>l', '<cmd>noh<CR>', { silent = true })

-- Reselect last selection
map('n', 'gV', '`[v`]')

-- Use backspace as normal in visual mode
map('v', '<BS>', 'x', { remap = true })

-- Keep selection when indenting
local keep_visual_selection = function(cmd)
  return function()
    vim.opt.smartindent = false
    if vim.fn.mode() == 'V' then
      return cmd .. t ':set smartindent<CR>gv'
    else
      return cmd .. t ':set smartindent<CR>'
    end
  end
end
map('v', '>', keep_visual_selection '>', { expr = true, silent = true, desc = 'Indent right while keeping selection' })
map('v', '<', keep_visual_selection '<', { expr = true, silent = true, desc = 'Indent left while keeping selection' })

-- Swap backticks and quotes
map('n', '`', "'")
map('n', "'", '`')

local au = require 'au'

-- Highlight yanked text
au.TextYankPost = function()
  vim.highlight.on_yank { timeout = 120 }
end

-- Automatic cursorline
au.group('cline', {
  {
    'WinEnter',
    '*',
    function()
      vim.opt_local.cursorline = true
    end,
  },
  {
    'WinLeave',
    '*',
    function()
      vim.opt_local.cursorline = false
    end,
  },
})

-- Save files on focus lost
au.FocusLost = function()
  if not vim.o.readonly and vim.api.nvim_buf_get_name(0) ~= '' then
    vim.cmd [[ wa ]]
  end
end

-- Equalize splits after resizing
au.VimResized = [[ exe "normal! \<c-w>=" ]]

-- Reload diffs after editing
au.BufWritePost = function()
  if vim.o.diff then
    vim.cmd [[ diffupdate ]]
  end
end

-- Snippets
local ls = require 'luasnip'
-- Expand snippet or jump to next placeholder
vim.keymap.set({ 'i', 's' }, '<c-k>', function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, {
  silent = true,
})

-- Go back to previous placeholder
vim.keymap.set({ 'i', 's' }, '<c-j>', function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, {
  silent = true,
})

-- Toggle options in snippets
vim.keymap.set('i', '<c-l>', function()
  if ls.choice_active() then
    ls.change_choice()
  end
end)

-- LSP config
local lsp = require 'lspconfig'
local null_ls = require 'null-ls'

local on_attach = function(client)
  require('lsp-format').on_attach(client)
  local nmap = function(lhs, rhs, opts)
    return vim.keymap.set('n', lhs, rhs, opts)
  end

  vim.bo.tagfunc = 'v:lua.vim.lsp.tagfunc'
  nmap('gp', require('goto-preview').goto_preview_definition, { silent = true, buffer = 0 })
  nmap('gP', require('goto-preview').close_all_win, { silent = true, buffer = 0 })

  nmap('gd', vim.lsp.buf.declaration, { silent = true, buffer = 0 })
  nmap('K', vim.lsp.buf.hover, { silent = true, buffer = 0 })
  nmap('gD', vim.lsp.buf.implementation, { silent = true, buffer = 0 })
  nmap('1gD', vim.lsp.buf.type_definition, { silent = true, buffer = 0 })
  nmap('gr', vim.lsp.buf.references, { silent = true, buffer = 0 })
  nmap('g0', vim.lsp.buf.document_symbol, { silent = true, buffer = 0 })

  nmap('<c-p>', function()
    require('lsp-format').format()
  end, {
    silent = true,
    buffer = 0,
  })

  vim.bo.formatexpr = 'v:lua.vim.lsp.formatexpr()'

  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' })
  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' })
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

local root_dir = require('lspconfig.util').root_pattern('.git', '.hg')

lsp.pyright.setup { on_attach = on_attach, capabilities = capabilities, root_dir = root_dir }

lsp.esbonio.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = root_dir,
  -- Assume esbonio is installed with --user
  cmd = { os.getenv 'HOME' .. '/.local/bin/esbonio' },
}

null_ls.setup {
  sources = {
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.formatting.prettier,
  },
  on_attach = on_attach,
  root_dir = require('null-ls.utils').root_pattern('.hg', '.git', 'stylua.toml'),
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

vim.api.nvim_add_user_command('LspRename', LspRename, {})

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
