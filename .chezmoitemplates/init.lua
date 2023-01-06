--
-- Neovim dotfiles
--
--
local execute = vim.api.nvim_command
local fn = vim.fn

local home = os.getenv 'HOME'
if home == nil then home = os.getenv 'USERPROFILE' end

-- Bootstrap package manager
local install_path = fn.stdpath 'data' .. '/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

-- Packer configuration is compiled and only needs to be loaded on changes
vim.cmd.packadd 'packer.nvim'

local local_plugin = function(name)
  local path = home .. '/Projects/' .. name
  if vim.fn.isdirectory(path) > 0 then
    return path
  else
    return 'zegervdv/' .. name
  end
end

require('packer').startup {
  function(use)
    use { 'wbthomason/packer.nvim', opt = true }

    -- General plugins
    use { 'tpope/vim-sensible' }
    use { 'tpope/vim-repeat' }
    use { 'tpope/vim-rsi' }
    use { 'sgur/vim-editorconfig' }
    use {
      'ojroques/nvim-osc52',
      config = function()
        require('osc52').setup { trim = true }
        local copy = function(lines, _) require('osc52').copy(table.concat(lines, '\n')) end
        local paste = function() return { vim.fn.split(vim.fn.getreg '', '\n'), vim.fn.getregtype '' } end
        vim.g.clipboard = {
          name = 'osc52',
          copy = { ['+'] = copy, ['*'] = copy },
          paste = { ['+'] = paste, ['*'] = paste },
        }
      end,
    }

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
      config = function() require('neoscroll').setup {} end,
    }

    -- Faster lua package loading (until 15436 is merged)
    use {
      'lewis6991/impatient.nvim',
      module = { 'impatient' },
      setup = function() require 'impatient' end,
    }

    -- Library with lua functions
    use { 'nvim-lua/plenary.nvim' }

    -- Spelling/autocorrection
    use { 'tpope/vim-abolish' }

    -- Git/VCS
    use { 'vim-scripts/gitignore' }
    use {
      'zegervdv/settle.nvim',
      opt = true,
      cmd = { 'SettleInit' },
      config = function()
        require('settle').setup {
          wrap = true,
          symbol = '▊',
          pre_hook = function()
            -- disable dirvish
            vim.api.nvim_del_keymap('n', '-')
          end,
        }
      end,
    }
    use { 'tpope/vim-git', ft = { 'gitcommit', 'gitrebase' } }
    use {
      local_plugin 'diffview.nvim',
      config = function()
        require('diffview').setup {
          use_icons = false,
          icons = {
            folder_closed = '+',
            folder_open = '-',
          },
          signs = {
            fold_closed = '+',
            fold_open = '-',
            done = '✓',
          },
          hg_cmd = { 'chg' },
          view = {
            merge_tool = {
              layout = 'diff4_mixed',
            },
          },
        }
        local wk = require 'which-key'
        wk.register { ['<leader>d'] = { name = 'Diffview' } }
        vim.keymap.set('n', '<leader>do', '<cmd>DiffviewOpen<CR>', { desc = 'Open Diffview' })
        vim.keymap.set('n', '<leader>df', '<cmd>DiffviewFileHistory %<CR>', { desc = 'Show history for current file' })
        vim.keymap.set('n', '<leader>dh', ':DiffviewFileHistory ', { desc = 'Show history' })
        vim.keymap.set('n', '<leader>dc', '<cmd>DiffviewClose<CR>', { desc = 'Close Diffview window' })
      end,
    }

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
        { 'n', 'gc', 'Comment toggle' },
        { 'n', 'gb', 'Comment Block toggle' },
        { 'v', 'gc', 'Comment toggle' },
        { 'v', 'gb', 'Comment block toggle' },
      },
    }

    -- Parentheses etc
    use { 'kylechui/nvim-surround', config = function() require('nvim-surround').setup() end }
    use {
      'windwp/nvim-autopairs',
      config = function()
        local npairs = require 'nvim-autopairs'
        local Rule = require 'nvim-autopairs.rule'

        local cmp = require 'nvim-autopairs.completion.cmp'

        require('cmp').event:on('confirm_done', cmp.on_confirm_done())

        npairs.setup {
          ignored_next_char = string.gsub([[ [%w%%%'%[%.] ]], '%s+', ''),
          enable_afterquote = false,
        }

        npairs.add_rules {
          Rule(' ', ' '):with_pair(function(opts)
            local pair = opts.line:sub(opts.col - 1, opts.col)
            return vim.tbl_contains({ '()', '[]', '{}' }, pair)
          end),
          Rule('( ', ' )')
            :with_pair(function() return false end)
            :with_move(function(opts) return opts.prev_char:match '.%)' ~= nil end)
            :use_key ')',
          Rule('{ ', ' }')
            :with_pair(function() return false end)
            :with_move(function(opts) return opts.prev_char:match '.%}' ~= nil end)
            :use_key '}',
          Rule('[ ', ' ]')
            :with_pair(function() return false end)
            :with_move(function(opts) return opts.prev_char:match '.%]' ~= nil end)
            :use_key ']',
        }

        npairs.get_rule('`'):with_pair(function() return vim.bo.filetype ~= 'systemverilog' end)

        npairs.get_rule("'")[1]:with_pair(function() return vim.bo.filetype ~= 'systemverilog' end)
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
        vim.api.nvim_create_user_command(
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
      config = function() require('persistence').setup() end,
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
      branch = 'lua',
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

        local nmap = function(lhs, rhs, opts) return vim.keymap.set('n', lhs, rhs, opts) end
        nmap('<c-h>', require('Navigator').left, { silent = true })
        nmap('<c-j>', require('Navigator').down, { silent = true })
        nmap('<c-k>', require('Navigator').up, { silent = true })
        nmap('<c-l>', require('Navigator').right, { silent = true })
      end,
    }

    -- Keymap help
    use {
      'folke/which-key.nvim',
      config = function()
        require('which-key').setup {
          plugins = {
            spelling = {
              enabled = true,
              suggestions = 20,
            },
          },
          triggers = { '<leader>', 'g', '<c-w>', '"', '`', 'z' },
        }
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
            expand = function(args) luasnip.lsp_expand(args.body) end,
          },
          mapping = {
            ['<C-p>'] = { i = cmp.mapping.select_prev_item() },
            ['<C-n>'] = { i = cmp.mapping.select_next_item() },
            ['<C-d>'] = { i = cmp.mapping.scroll_docs(-4) },
            ['<C-y>'] = { i = cmp.mapping.complete() },
            ['<C-e>'] = { i = cmp.mapping.close() },
            ['<CR>'] = { i = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace } },
            ['<C-k>'] = { i = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace } },
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
          mapping = cmp.mapping.preset.cmdline {
            ['<C-p>'] = { c = cmp.mapping.select_prev_item() },
            ['<C-n>'] = { c = cmp.mapping.select_next_item() },
            ['<C-y>'] = { c = cmp.mapping.complete() },
          },
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
              'markdown',
              'rst',
              'beancount',
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
                  ['ab'] = '@block.outer',
                  ['ib'] = '@block.inner',
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
      config = function() require('goto-preview').setup {} end,
    }
    use {
      'jose-elias-alvarez/null-ls.nvim',
      requires = 'nvim-lua/plenary.nvim',
    }
    use { 'folke/neodev.nvim' }
    use {
      'smjonas/inc-rename.nvim',
      config = function()
        require('inc_rename').setup {
          post_hook = function(result)
            local changed = {}
            for uri, changes in pairs(result.changes or result.documentChanges) do
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
          end,
        }
      end,
    }
    use {
      local_plugin 'lsp-format-modifications.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
    }
    use {
      'vigoux/notifier.nvim',
      config = function() require('notifier').setup { status_width = 70 } end,
    }
    use {
      'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
      disable = true,
      config = function()
        require('lsp_lines').setup()
        vim.diagnostic.config { virtual_lines = false, virtual_text = false }
        vim.keymap.set(
          'n',
          'g?',
          function() require('lsp_lines').toggle() end,
          { desc = 'Toggle LSP diagnostic lines' }
        )
      end,
    }

    use {
      'ThePrimeagen/refactoring.nvim',
      after = 'which-key.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
      },
      config = function()
        local refactoring = require 'refactoring'
        local wk = require 'which-key'

        refactoring.setup {}

        wk.register { ['<leader>r'] = { name = 'Refactoring' } }

        local maps = {
          { mode = 'v', key = 'e', name = 'Extract Function' },
          { mode = 'v', key = 'f', name = 'Extract Function To File' },
          { mode = 'v', key = 'v', name = 'Extract Variable' },
          { mode = 'v', key = 'i', name = 'Inline Variable' },
          { mode = 'n', key = 'b', name = 'Extract Block' },
          { mode = 'n', key = 'bf', name = 'Extract Block To File' },
          { mode = 'n', key = 'i', name = 'Inline Variable' },
        }
        for _, map in ipairs(maps) do
          vim.keymap.set(
            map.mode,
            '<leader>r' .. map.key,
            function() refactoring.refactor(map.name) end,
            { desc = map.name, silent = true, expr = false }
          )
        end
        vim.keymap.set(
          'n',
          '<leader>rpp',
          function() refactoring.debug.printf { below = false } end,
          { desc = 'Add debug print statement', silent = true }
        )
        vim.keymap.set(
          'n',
          '<leader>rpv',
          function() refactoring.debug.print_var { normal = true } end,
          { desc = 'Print variable', silent = true }
        )
        vim.keymap.set(
          'v',
          '<leader>rpv',
          function() refactoring.debug.print_var() end,
          { desc = 'Print variable', silent = true }
        )
        vim.keymap.set(
          'n',
          '<leader>rpc',
          function() refactoring.debug.cleanup {} end,
          { desc = 'Clean up debug prints', silent = true }
        )
      end,
    }

    use {
      'ibhagwan/fzf-lua',
      config = function()
        local fzf = require 'fzf-lua'
        fzf.setup {
          winopts = {
            border = 'single',
          },
        }
        fzf.register_ui_select()
      end,
    }

    use { 'vimjas/vim-python-pep8-indent', ft = { 'python' } }

    use {
      'rebelot/heirline.nvim',
      after = { 'espresso-tutti-colori.nvim', 'catppuccin' },
      config = function()
        local utils = require 'heirline.utils'
        local conditions = require 'heirline.conditions'

        local colors
        if os.getenv 'DARKMODE' then
          colors = require('catppuccin.palettes').get_palette 'mocha'
        else
          colors = require('tutti-colori.colors').setup()
        end
        colors.diag_warn = utils.get_highlight('DiagnosticSignWarn').fg
        colors.diag_error = utils.get_highlight('DiagnosticSignError').fg

        require('heirline').load_colors(colors)

        local align = { provider = '%=' }
        local space = { provider = ' ' }
        local lbound = { provider = '▊ ', hl = { fg = 'blue', bg = 'bg' } }
        local rbound = { provider = ' ▊', hl = { fg = 'blue', bg = 'bg' } }

        local FileNameBlock = {
          init = function(self) self.filename = vim.api.nvim_buf_get_name(0) end,
        }

        local FileName = {
          provider = function(self)
            local filename = vim.fn.fnamemodify(self.filename, ':.')
            if filename == '' then return '[No Name]' end

            if not conditions.width_percent_below(#filename, 0.25) then filename = vim.fn.pathshorten(filename) end

            return filename
          end,
          hl = { fg = 'blue' },
        }

        local FileFlags = {
          {
            provider = function()
              if vim.bo.modified then return ' [+]' end
            end,
            hl = { fg = 'green' },
          },
          {
            provider = function()
              if not vim.bo.modifiable or vim.bo.readonly then return ' RO' end
            end,
            hl = { fg = 'orange' },
          },
        }

        FileNameBlock = utils.insert(FileNameBlock, FileName, unpack(FileFlags), { provider = '%<' })

        local Ruler = { provider = '%l : %c  %P' }

        local Lsp = {
          condition = conditions.lsp_attached,
          update = { 'LspAttach', 'LspDetach' },
          provider = function()
            local names = {}
            for _, server in pairs(vim.lsp.get_active_clients { bufnr = 0 }) do
              table.insert(names, server.name)
            end
            return table.concat(names, ', ')
          end,
          hl = { fg = 'green' },
        }

        local Diagnostics = {
          condition = conditions.has_diagnostics,
          init = function(self)
            self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
            self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
          end,
          update = { 'DiagnosticChanged', 'BufEnter' },
          {
            provider = function(self) return self.errors > 0 and self.errors .. ' ' end,
            hl = { fg = 'diag_error' },
          },
          {
            provider = function(self) return self.warnings > 0 and self.warnings .. ' ' end,
          },
          hl = { fg = 'diag_warn' },
          on_click = {
            callback = function()
              local diagnostics = vim.diagnostic.get(0, { severity = { min = vim.diagnostic.severity.WARN } })
              vim.fn.setqflist(vim.diagnostic.toqflist(diagnostics))
              vim.cmd.copen { mods = { split = 'botright' } }
            end,
            name = 'heirline_diagnostics',
          },
        }

        local Window = {
          provider = function() return '- ' .. vim.api.nvim_win_get_number(0) .. ' -' end,
          hl = { fg = 'blue' },
        }

        local statusline_default = { lbound, FileNameBlock, align, Diagnostics, Lsp, space, Ruler, rbound }
        local statusline_inactive = {
          condition = function() return not conditions.is_active() end,
          lbound,
          FileNameBlock,
          align,
          Window,
          rbound,
        }
        local statusline = {
          fallthrough = false,
          hl = { bg = 'bg' },
          statusline_inactive,
          statusline_default,
        }

        require('heirline').setup(statusline)
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
      local_plugin 'espresso-tutti-colori.nvim',
      disable = os.getenv 'DARKMODE',
      config = function()
        require('tutti-colori').setup()
        require('tutti-colori').load()
      end,
    }
    use {
      'catppuccin/nvim',
      as = 'catppuccin',
      config = function()
        require('catppuccin').setup {
          flavour = 'mocha',
        }
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

    -- Integration with external tools
    use {
      'glacambre/firenvim',
      run = function() vim.fn['firenvim#install'](0) end,
      config = function()
        vim.g.firenvim_config = {
          localSettings = {
            ['.*'] = {
              takeover = 'never',
            },
          },
        }
      end,
    }
  end,
  config = { snapshot_path = vim.fn.stdpath 'config' },
}

vim.cmd.packadd 'dirbuf.nvim'

if os.getenv 'DARKMODE' then
  vim.cmd.colorscheme 'catppuccin'
else
  require('tutti-colori').setup()
  vim.cmd.colorscheme 'espresso-tutti-colori'
end

-- Configuration
vim.opt.backspace = { 'indent', 'eol', 'start' } -- Backspace everything

vim.opt.autoread = true -- Read changed files
vim.opt.hidden = true -- Allow to move away from modified files
vim.opt.autowriteall = true -- Write changes when losing focus

-- Visuals
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 4
vim.opt.showcmd = true -- Show incomplete commands while typing

vim.opt.termguicolors = true
vim.opt.background = 'dark'

vim.opt.showmatch = true -- Highligh matching braces

vim.opt.wrap = true -- Wrap lines
vim.opt.wrapmargin = 2 -- Stay 2 chars from side
vim.opt.textwidth = 79
vim.opt.colorcolumn = '81' -- Show indication of 81 chars
vim.opt.linebreak = true -- Smarter wrapping
vim.opt.breakindent = true -- Indent wrapped lines to same level

vim.opt.fixendofline = true -- Add EOL when missing

vim.opt.expandtab = true -- Add spaces when pressing tab
vim.opt.tabstop = 2 -- Tab is 2 spaces
vim.opt.shiftwidth = 2 -- Shift per 2 spaces
vim.opt.shiftround = true -- Round shifts to allign (1 space + tab = 2 spaces)

-- Searching and substitute
vim.opt.magic = true -- Enable regexes
vim.opt.hlsearch = true -- Highlight all matches
vim.opt.incsearch = true -- Show matches while typing
vim.opt.ignorecase = true
vim.opt.smartcase = true -- When search pattern contains cases, be case sensitive
vim.opt.gdefault = true -- Use global flag for substitute: replace all matches on line
vim.opt.inccommand = 'nosplit' -- Show live replacements directly in text

vim.opt.autoindent = true
vim.opt.cindent = true -- C-syntax based indenting

vim.opt.updatetime = 300 -- Faster triggering of CursorHold events

vim.opt.errorbells = false -- Don't you beep to me
vim.opt.title = false -- Don't set the shell title

vim.opt.history = 1000 -- Remember last commands

vim.opt.wildmenu = true -- Command completion
vim.opt.wildmode = 'longest:full,full'
vim.opt.shortmess:append 'c' -- Hide ins-completion messages

vim.opt.ttyfast = true -- fast terminal
vim.opt.lazyredraw = true
vim.opt.ttimeoutlen = -1 -- Minimum timeout

vim.opt.diffopt:append 'iwhite' -- Ignore whitespace in diffs
vim.opt.diffopt:append 'internal' -- Internal diff engine
vim.opt.diffopt:append 'algorithm:patience' -- Use patience algorithm

vim.opt.tags = { '.git/tags', 'tags' }

vim.opt.path:append '**' -- Recursively search current directory

vim.opt.formatoptions = {
  c = true, -- Wrap comments
  r = true, -- Continue comments
  o = true, -- Insert comment with o/O
  q = true, -- Format comments with gq
  n = true, -- Indent numbered lists
  [2] = true, -- Indent from 2nd line of paragraph
  [1] = true, -- Don't break before one letter words
}

vim.opt.signcolumn = 'yes' -- Always show signcolumn

vim.opt.cursorline = true

vim.opt.startofline = false -- When moving try to keep cursor in column

-- Show certain characters
vim.opt.list = true
vim.opt.listchars = { trail = '·', extends = '>', precedes = '<', nbsp = '+', tab = '▸ ' }

vim.opt.sessionoptions:remove 'options' -- Remove options from saved sessions (reload from config)

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

vim.opt.splitright = true -- Open new splits to right
vim.opt.virtualedit = 'block' -- Enable block editting

vim.opt.conceallevel = 0 -- Disable conceal

vim.opt.pastetoggle = '<F2>' -- Enable paste mode

local optdir = function(path)
  local Path = require 'plenary.path'
  local full_path = Path:new(vim.fn.stdpath 'cache' .. '/' .. path)
  if not full_path:exists() then full_path:mkdir { parents = true } end
  return full_path .. '//'
end

vim.opt.undofile = true -- Persistently remember undos
vim.opt.undolevels = 1000
vim.opt.undodir = optdir 'undo'
vim.opt.swapfile = false -- Disable swap files
vim.opt.backup = true -- Keep backups
vim.opt.backupdir = optdir 'backup'

-- Files to ignore from completion
vim.opt.wildignore:append {
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

vim.opt.mouse = {
  n = true, -- Normal mode
  i = true, -- Insert mode
  c = true, -- Commandline mode
  v = true, -- Visual mode
}

vim.opt.fillchars:append {
  diff = '╱',
}

vim.opt.jumpoptions:append { 'view' }

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldnestmax = 3
vim.opt.foldminlines = 1
vim.opt.foldtext =
  [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
vim.opt.foldenable = false

function _G.qftf(info)
  local items
  local ret = {}
  if info.quickfix == 1 then
    items = fn.getqflist({ id = info.id, items = 0 }).items
  else
    items = fn.getloclist(info.winid, { id = info.id, items = 0 }).items
  end
  local limit = 31
  local fnameFmt1, fnameFmt2 = '%-' .. limit .. 's', '…%.' .. (limit - 1) .. 's'
  local validFmt = '%s │%5d:%-3d│%s %s'
  for i = info.start_idx, info.end_idx do
    local e = items[i]
    local fname = ''
    local str
    if e.valid == 1 then
      if e.bufnr > 0 then
        fname = fn.bufname(e.bufnr)
        if fname == '' then
          fname = '[No Name]'
        else
          fname = fname:gsub('^' .. vim.env.HOME, '~')
        end
        -- char in fname may occur more than 1 width, ignore this issue in order to keep performance
        if #fname <= limit then
          fname = fnameFmt1:format(fname)
        else
          fname = fnameFmt2:format(fname:sub(1 - limit))
        end
      end
      local lnum = e.lnum > 99999 and -1 or e.lnum
      local col = e.col > 999 and -1 or e.col
      local qtype = e.type == '' and '' or ' ' .. e.type:sub(1, 1):upper()
      str = validFmt:format(fname, lnum, col, qtype, e.text)
    else
      str = e.text
    end
    table.insert(ret, str)
  end
  return ret
end

vim.o.qftf = '{info -> v:lua._G.qftf(info)}'

-- Clean up terminal codes from strings
local t = function(str) return vim.api.nvim_replace_termcodes(str, true, true, true) end

-- General keymaps
local map = vim.keymap.set

-- Set leader to space
vim.g.mapleader = ' '

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

-- Do not move on *
map('n', '*', function()
  local view = vim.fn.winsaveview()
  vim.cmd.normal { '*', bang = true }
  vim.fn.winrestview(view)
end, {
  silent = true,
  desc = 'Search word under cursor without moving to first results',
})

map('x', 'p', [[ p:if v:register == '"'<Bar>let @@=@0<Bar>endif<CR> ]], { silent = true })

map('n', '<UP>', ':cprev<CR>', { desc = 'Go to previous error/match' })
map('n', '<DOWN>', ':cnext<CR>', { desc = 'Go to next error/match' })
map('n', '<LEFT>', ':cpf<CR>', { desc = 'Go to previous error/match in previous file' })
map('n', '<RIGHT>', ':cnf<CR>', { desc = 'Go to next error/match in next file' })

map('t', '<C-h>', '<C-\\><C-n><C-w>h')
map('t', '<C-j>', '<C-\\><C-n><C-w>j')
map('t', '<C-k>', '<C-\\><C-n><C-w>k')
map('t', '<C-l>', '<C-\\><C-n><C-w>l')

map('c', '<CR>', function()
  local cmdline = vim.fn.getcmdline()
  if cmdline == 'ls' or cmdline == 'buffers' or cmdline == 'files' then return '<CR>:b' end
  return '<CR>'
end, { expr = true })

-- Clean up screen
map('n', '<ESC>', function()
  vim.cmd.nohlsearch()
  vim.cmd.cclose()
  vim.cmd.lclose()
end, { desc = 'Clean up screen' })

-- Special highlighting
vim.cmd.match { 'ErrorMsg', [[ '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$' ]] }

local au = require 'au'

-- Highlight yanked text
au.TextYankPost = function() vim.highlight.on_yank { timeout = 120 } end

-- Automatic cursorline
au.group('cline', {
  {
    'WinEnter',
    '*',
    function()
      if vim.bo.buftype ~= 'nofile' then vim.opt_local.cursorline = true end
    end,
  },
  {
    'WinLeave',
    '*',
    function() vim.opt_local.cursorline = false end,
  },
})

-- Save files on focus lost
au.FocusLost = function()
  if not vim.o.readonly and vim.api.nvim_buf_get_name(0) ~= '' then vim.cmd.wa() end
end

-- Equalize splits after resizing
au.VimResized = [[ exe "normal! \<c-w>=" ]]

-- Reload diffs after editing
au.BufWritePost = function()
  if vim.o.diff then vim.cmd.diffupdate() end
end

-- Open file at last position
au.BufReadPost = function()
  if vim.bo.filetype ~= 'gitcommit' and vim.fn.line '\'"' > 0 and vim.fn.line '\'"' <= vim.fn.line '$' then
    vim.cmd.normal { 'g`"', bang = true }
  end
end

-- Remove netrw buffers
au.FileType = { 'netrw', 'setlocal bufhidden=delete' }

-- Enable spelling
au.FileType = { { 'python', 'systemverilog', 'verilog', 'txt', 'lua' }, function() vim.opt_local.spell = true end }

-- Terminal
au.group('enter_term', {
  { 'TermOpen', '*', 'startinsert!' },
  {
    'BufEnter',
    '*',
    function()
      if vim.bo.buftype == 'terminal' then vim.cmd.startinsert { bang = true } end
    end,
  },
  {
    'BufLeave',
    '*',
    function()
      if vim.bo.buftype == 'terminal' then vim.cmd.stopinsert { bang = true } end
    end,
  },
})

-- Color number categories in reports and logs
au({ 'BufNewFile', 'BufRead', 'BufEnter' }, {
  '*.rpt,*.log',
  function()
    vim.cmd.syntax { 'match', 'String', [["\v<\d{1,3}>"]] }
    vim.cmd.syntax { 'match', 'Statement', [["\v<\d{4,6}>"]] }
    vim.cmd.syntax { 'match', 'Function', [["\v<\d{7,9}>"]] }

    vim.cmd.syntax { 'match', 'Number', [["\v<0+>"]] }

    vim.cmd.syntax { 'match', 'Error', [["\v\c^error:"]] }

    vim.wo.wrap = false
  end,
})

-- Apply changes in chezmoi managed files
au.group('chezmoi', {
  { 'BufWritePost', os.getenv 'HOME' .. '/.local/share/chezmoi/*', 'silent !chezmoi apply --source-path %' },
  {
    'BufWritePost',
    os.getenv 'HOME' .. '/.local/share/chezmoi/.chezmoitemplates/init.lua',
    'silent !chezmoi apply --source-path $HOME/.local/share/chezmoi/dot_config/nvim/init.lua.tmpl',
  },
})

-- Snippets
local ls = require 'luasnip'
-- Expand snippet or jump to next placeholder
vim.keymap.set({ 'i', 's' }, '<c-k>', function()
  if ls.expand_or_locally_jumpable() then ls.expand_or_jump() end
end, {
  silent = true,
})

-- Go back to previous placeholder
vim.keymap.set({ 'i', 's' }, '<c-j>', function()
  if ls.jumpable(-1) then ls.jump(-1) end
end, {
  silent = true,
})

-- Toggle options in snippets
vim.keymap.set('i', '<c-l>', function()
  if ls.choice_active() then ls.change_choice() end
end)

-- Copy the current file and line number
-- inspired by https://github.com/diegoulloao/nvim-file-location
vim.keymap.set('n', '<leader>cp', function()
  local Path = require 'plenary.path'
  local current_file = Path:new(vim.fn.expand '%')
  local root =
    vim.fs.dirname(vim.fs.find({ '.hg', '.git' }, { path = tostring(current_file:parent()), upward = true })[1])
  local current_line = vim.fn.line '.'
  require('osc52').copy(current_file:make_relative(root) .. ':' .. current_line)
  vim.notify 'Copied file path and line number'
end, { desc = 'Yank current path and line number' })

-- Navigate between open windows
for i = 1, 6 do
  vim.keymap.set('n', '<leader>' .. i, i .. '<c-w>w', { desc = 'Go to window ' .. i })
end

-- LSP config
local lsp = require 'lspconfig'
local null_ls = require 'null-ls'

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format {
    filter = function(client)
      local force_null_ls = { 'lua', 'beancount' }
      if vim.tbl_contains(force_null_ls, vim.bo.filetype) then return client.name == 'null-ls' end
      return true
    end,
    bufnr = bufnr,
  }
end

local on_attach = function(client, bufnr)
  local nmap = function(lhs, rhs, opts) return vim.keymap.set('n', lhs, rhs, opts) end

  local opts = { silent = true, buffer = bufnr }

  nmap('gp', require('goto-preview').goto_preview_definition, opts)
  nmap('gP', require('goto-preview').close_all_win, opts)

  nmap('gd', vim.lsp.buf.declaration, opts)
  nmap('K', vim.lsp.buf.hover, opts)
  nmap('gD', vim.lsp.buf.implementation, opts)
  nmap('1gD', vim.lsp.buf.type_definition, opts)
  nmap('gr', vim.lsp.buf.references, opts)
  nmap('g0', vim.lsp.buf.document_symbol, opts)
  nmap('ga', vim.lsp.buf.code_action, opts)

  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' })
  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' })

  if client.name == 'sumneko_lua' then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end

  if client.supports_method 'textDocument/rangeFormatting' then
    local root = vim.fs.find({ '.git', '.hg' }, { path = client.config.root_dir })
    local vcs = 'git'
    if root then vcs = vim.fs.basename(root[1]):sub(2) end

    vim.notify('Enabled modification formatting via ' .. vcs .. ' using ' .. client.name, vim.log.levels.INFO)
    local lsp_format_modifications = require 'lsp-format-modifications'
    lsp_format_modifications.attach(client, bufnr, { format_on_save = false, vcs = vcs })
    nmap('<c-p>', function() lsp_format_modifications.format_modifications_current_buffer() end, opts)
  elseif client.supports_method 'textDocument/formatting' then
    nmap('<c-p>', function() lsp_formatting(bufnr) end, opts)
  end
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  },
}

local root_dir = require('lspconfig.util').root_pattern('.git', '.hg')

lsp.pyright.setup { on_attach = on_attach, capabilities = capabilities, root_dir = root_dir }
lsp.bashls.setup { on_attach = on_attach, capabilities = capabilities }

lsp.esbonio.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = root_dir,
  -- Assume esbonio is installed with --user
  cmd = { home .. '/.local/bin/esbonio' },
}

lsp.clangd.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = root_dir,
}

local bean_file = os.getenv 'BEAN_FILE'
if bean_file then
  lsp.beancount.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    root_dir = root_dir,
    init_options = {
      journal_file = bean_file,
    },
  }
  local helpers = require 'null-ls.helpers'
  local bean_format = {
    name = 'bean-format',
    filetypes = { 'beancount' },
    method = null_ls.methods.FORMATTING,
    generator = helpers.formatter_factory {
      command = 'bean-format',
      args = { '-w', '80' },
      to_stdin = true,
    },
  }
  null_ls.register { bean_format }
