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
set ttyfast
set lazyredraw

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

set complete+=kspell

set splitright
set virtualedit=block
set conceallevel=0

set cryptmethod=blowfish

filetype plugin indent on
autocmd FileType ruby set tabstop=2|set shiftwidth=2

set clipboard=unnamed

set undofile
set viminfo='10,\"100,:20,%,n~/.viminfo

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.o,*.bin,*.elf,*.hex

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
nnoremap <SPACE><SPACE> <C-^>

" Very Magic search patterns
nmap / /\v
cmap s/ s/\v

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Show local search results in quickfix
nnoremap <silent> <leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>
nnoremap <silent> <leader>? :Ag <cword><CR>
" nnoremap <silent> <leader>? :execute "Ag! '" . substitute(substitute(substitute(@/, "\\\\<", "\\\\b", ""), "\\\\>", "\\\\b", ""), "\\\\v", "","") . "'"<CR>

" Clear highlight
nnoremap <silent> <leader>n :nohlsearch<CR>

inoremap £ \

nnoremap <TAB> %
vnoremap <TAB> %

" Move between tabs
nnoremap <S-j>  :tabprevious<CR>
nnoremap <S-k>  :tabnext<CR>
nnoremap <S-h>  :tabfirst<CR>
nnoremap <S-l>  :tablast<CR>
nnoremap <S-t>  :tabnew<CR>
inoremap <C-S-TAB>  <ESC>:tabprevious<CR>
inoremap <C-TAB>    <ESC>:tabnext<CR>

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
hi MatchParen cterm=underline ctermbg=none ctermfg=white gui=underline guifg=white

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

let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1
highlight IndentGuidesEven guibg=background
highlight IndentGuidesOdd guibg='#282a2e'

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

nnoremap <leader>ev :vsplit $MYVIMRC<cr>

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

" Next and Last {{{
"
" Motion for "next/last object".  "Last" here means "previous", not "final".
" Unfortunately the "p" motion was already taken for paragraphs.
"
" Next acts on the next object of the given type, last acts on the previous
" object of the given type.  These don't necessarily have to be in the current
" line.
"
" Currently works for (, [, {, and their shortcuts b, r, B. 
"
" Next kind of works for ' and " as long as there are no escaped versions of
" them in the string (TODO: fix that).  Last is currently broken for quotes
" (TODO: fix that).
"
" Some examples (C marks cursor positions, V means visually selected):
"
" din'  -> delete in next single quotes                foo = bar('spam')
"                                                      C
"                                                      foo = bar('')
"                                                                C
"
" canb  -> change around next parens                   foo = bar('spam')
"                                                      C
"                                                      foo = bar
"                                                               C
"
" vin"  -> select inside next double quotes            print "hello ", name
"                                                       C
"                                                      print "hello ", name
"                                                             VVVVVV

onoremap an :<c-u>call <SID>NextTextObject('a', '/')<cr>
xnoremap an :<c-u>call <SID>NextTextObject('a', '/')<cr>
onoremap in :<c-u>call <SID>NextTextObject('i', '/')<cr>
xnoremap in :<c-u>call <SID>NextTextObject('i', '/')<cr>

onoremap al :<c-u>call <SID>NextTextObject('a', '?')<cr>
xnoremap al :<c-u>call <SID>NextTextObject('a', '?')<cr>
onoremap il :<c-u>call <SID>NextTextObject('i', '?')<cr>
xnoremap il :<c-u>call <SID>NextTextObject('i', '?')<cr>


