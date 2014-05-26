" vim:fdm=marker

" General Settings {{{
set nocompatible
set laststatus=2
set noshowmode

let g:pathogen_disabled = ['ack']
execute pathogen#infect()

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
set lbr
set tabstop=2 shiftwidth=2
if has("gui_running")
  set background=dark
  " color base16-ocean
  color hybrid
else
  color hybrid
endif
set guifont=Inconsolata\ for\ Powerline:h12
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

set diffopt+=iwhite

set formatoptions=
set formatoptions+=c " Format comments
set formatoptions+=r " Continue comments by default
set formatoptions+=o " Make comment when using o or O from comment line
set formatoptions+=q " Format comments with gq
set formatoptions+=n " Recognize numbered lists
set formatoptions+=2 " Use indent from 2nd line of a paragraph
set formatoptions+=l " Don't break lines that are already long
set formatoptions+=1 " Break before 1-letter words

set splitright
set virtualedit=block
set conceallevel=0

set cryptmethod=blowfish

filetype plugin indent on
autocmd FileType ruby set tabstop=2|set shiftwidth=2

set clipboard=unnamed

set undofile
set viminfo='10,\"100,:20,%,n~/.viminfo

" set list
" set listchars=tab:▸\ ,eol:¬
" }}}
" Custom remaps and tricks {{{
" When editing a file, always jump to the last known cursor position.
" Don't do it for commit messages, when the position is invalid, or when
" inside an event handler (happens when dropping a file on gvim).
autocmd BufReadPost *
  \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

nnoremap <F5> :buffers<CR>:buffer<Space>

" Set leader to ,
let mapleader = ","

map <Leader>d  :bp<bar>sp<bar>bn<bar>bd<CR>

" See long lines as line breaks
map j gj
map k gk

" remap tag-search to better place
nmap <C-$> <C-]>

" Jump to end of line in insert mode
inoremap <C-a> <C-o>I
inoremap <C-e> <C-o>A

nnoremap <C-a> ^
nnoremap <C-e> $

nnoremap + <C-a>

" Jump out of inner bracket
inoremap <C-f> <ESC>%%a

" Switch between the last two files
nnoremap <SPACE><SPACE> <C-^>

" Very Magic search patterns
nmap / /\v
cmap s/ s/\v

" Clear highlight
nnoremap <silent> <leader>n :nohlsearch<CR>

inoremap £ \

nnoremap <TAB> %
vnoremap <TAB> %

" Move between windows
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w><C-k>

nnoremap <C-S-TAB>  :tabprevious<CR>
nnoremap <C-TAB>    :tabnext<CR>
inoremap <C-S-TAB>  <ESC>:tabprevious<CR>
inoremap <C-TAB>    <ESC>:tabnext<CR>

" highlight last inserted text
nnoremap gV `[v`]

" Briefly change colour of last highlight
nnoremap <silent> n   n:call HLNext(0.4)<cr>
nnoremap <silent> N   N:call HLNext(0.4)<cr>

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

let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1
highlight IndentGuidesEven guibg=background
highlight IndentGuidesOdd guibg='#282a2e'

au FileType c setl foldmethod=syntax


" }}}

" Vim Math plugin; make simple calculations {{{
vmap <expr>  ++  VMATH_YankAndAnalyse()
nmap         ++  vip++
" }}}
" Airline configuration {{{
let g:airline_inactive_collapse=0
let g:airline_powerline_fonts=1

let g:airline_left_sep = ''
let g:airline_right_sep = ''

let g:airline_theme = 'tomorrow'

let g:airline#extensions#syntastic#enabled = 0
" }}}
" YankRing {{{
let g:yankring_replace_n_pkey = 'cp'
nnoremap <silent> <leader>y :YRShow<CR>
" }}}
" Nerdtree {{{
map <F2> :NERDTreeToggle<CR>
map <Leader>e :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.aux$', '\.log$', '\.out$', '\.o$', '\.hex$', '\.bin$', '\.elf$']
" }}}
" Vim - Rspec {{{
map <leader>t :call RunCurrentSpecFile()<CR>
map <leader>s :call RunNearestSpec()<CR>
map <leader>l :call RunLastSpec()<CR>
map <leader>r :call RunAllSpecs()<CR>
" }}}
" Cucumber {{{
map <leader>f :call RunAllFeatures()<CR>
map <leader>k :call RunCurrentFeature()<CR>
" }}}
" ctrl p - Fuzzy file finder {{{
noremap <C-p> :CtrlP<CR>
let g:ctrl_map = '<c-p>'
let g:ctrl_cmd = 'CtrlP'

let g:ctrlp_working_path=0
nnoremap <C-o> :CtrlPBuffer<CR>
" map <C-m> :CtrlPTag<CR>

if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

" ctrl p - Commands
map <leader>p :CtrlPCmdPalette<CR>
" }}}
" Markdown {{{
let g:vim_markdown_folding_disabled=1
" }}}
" tComment {{{
nmap <leader>c <C-_><C-_>
" }}}
" Neo Complete {{{
let g:acp_enableAtStartup                           = 0
let g:neocomplete#enable_at_startup                 = 1
let g:neocomplete#enable_smart_case                 = 1
let g:neocomplete#enable_fuzzy_completion           = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern          = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif

let g:neocomplete#keyword_patterns['default'] = '\h\w*'
" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  " return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"

if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_overwrite_completefunc = 1
let g:neocomplete#force_omni_input_patterns.c =
      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
let g:neocomplete#force_omni_input_patterns.cpp =
      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
let g:neocomplete#force_omni_input_patterns.objc =
      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
let g:neocomplete#force_omni_input_patterns.objcpp =
      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
let g:clang_complete_auto = 0
let g:clang_auto_select = 0
"let g:clang_use_library = 1
let s:clang_library_path='/Library/Developer/CommandLineTools/usr/lib'
if isdirectory(s:clang_library_path)
    let g:clang_library_path=s:clang_library_path
endif

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
 if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
  endif

" autocmd FileType c NeoCompleteTagMakeCache
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
let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'

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
" Latex plugin {{{
au BufNewFile,BufRead,BufEnter *.tex setlocal spell spelllang=en_gb
au BufNewFile,BufRead,BufEnter *.tex setlocal textwidth=0
au BufNewFile,BufRead,BufEnter *.txt setlocal spell spelllang=en_gb
au BufNewFile,BufRead,BufEnter *.txt setlocal textwidth=0

let g:tex_conseal = ""

let g:tex_comment_nospell=1
let g:Tex_DefaultTargetFormat = 'pdf'
let g:tex_flavor = 'latex'
let g:Tex_TreatMacViewerAsUNIX = 1
let g:Tex_ExecuterUNIXViewerInForeground = 1
" let g:Tex_ViewRule_pdf = 'open -a Preview'
let g:Tex_ViewRule_pdf = 'open -a /Applications/TeX/TeXShop.app'

let g:Tex_ViewRule_ps = 'open -a Preview'

nnoremap <leader>m :w<CR>:!rubber --pdf --warn all %<CR>
" }}}
" Tagbar {{{
nmap <F8> :TagbarToggle<CR>
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

" Load local vimrc
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

nnoremap <Enter> o<ESC>