end

null_ls.setup {
  sources = {
    null_ls.builtins.formatting.black.with { extra_args = { '--line-length', '100' } },
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.cbfmt,
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.code_actions.gitrebase,
    null_ls.builtins.hover.printenv,
  },
  on_attach = on_attach,
  root_dir = require('null-ls.utils').root_pattern('.hg', '.git', 'stylua.toml'),
}

require('neodev').setup {
  override = function(root_dir, options)
    if require('neodev.util').has_file(root_dir, '~/.local/share/chezmoi') then
      options.enabled = true
      options.runtime = true
      options.types = true
      options.plugins = true
    end
  end,
}
lsp.sumneko_lua.setup {
  lspconfig = {
    cmd = { 'lua-language-server' },
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
      },
    },
  },
}

local fd_quickfix = function(args)
  local grepprg = vim.opt.grepprg
  local grepformat = vim.opt.grepformat

  vim.opt.grepprg = 'fd'
  vim.opt.grepformat = '%f'
  vim.cmd.execute('"silent! grep! ' .. args.args .. '"')
  vim.cmd.copen()

  vim.opt.grepprg = grepprg
  vim.opt.grepformat = grepformat
end
vim.api.nvim_create_user_command('Cfd', fd_quickfix, { nargs = '+', complete = 'file' })

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
if ok then localconfig.setup { on_attach = on_attach, capabilities = capabilities } end
