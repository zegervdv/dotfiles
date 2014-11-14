" vim:fdm=marker
" Vim-Plug {{{
let g:plug_window='topleft new'
call plug#begin('~/.vim/plugged')
" General Plugins
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-abolish'
" Plug 'bling/vim-airline'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'kshenoy/vim-signature'
Plug 'tpope/vim-repeat'
Plug 't9md/vim-smalls'
Plug 'mhinz/vim-startify'
Plug 'xolox/vim-session'
Plug 'tpope/vim-eunuch'
Plug 'junegunn/vim-after-object'
Plug 'scrooloose/syntastic'
Plug 'chriskempson/base16-vim'
" Undo
Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' }

" Tmux
Plug 'benmills/vimux', { 'on': 'VimuxRunCommand' }
" Plug 'edkolev/tmuxline.vim'
Plug 'christoomey/vim-tmux-navigator'

" Search and Complete
Plug 'Shougo/neocomplete'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/vimproc', { 'do': 'make' }
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler.vim'
Plug 'Shougo/unite-outline'
Plug 'tsukkee/unite-tag'

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

" Python
" Plug 'davidhalter/jedi-vim', { 'for': 'python' }

" Coffeescript
Plug 'kchmck/vim-coffee-script', { 'for': 'coffeescript' }

" Dependencies
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'

Plug 'xolox/vim-misc'
Plug 'tpope/vim-git'


call plug#end()
" }}}
" General Settings {{{
set nocompatible
set laststatus=2
set noshowmode

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

" Layout
set t_Co=256
set background=dark
color Tomorrow-Night
set guifont=Inconsolata\ for\ Powerline:h12
" Make background color same as terminal ("transparent")
" hi Normal ctermbg=none

set autowrite
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


set sessionoptions-=options

set complete+=kspell

set splitright
set virtualedit=block
set conceallevel=0

set cryptmethod=blowfish

filetype plugin indent on
autocmd FileType ruby set tabstop=2|set shiftwidth=2

set pastetoggle=<F2>
set clipboard=unnamed

set undofile
set viminfo='10,\"100,:20,%,n~/.viminfo
set backupdir=/tmp//,.
set directory=/tmp//,.
if v:version >= 703
  set undodir=/tmp//,.
endif
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.o,*.bin,*.elf,*.hex

" Sentences are ended with double spaces
set cpo+=J

" set list
" set listchars=tab:▸\ ,eol:¬
" }}}
" Status line {{{
" set statusline=
" set statusline+=»
" set statusline+=\ %f  
" set statusline+=%1*%m%0*
" set statusline+=\ [%{strlen(&ft)?&ft:'unknown'}]
" set statusline+=%=
" set statusline+=%P\ 

function! Status()
  let statusline = ''
  let statusline .= "»\ "
  let statusline .= "%f"
  let statusline .= "%1*%m%0*"
  let statusline .= "\ [%{strlen(&ft)?&ft:'unknown'}]"
  let statusline .= "%="
  let statusline .= "%P\ "
  return statusline
endfunction

set statusline=%!Status()

" }}}
" Custom remaps and tricks {{{
" Enable spelling only for latex and text
au BufNewFile,BufRead,BufEnter *.tex setlocal spell spelllang=en_gb
au BufNewFile,BufRead,BufEnter *.tex setlocal textwidth=0
au BufNewFile,BufRead,BufEnter *.txt setlocal spell spelllang=en_gb
au BufNewFile,BufRead,BufEnter *.txt setlocal textwidth=0
au FileType gitcommit setlocal spell spelllang=en_gb

autocmd BufRead *_spec.rb set filetype=rspec

highlight SpellBad ctermbg=256 ctermfg=210
highlight SpellLocal ctermbg=240 ctermfg=010

" When editing a file, always jump to the last known cursor position.
" Don't do it for commit messages, when the position is invalid, or when
" inside an event handler (happens when dropping a file on gvim).
autocmd BufReadPost *
      \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif

