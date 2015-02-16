" vim:fdm=marker

" Include Vim-Plug {{{
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !mkdir -p ~/.vim/autoload
  silent !curl -fLo ~/.vim/autoload/plug.vim
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif
" }}}
" Vim-Plug {{{
let g:plug_window='topleft new'
call plug#begin('~/.vim/plugged')
" General Plugins
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'

" Session Management
Plug 'tpope/vim-obsession'

" Spelling
Plug 'tpope/vim-abolish'

" Brackets
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'

" Formatting
Plug 'godlygeek/tabular', { 'on' : 'Tabularize' }
Plug 'pelodelfuego/vim-swoop', { 'on' : ['Swoop', 'SwoopSelection', 'SwoopMulti', 'SwoopMultiSelection'] }

" Comments
Plug 'tpope/vim-commentary'

" Moving in files
Plug 'wellle/targets.vim'
Plug 'rking/ag.vim'

" Command line
Plug 'tpope/vim-eunuch', { 'on' : ['Remove', 'Unlink', 'Move', 'Rename', 'Mkdir', 'Chmod', 'Find', 'Locate', 'SudoEdit', 'SudoWrite']}

" Syntax and checking
Plug 'scrooloose/syntastic'

" Undoing
Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' }

" Tmux
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-dispatch'

" Completing and snippets
Plug 'shougo/neocomplete.vim'
Plug 'shougo/neosnippet.vim'
Plug 'shougo/neosnippet-snippets'

" Vim file navigation
Plug 'tpope/vim-vinegar'

" Open and find files
Plug 'ctrlpvim/ctrlp.vim'

" Don't use arrows!
Plug 'mrmargolis/dogmatic.vim'

" Theme
Plug 'w0ng/vim-hybrid'

" Ruby
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'tpope/vim-bundler', { 'for': 'ruby' }
Plug 'tpope/vim-rake', { 'for': 'ruby' }
Plug 'slim-template/vim-slim', { 'for': 'ruby' }
Plug 'duwanis/tomdoc.vim', { 'for': 'ruby' }

" Markdown
Plug 'tpope/vim-markdown', { 'for': 'markdown' }

" C
Plug 'vim-scripts/a.vim', { 'for': 'c' }
Plug 'osyo-manga/vim-reunions', { 'for': 'c' }
Plug 'osyo-manga/vim-marching', { 'for': 'c' }

" Coffeescript
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }

" Latex
Plug 'lervag/vim-latex', { 'for': 'tex' }

" Git
Plug 'tpope/vim-git'
call plug#end()
" }}}

" General Settings and options {{{
set nocompatible
" Backspace over everything, like normal 
set backspace=2
set autowrite

set vb
set guioptions-=r
set guioptions-=l
set guioptions-=R
set guioptions-=L

syntax on
set expandtab
set number
set ruler
set nocursorline
set showmatch
set title
set wrap
set wrapmargin=2
set linebreak
set breakindent
set lbr
set tabstop=2 shiftwidth=2

" Theme and style
set t_Co=256
set background=dark
colorscheme Tomorrow-Night
set guifont=Fira\ Mono:h11

set hidden
set hlsearch
set incsearch
set ignorecase
set gdefault
set smartcase
set smartindent
set autoindent
set scrolloff=4
set textwidth=80

set history=100
set wildmenu
set wildmode=full
set ttyfast
set lazyredraw

set ttimeoutlen=10
" Set the timeout to a minimum
set diffopt+=iwhite

set tags=.git/tags

set formatoptions=
set formatoptions+=c " Format comments
set formatoptions+=r " Continue comments by default
set formatoptions+=o " Make comment when using o or O from comment line
set formatoptions+=q " Format comments with gq
set formatoptions+=n " Recognize numbered lists
set formatoptions+=2 " Use indent from 2nd line of a paragraph
set formatoptions+=l " Don't break lines that are already long
set formatoptions+=1 " Break before 1-letter words

" Enable cursorline
set cursorline
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

set sessionoptions-=options

" Scan files for completion
set complete=.,w,b,u,k,kspell,t,i,d

set splitright
set virtualedit=block
set conceallevel=0