function! s:NextTextObject(motion, dir)
    let c = nr2char(getchar())
    let d = ''

    if c ==# "b" || c ==# "(" || c ==# ")"
        let c = "("
    elseif c ==# "B" || c ==# "{" || c ==# "}"
        let c = "{"
    elseif c ==# "r" || c ==# "[" || c ==# "]"
        let c = "["
    elseif c ==# "'"
        let c = "'"
    elseif c ==# '"'
        let c = '"'
    else
        return
    endif

    " Find the next opening-whatever.
    execute "normal! " . a:dir . c . "\<cr>"

    if a:motion ==# 'a'
        " If we're doing an 'around' method, we just need to select around it
        " and we can bail out to Vim.
        execute "normal! va" . c
    else
        " Otherwise we're looking at an 'inside' motion.  Unfortunately these
        " get tricky when you're dealing with an empty set of delimiters because
        " Vim does the wrong thing when you say vi(.

        let open = ''
        let close = ''

        if c ==# "(" 
            let open = "("
            let close = ")"
        elseif c ==# "{"
            let open = "{"
            let close = "}"
        elseif c ==# "["
            let open = "\\["
            let close = "\\]"
        elseif c ==# "'"
            let open = "'"
            let close = "'"
        elseif c ==# '"'
            let open = '"'
            let close = '"'
        endif

        " We'll start at the current delimiter.
        let start_pos = getpos('.')
        let start_l = start_pos[1]
        let start_c = start_pos[2]

        " Then we'll find it's matching end delimiter.
        if c ==# "'" || c ==# '"'
            " searchpairpos() doesn't work for quotes, because fuck me.
            let end_pos = searchpos(open)
        else
            let end_pos = searchpairpos(open, '', close)
        endif

        let end_l = end_pos[0]
        let end_c = end_pos[1]

        call setpos('.', start_pos)

        if start_l == end_l && start_c == (end_c - 1)
            " We're in an empty set of delimiters.  We'll append an "x"
            " character and select that so most Vim commands will do something
            " sane.  v is gonna be weird, and so is y.  Oh well.
            execute "normal! ax\<esc>\<left>"
            execute "normal! vi" . c
        elseif start_l == end_l && start_c == (end_c - 2)
            " We're on a set of delimiters that contain a single, non-newline
            " character.  We can just select that and we're done.
            execute "normal! vi" . c
        else
            " Otherwise these delimiters contain something.  But we're still not
            " sure Vim's gonna work, because if they contain nothing but
            " newlines Vim still does the wrong thing.  So we'll manually select
            " the guts ourselves.
            let whichwrap = &whichwrap
            set whichwrap+=h,l

            execute "normal! va" . c . "hol"

            let &whichwrap = whichwrap
        endif
    endif
endfunction
" }}}
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

let g:airline#extensions#syntastic#enabled = 1
" }}}
" Unite {{{
  call unite#filters#matcher_default#use(['matcher_fuzzy','matcher_regexp'])
  call unite#filters#sorter_default#use(['sorter_rank'])
  call unite#set_profile('files', 'smartcase', 1)
  call unite#custom#source('line,outline', 'matchers', 'matcher_fuzzy')
  " sort file results by length
  call unite#custom#source('file', 'sorters', 'sorter_length')
  call unite#custom#source('file_rec/async', 'sorters', 'sorter_length')
  let g:unite_enable_start_insert=0
  let g:unite_source_history_yank_enable=1
  let g:unite_source_rec_max_cache_files=5000
  let g:unite_prompt='» '
  if executable('ag')
    let g:unite_source_grep_command='ag'
    let g:unite_source_grep_default_opts='--nocolor --line-numbers --nogroup -S -C4'
    let g:unite_source_grep_recursive_opt=''
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

  nnoremap <silent> <C-m>    :<C-u>Unite -auto-preview -buffer-name=recent file_mru<cr>
  nnoremap <silent> <SPACE>y :<C-u>Unite -buffer-name=yanks history/yank<cr>
  nnoremap <silent> <SPACE>l :<C-u>Unite -start-insert -auto-resize -buffer-name=line line<cr>
  nnoremap <silent> <SPACE>b :<C-u>Unite -auto-resize -buffer-name=buffers buffer<cr>
  nnoremap <silent> <SPACE>/ :<C-u>Unite -no-quit -buffer-name=search grep:.<cr>
  nnoremap <silent> <SPACE>m :<C-u>Unite -auto-resize -buffer-name=mappings mapping<cr>
  nnoremap <silent> <SPACE>s :<C-u>Unite -quick-match buffer<cr>
  nnoremap <silent> <C-p>    :<C-u>Unite -start-insert file_rec/async<CR>
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
" Markdown {{{
let g:vim_markdown_folding_disabled=1
" }}}
" tComment {{{
nmap <leader>c <C-_><C-_>
" }}}
" Neo Complete {{{
let g:neocomplete#enable_at_startup = 1
let g:neocomplet#enable_smart_case = 1
let g:jedi#auto_vim_configuration = 0
let g:jedi#completions_enabled = 0
let g:marching_enable_neocomplete = 1

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
let g:Tex_ViewRule_pdf = 'open -a Preview'
" let g:Tex_ViewRule_pdf = 'open -a /Applications/TeX/TeXShop.app'

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
" Jedi {{{
let g:jedi#auto_vim_configuration=0
" }}}

" Load local vimrc
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