" Set leader to space
" let mapleader = " "
map <space> <leader>

" Fix weird error where space n hangs vim with search
noremap <space>n <nop>

" See long lines as line breaks
map j gj
map k gk

" remap tag-search to better place
" nmap <C-$> <C-]>
function! JumpToTagInSplit()
  execute "normal! \<c-w>v\<c-]>mzzMzvzz15\<c-e>"
  execute "keepjumps normal! `z"
  Pulse
endfunction
nnoremap <C-$> :silent! call JumpToTagInSplit()<CR>

" Jump to end of line in insert mode
inoremap <C-a> <C-o>I
inoremap <C-e> <C-o>A

nnoremap <C-a> ^
nnoremap <C-e> $

nnoremap <C-s> <C-e>

nnoremap + <C-a>

" Jump out of inner bracket
inoremap <C-f> <ESC>%%a

" Switch between the last two files
nnoremap <leader><leader> <C-^>
" Move between buffers
nnoremap gb :bnext<CR>
nnoremap gB :bprevious<CR>

" Very Magic search patterns
nmap / /\v
cmap s/ s/\v

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Clear highlight
nnoremap <silent><leader>l :noh<CR>

inoremap £ \

nnoremap <TAB> %
vnoremap <TAB> %

" Move between splits
" map <C-j> <C-w>j
" map <C-k> <C-w>k
" map <C-l> <C-w>l
" map <C-h> <C-w>h

" highlight last inserted text
nnoremap gV `[v`]

" Briefly change colour of last highlight
" nnoremap <silent> n   n:call HLNext(0.4)<cr>
" nnoremap <silent> N   N:call HLNext(0.4)<cr>

function! HLNext (blinktime)
  highlight WhiteOnRed ctermfg=white ctermbg=red guifg=white guibg=red
  let [bufnum, lnum, col, off] = getpos('.')
  let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
  let target_pat = '\c\%#'.@/
  let ring = matchadd('WhiteOnRed', target_pat, 101)
  redraw
  exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
  call matchdelete(ring)
  redraw
endfunction

" Highlight matching parenthesis in different color so I don't mess up
hi MatchParen cterm=underline ctermbg=none ctermfg=white gui=underline guibg=black guifg=white

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

au FileType c setl foldmethod=syntax

au VimResized * exe "normal! \<c-w>="

cnoremap <c-a> <home>
cnoremap <c-e> <end>

" Swap backticks and quotes
nnoremap ` '
nnoremap ' `