set cryptmethod=blowfish

filetype plugin indent on

set pastetoggle=<F2>
set clipboard=unnamed

set undofile
set viminfo='10,\"100,:20,%,n~/.viminfo
set backupdir=/tmp//,.
set directory=/tmp//,.
if v:version >= 703
  set undodir=/tmp//,.
endif

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.o,*.bin,*.elf,*.hex,*.eps,.git/**

" Sentences are ended with double spaces
set cpo+=J
" }}}
" Status line {{{
function! Status()
  let statusline = ''
  let statusline .= "%n\ "
  let statusline .= "%f"
  let statusline .= "%m"
  let statusline .= "\ [%{strlen(&ft)?&ft:'unknown'}]"
  let statusline .= "%="
  let statusline .= "%P\ "
  return statusline
endfunction
set laststatus=2
set statusline=%!Status()
" }}}
" Fix Colors in colorscheme {{{
highlight SpellBad ctermbg=256 ctermfg=210
highlight SpellLocal ctermbg=240 ctermfg=010
highlight SpellCap ctermbg=256 ctermfg=211
"}}}

" Mappings {{{
" Set leader to spacebar
map <space> <leader>

" See long lines as line breaks
map j gj
map k gk

" Remap tag-search to better place
nmap <C-$> <C-]>

" Jump to end of line in insert mode
inoremap <C-a> <C-o>I
inoremap <C-e> <C-o>A

nnoremap <C-a> ^
nnoremap <C-e> $

nnoremap <C-s> <C-e>

nnoremap + <C-a>

" Move while in insert mode
inoremap <C-f> <right>

" Switch between the last two files
nnoremap <leader><leader> <C-^>

" Very Magic search patterns
nmap / /\v
cmap s/ s/\v

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Clear highlight
nnoremap <silent><leader>l :noh<CR>

inoremap £ \

" Highlight last inserted text
nnoremap gV `[v`]

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Swap v and CTRL-V
nnoremap    v   <C-V>
nnoremap <C-V>     v

vnoremap    v   <C-V>
vnoremap <C-V>     v

" Use backspace as delete in visual mode
vmap <BS> x

" Keep selection when shifting
vmap <expr> > KeepVisualSelection(">")
vmap <expr> < KeepVisualSelection("<")

function! KeepVisualSelection(cmd)
  set nosmartindent
  if mode() ==# "V"
    return a:cmd . ":set smartindent\<CR>gv"
  else
    return a:cmd . ":set smartindent\<CR>"
  endif
endfunction

" Some emacs behavior 
cnoremap <c-a> <home>
cnoremap <c-e> <end>

" Swap backticks and quotes
nnoremap ` '
nnoremap ' `

" Open vimrc
nnoremap <leader>ev :e $MYVIMRC<CR>
" }}}

" Functions {{{
" When editing a file, always jump to the last known cursor position.
" Don't do it for commit messages, when the position is invalid, or when
" inside an event handler (happens when dropping a file on gvim).
autocmd BufReadPost *
      \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif

" Make matching parenthesis more clear
" This is adapted from
" http://vim.wikia.com/wiki/Windo_and_restore_current_window
function! KeepWin(command)
  let currwin=winnr()
  execute a:command
  execute currwin . 'wincmd w'
endfunction

augroup insertMatch
    au!
    au VimEnter * NoMatchParen
    au InsertEnter * call KeepWin("DoMatchParen")
    au InsertLeave * call KeepWin("NoMatchParen")
augroup END

" Resize splits after window resize
au VimResized * exe "normal! \<c-w>="

" Custom folding by Steve Losh
function! MyFoldText() " {{{
  let line = getline(v:foldstart)

  let nucolwidth = &fdc + &number * &numberwidth
  let windowwidth = winwidth(0) - nucolwidth - 3
  let foldedlinecount = v:foldend - v:foldstart

  " expand tabs into spaces
  let onetab = strpart('          ', 0, &tabstop)
  let line = substitute(line, '\t', onetab, 'g')

  let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
  let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
  return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}
set foldtext=MyFoldText()
" }}}

" Filetype specific settings
" Latex {{{
" Open pdf
nnoremap <leader>v :!open -a /Applications/TeX/TeXShop.app %:r.pdf<CR><CR>
" Set compiler to rubber
autocmd FileType tex setlocal makeprg=latexmk\ -pdf\ %:r
au BufNewFile,BufRead,BufEnter *.tex setlocal spell spelllang=en_gb
au BufNewFile,BufRead,BufEnter *.tex setlocal textwidth=0
" }}}
" Markdown {{{
let g:vim_markdown_folding_disabled=1
" }}}
" Text {{{
au BufNewFile,BufRead,BufEnter *.txt setlocal spell spelllang=en_gb
au BufNewFile,BufRead,BufEnter *.txt setlocal textwidth=0
" }}}
" Git commit messages {{{
au FileType gitcommit setlocal spell spelllang=en_gb
" }}}
" Ruby {{{
autocmd BufRead *_spec.rb set filetype=rspec
" }}}
" Matlab {{{
autocmd FileType matlab setlocal commentstring=\%\ %s
" }}}
" C {{{
au FileType c setlocal foldmethod=syntax
" }}}
" VHDL {{{
" VHDL ctags
let g:tlist_vhdl_settings   = 'vhdl;d:package declarations;b:package bodies;e:entities;a:architecture specifications;t:type declarations;p:processes;f:functions;r:procedures'
" }}}

" Plugin settings
" Tabular {{{
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

" Align Migration files
vmap <c-a> :Tabularize /:/l1l0l0<CR>

nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a=> :Tabularize /=><CR>
vmap <Leader>a=> :Tabularize /=><CR>
nmap <Leader>a: :Tabularize /:\zs/l0l1<CR>
vmap <Leader>a: :Tabularize /:\zs/l0l1<CR>
nmap <Leader>a, :Tabularize /,\zs/l0l1<CR>
vmap <Leader>a, :Tabularize /,\zs/l0l1<CR>
vmap <Leader>a- :Tabularize /-<CR>
" }}}
" Syntastic {{{
let g:syntastic_check_on_open=1
" }}}
" Gundo tree {{{
nnoremap <leader>u :GundoToggle<CR>
" }}}
" Dispatch {{{
nnoremap <leader>s :Make<CR>
autocmd FileType python setlocal makeprg=ipython\ --pdb\ %
autocmd FileType ruby setlocal makeprg=ruby\ %
" }}}
" CtrlP {{{
if executable('ag')
  set grepprg=ag\ --nogroup\ --color

  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif
" }}}
" Neocomplete {{{
let g:neocomplete#enable_at_startup=1
" let g:neocomplete#data_directory=s:get_cache_dir('neocomplete')
" }}}
" Neosnippet {{{
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets,~/.vim/snippets'
let g:neosnippet#enable_snipmate_compatibility=1

imap <expr><TAB> neosnippet#expandable() == 1 ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
imap <expr><C-k> neosnippet#expandable_or_jumpable() == 1 ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() == 1 ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.tex =
      \ '\v\\\a*(ref|cite)\a*([^]]*\])?\{([^}]*,)*[^}]*'
" }}}
" Swoop {{{
let g:swoopUseDefaultKeyMap = 0
" }}}
" Ag {{{
" Ack motions by Steve Losh, adapted for Ag
nnoremap <silent> \a :set opfunc=<SID>AckMotion<CR>g@
xnoremap <silent> \a :<C-U>call <SID>AckMotion(visualmode())<CR>
 
function! s:CopyMotionForType(type)
    if a:type ==# 'v'
        silent execute "normal! `<" . a:type . "`>y"
    elseif a:type ==# 'char'
        silent execute "normal! `[v`]y"
    endif
endfunction
 
function! s:AckMotion(type) abort
    let reg_save = @@
 
    call s:CopyMotionForType(a:type)
 
    execute "normal! :Ag --literal " . shellescape(@@) . "\<cr>"
 
    let @@ = reg_save
endfunction
" }}}

" Load local vimrc
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

" Load project local vimrc
if filereadable(".vimrc.local")
  source .vimrc.local
endif