" Note that this will overwrite the contents of the z mark.  I never use it, but
" if you do you'll probably want to use another mark.
inoremap <C-u> <esc>mzgUiw`za

nnoremap <leader>ev :split $MYVIMRC<cr>

" Move lines from visual selection
vnoremap <S-j> :m '>+1<CR>gv=gv
vnoremap <S-k> :m '<-2<CR>gv=gv

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

" VHDL ctags
let g:tlist_vhdl_settings   = 'vhdl;d:package declarations;b:package bodies;e:entities;a:architecture specifications;t:type declarations;p:processes;f:functions;r:procedures'
" }}}
" Latex {{{
" Compile using rubber
nnoremap <leader>m :w<CR>:VimProcBang rubber --pdf --warn all %<CR>
" Open pdf
nnoremap <silent> <leader>v :silent !open %:r.pdf<CR><CR>
" }}}
" Vim Math plugin; make simple calculations {{{
vmap <expr>  ++  VMATH_YankAndAnalyse()
nmap         ++  vip++
" }}}
" Airline configuration {{{
" let g:airline_inactive_collapse=0
" let g:airline_powerline_fonts=1
" let g:airline#extensions#tmuxline#enabled = 0
"
" let g:airline_left_sep = ''
" let g:airline_right_sep = ''
"
" if has("gui_running")
"   let g:airline_theme = 'base16'
" else
"   let g:airline_theme = 'tomorrow'
" endif
" let g:airline#extensions#syntastic#enabled = 1
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#fnamemod = ':t'
" let g:airline#extensions#tabline#left_sep = ''
" let g:airline#extensions#tabline#left_alt_sep = ''
" let g:airline#extensions#tabline#right_sep = ''
" let g:airline#extensions#tabline#right_alt_sep = ''
" }}}
" Unite {{{
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
" call unite#set_profile('files', 'smartcase', 1)
call unite#custom#profile('files', 'context.smartcase', 1)
call unite#custom#source('line,outline', 'matchers', 'matcher_fuzzy')
call unite#custom#source( 'buffer', 'converters', ['converter_file_directory'])
" sort file results by length
call unite#custom#source('file', 'sorters', 'sorter_length')
call unite#custom#source('file_rec/async', 'converters', [])
call unite#custom#source('file_rec/async', 'sorters', [])
call unite#custom#source('file_rec/async', 'max_candidates', 20)
let g:unite_enable_start_insert=0
let g:unite_source_history_yank_enable=1
let g:unite_source_rec_max_cache_files=3000
let g:unite_prompt='» '
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts =
        \ '-i --line-numbers --nocolor --nogroup --hidden --ignore ' .
        \  '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
  let g:unite_source_grep_recursive_opt = ''
  let g:unite_source_rec_async_command = 'ag --nocolor --nogroup --hidden -g ""'
elseif executable('ack')
  let g:unite_source_grep_command='ack'
  let g:unite_source_grep_default_opts='--no-heading --no-color -C4'
  let g:unite_source_grep_recursive_opt=''
endif
function! s:unite_settings()
  nmap <buffer> Q <plug>(unite_exit)
  nmap <buffer> <esc> <plug>(unite_exit)
  imap <buffer> <C-j> <Plug>(unite_select_next_line)
  imap <buffer> <C-k> <Plug>(unite_select_previous_line)
endfunction
autocmd FileType unite call s:unite_settings()

nnoremap <silent> <SPACE>k :<C-u>Unite -auto-preview -buffer-name=recent file_mru<cr>
nnoremap <silent> <leader>y :<C-u>Unite -buffer-name=yanks history/yank<cr>
nnoremap <silent> <leader>f :<C-u>Unite -no-quit -buffer-name=search grep:.<cr>
nnoremap <silent> <leader>g :<C-u>Unite -no-quit -buffer-name=search grep:.<CR><C-r><C-w><CR>
nnoremap <silent> <leader>o :<C-u>Unite outline<CR>
nnoremap <silent> <leader>t :<C-u>Unite tag<CR>
nnoremap <silent> <C-p>    :<C-u>Unite -start-insert buffer file_rec/async<CR>
" nnoremap <silent> <leader>h :<C-u>Unite ssh://Hurricane/STM-Quadcopter/source<CR>
" nnoremap <silent> <leader>i :<C-u>Unite ssh://imac-van-zeger.local/Documents<CR>
" }}}
" Unite Build {{{
" TODO: Create builders eg Latex, Vagrant?
" }}}
" Vimfiler {{{
" Use vimfiler as default
let g:vimfiler_as_default_explorer = 1
nnoremap <leader>e :VimFilerExplorer<CR>
let g:vimfiler_ignore_pattern = '\%(.o\|.bin\|.elf\|.un\~\|.swp\)$'
" }}}
" Cucumber {{{
" map <leader>f :call RunAllFeatures()<CR>
" map <leader>k :call RunCurrentFeature()<CR>
" }}}
" Markdown {{{
let g:vim_markdown_folding_disabled=1
" }}}
" tComment {{{
nmap <leader>c <C-_><C-_>
" }}}
" Neo Complete {{{
let g:neocomplete#enable_at_startup = 1
let g:neocomplet#enable_smart_case = 1
let g:marching_enable_neocomplete = 1
let g:neocomplete#enable_fuzzy_completion = 1

inoremap <expr><s-CR> pumvisible() ? neocomplete#smart_close_popup()"\<CR>" : "\<CR>"
inoremap <expr><C-g> neocomplete#undo_completion()
inoremap <expr><C-l> neocomplete#complete_common_string()
function! CleverCr()
  if pumvisible()
    if neosnippet#expandable()
      let exp = "\<Plug>(neosnippet_expand)"
      return exp . neocomplete#smart_close_popup()
    else
      return neocomplete#smart_close_popup()
    endif
  else
    return "\<CR>"
  endif
endfunction
" <CR> close popup and save indent or expand snippet
imap <expr> <CR> CleverCr()

" }}}
" Neo Snippets {{{
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"       \ "\<Plug>(neosnippet_expand_or_jump)"
"       \: pumvisible() ? "\<C-n>" : "\<TAB>"
" smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"       \ "\<Plug>(neosnippet_expand_or_jump)"
"       \: "\<TAB>"


imap <expr><TAB> neosnippet#expandable() == 1 ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
imap <expr><C-k> neosnippet#expandable_or_jumpable() == 1 ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() == 1 ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
" let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'

let g:neosnippet#snippets_directory='~/.vim/snippets'
" }}}
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
" }}}
" Tagbar {{{
nmap <F8> :TagbarToggle<CR>
" }}}
" Syntastic {{{
let g:syntastic_check_on_open=1
" }}}
" Gundo tree {{{
nnoremap <leader>u :GundoToggle<CR>
" }}}
" Smalls {{{
nmap s <Plug>(smalls)
omap s <Plug>(smalls)
xmap s <Plug>(smalls)
" }}}
" Textmanip {{{
xmap <C-j> <Plug>(textmanip-move-down)
xmap <C-k> <Plug>(textmanip-move-up)
xmap <C-h> <Plug>(textmanip-move-left)
xmap <C-l> <Plug>(textmanip-move-right)
xmap <F10> <Plug>(textmanip-toggle-mode)
" }}}
" Startify {{{
let g:startify_session_dir = "~/.vim/sessions"
" }}}
" Vimwiki {{{
let g:vimwiki_list=[{'path':'$HOME/.vimwiki'}]
" }}}
" Vim Sessions {{{
let g:session_autosave = 'no'
" }}}
" Jedi {{{
let g:jedi#auto_vim_configuration=0
let g:jedi#completions_enabled = 0
" }}}
" Vimux {{{
let g:VimuxUseNearest = 1
nnoremap <buffer> <silent><leader>s :w<CR>
autocmd FileType python nnoremap <buffer> <silent><leader>s :w<CR>:VimuxRunCommand('%run -i ' . expand('%'))<CR>
autocmd FileType ruby nnoremap <buffer> <silent><leader>s :w<CR>:VimuxRunCommand('rake spec')<CR>
autocmd FileType  c nnoremap <buffer> <silent><leader>s :w<CR>:VimuxRunCommand('make')<CR>
" }}}
" Tmuxline {{{
" let g:tmuxline_powerline_separators=0
" let g:tmuxline_preset = {
"       \ 'a': '',
"       \ 'b': '',
"       \ 'c': '',
"       \ 'win': ['#I', '#W'],
"       \ 'cwin': ['#I', '#W'],
"       \ 'y': '',
"       \ 'z': ''}
" let g:tmuxline_theme = {
"       \ 'a'  : [250, 109],
"       \ 'b': [250, 239],
"       \ 'c': [250, 235],
"       \ 'win': [241, 235],
"       \ 'cwin': [250, 235],
"       \ 'x' : [250, 235],
"       \ 'y': [250, 235],
"       \ 'z': [250, 235],
"       \ 'bg' : [250, 235],
"       \ }
" }}}
" After-objects {{{
autocmd VimEnter * call after_object#enable('=', ':', '-', '#', ' ')
" }}}
" Vim-tmux-navigator {{{
" nnoremap <silent> <C-h> :TmuxNavigateLeft<CR>
" }}}
" Load local vimrc
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

