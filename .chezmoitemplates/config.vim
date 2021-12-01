" vim:fdm=marker:ts=2:sw=2

let s:darwin = has('mac')
let s:windows = has('win32')

" Activate built in plugins
if !has('nvim')
  if has('packages')
    packadd! matchit
    packadd! shellmenu
  endif
endif
source $VIMRUNTIME/ftplugin/man.vim

packadd vim-dirvish

if has("nvim")
  let g:python3_host_prog=expand('$HOME/.config/virtualenvs/python3/bin/python')
  let g:python_host_prog=expand('$HOME/.config/virtualenvs/python2/bin/python')
endif
"

" General Settings and options

if !s:windows
  if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
  endif
  if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
  endif
end

if v:version >= 703
  if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
  endif
endif

"

" Mappings
" Set leader to spacebar
map <space> <leader>

" See long lines as line breaks
noremap <expr> j (v:count? 'j' : 'gj')
noremap <expr> k (v:count? 'k' : 'gk')

" Remap tag-search to better place
nnoremap <C-$> g<C-]>
nnoremap <C-w>y <C-w>g<C-]>

nnoremap <C-s> <C-e>

" Move while in insert mode
inoremap <C-f> <right>

" Switch between the last two files
" nnoremap <space><space> <C-^>

" " Very Magic search patterns
nnoremap / /\v
vnoremap / /\v

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Search for beginning of command
cnoremap <c-n>  <down>
cnoremap <c-p>  <up>

" Move whole lines
nnoremap [e  :<c-u>execute 'move -1-'. v:count1<cr>
nnoremap ]e  :<c-u>execute 'move +'. v:count1<cr>

" Insert empty lines
nnoremap [<space>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap ]<space>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>

" Clear highlight
nnoremap <silent><leader>l :noh<CR>

inoremap £ \

" Highlight last inserted text
nnoremap gV `[v`]

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Use backspace as delete in visual mode
vmap <BS> x

" Redraw screen
nnoremap <F3> :redraw!<CR>

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

" Swap backticks and quotes
nnoremap ` '
nnoremap ' `

" Do not move on *
nnoremap <silent> * :let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

xnoremap <silent> p p:if v:register == '"'<Bar>let @@=@0<Bar>endif<CR>

" Error navigation
nnoremap <UP> :cprev<CR>
nnoremap <DOWN> :cnext<CR>
nnoremap <RIGHT> :cnf<CR>
nnoremap <LEFT> :cpf<CR>

nnoremap <leader>y :ptjump <c-r><c-w><CR>

if has('nvim')
  tnoremap <C-h> <C-\><C-n><C-w>h
  tnoremap <C-j> <C-\><C-n><C-w>j
  tnoremap <C-k> <C-\><C-n><C-w>k
  tnoremap <C-l> <C-\><C-n><C-w>l
  augroup enter_term
    au!
    autocmd TermOpen * startinsert!
    autocmd BufEnter * if &buftype ==# 'terminal' | :startinsert! | endif
    autocmd BufLeave * if &buftype ==# 'terminal' | :stopinsert! | endif
  augroup END
  let $GIT_EDITOR = 'nvr -cc split --remote-wait'
endif

"

" Functions
" When editing a file, always jump to the last known cursor position.
" Don't do it for commit messages, when the position is invalid, or when
" inside an event handler (happens when dropping a file on gvim).
autocmd BufReadPost *
      \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif


" Detect Filetype from content if file has no extension
augroup newFileDetection
  au!
  autocmd CursorMovedI * call CheckFileType()
augroup END

function! CheckFileType()
  if exists("b:countCheck") == 0
    let b:countCheck = 0
  endif
  let b:countCheck += 1
  if &filetype == "" && b:countCheck > 20 && b:countCheck < 200
    filetype detect
    " Delete the function if no filetype can be established, or the type has
    " been found
  elseif b:countCheck >= 200 || &filetype != ""
    autocmd! newFileDetection
  endif
endfunction
"

" Convert hex <-> decimal
command! -nargs=? -range Dec2hex call s:Dec2hex(<line1>, <line2>, '<args>')
function! s:Dec2hex(line1, line2, arg) range
  if empty(a:arg)
    if histget(':', -1) =~# "^'<,'>" && visualmode() !=# 'V'
      let cmd = 's/\%V\<\d\+\>/\=printf("0x%x",submatch(0)+0)/g'
    else
      let cmd = 's/\<\d\+\>/\=printf("0x%x",submatch(0)+0)/g'
    endif
    try
      execute a:line1 . ',' . a:line2 . cmd
    catch
      echo 'Error: No decimal number found'
    endtry
  else
    echo printf('%x', a:arg + 0)
  endif
endfunction

command! -nargs=? -range Hex2dec call s:Hex2dec(<line1>, <line2>, '<args>')
function! s:Hex2dec(line1, line2, arg) range
  if empty(a:arg)
    if histget(':', -1) =~# "^'<,'>" && visualmode() !=# 'V'
      let cmd = 's/\%V0x\x\+/\=submatch(0)+0/g'
    else
      let cmd = 's/0x\x\+/\=submatch(0)+0/g'
    endif
    try
      execute a:line1 . ',' . a:line2 . cmd
    catch
      echo 'Error: No hex number starting "0x" found'
    endtry
  else
    echo (a:arg =~? '^0x') ? a:arg + 0 : ('0x'.a:arg) + 0
  endif
endfunction
"

" Recognize filetype for dup files
autocmd! BufRead *.dup call DupSetSyntax(@%)

function! DupSetSyntax(name)
  let extension = matchlist(a:name, '\v.+.\.([^\.]+).dup')[1]
  if extension == "vhd"
    setlocal filetype=vhdl
  elseif extension == "v"
    setlocal filetype=verilog
  elseif extension == "sv"
    setlocal filetype=verilog
  else
    echo "Unknown filetype"
  endif
endfunction
"

" Create arguments list from files in quickfix list
" Allows to Grep for a pattern and apply an argdo command on each of the
" matching files
command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
function! QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction
"

augroup mark_files
  au!
  au BufLeave test.tcl mark T
  au BufLeave case.do mark C
  au BufLeave drv_*.tcl mark D
  au BufLeave *.rtl.vhd mark R
augroup END


" Toggle between opening/closing the quickfix window
function! GetBufferList()
  redir =>buflist
  silent! ls!
  redir END
  return buflist
endfunction

function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
    echohl ErrorMsg
    echo "Location List is Empty."
    return
  endif
  let winnr = winnr()
  exec('botright '.a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction

nnoremap <silent> <F10> :call ToggleList("Quickfix List", 'c')<CR>
"


" Make list-like commands more intuitive
" Copied from https://gist.github.com/romainl/047aca21e338df7ccf771f96858edb86
function! CCR()
    let cmdline = getcmdline()
    if cmdline =~ '\v\C^(ls|files|buffers)'
        " like :ls but prompts for a buffer command
        return "\<CR>:b"
    elseif cmdline =~ '\v\C/(#|nu|num|numb|numbe|number)$'
        " like :g//# but prompts for a command
        return "\<CR>:"
    elseif cmdline =~ '\v\C^(dli|il)'
        " like :dlist or :ilist but prompts for a count for :djump or :ijump
        return "\<CR>:" . cmdline[0] . "j  " . split(cmdline, " ")[1] . "\<S-Left>\<Left>"
    elseif cmdline =~ '\v\C^(cli|lli)'
        " like :clist or :llist but prompts for an error/location number
        return "\<CR>:sil " . repeat(cmdline[0], 2) . "\<Space>"
    elseif cmdline =~ '\C^old'
        " like :oldfiles but prompts for an old file to edit
        set nomore
        return "\<CR>:sil se more|e #<"
    elseif cmdline =~ '\C^changes'
        " like :changes but prompts for a change to jump to
        set nomore
        return "\<CR>:sil se more|norm! g;\<S-Left>"
    elseif cmdline =~ '\C^ju'
        " like :jumps but prompts for a position to jump to
        set nomore
        return "\<CR>:sil se more|norm! \<C-o>\<S-Left>"
    elseif cmdline =~ '\C^marks'
        " like :marks but prompts for a mark to jump to
        return "\<CR>:norm! `"
    elseif cmdline =~ '\C^undol'
        " like :undolist but prompts for a change to undo
        return "\<CR>:u "
    else
        return "\<CR>"
    endif
endfunction
cnoremap <expr> <CR> CCR()
"

" Text objects
function! s:inIndentation()
  " select all text in current indentation level excluding any empty lines
  " that precede or follow the current indentationt level;
  "
  " the current implementation is pretty fast, even for many lines since it
  " uses "search()" with "\%v" to find the unindented levels
  "
  " NOTE: if the current level of indentation is 1 (ie in virtual column 1),
  "       then the entire buffer will be selected
  "
  " WARNING: python devs have been known to become addicted to this
  " magic is needed for this
  let l:magic = &magic
  set magic

  " move to beginning of line and get virtcol (current indentation level)
  " BRAM: there is no searchpairvirtpos() ;)
  normal! ^
  let l:vCol = virtcol(getline('.') =~# '^\s*$' ? '$' : '.')

  " pattern matching anything except empty lines and lines with recorded
  " indentation level
  let l:pat = '^\(\s*\%'.l:vCol.'v\|^$\)\@!'

  " find first match (backwards & don't wrap or move cursor)
  let l:start = search(l:pat, 'bWn') + 1

  " next, find first match (forwards & don't wrap or move cursor)
  let l:end = search(l:pat, 'Wn')

  if (l:end !=# 0)
    " if search succeeded, it went too far, so subtract 1
    let l:end -= 1
  endif

  " go to start (this includes empty lines) and--importantly--column 0
  execute 'normal! '.l:start.'G0'

  " skip empty lines (unless already on one .. need to be in column 0)
  call search('^[^\n\r]', 'Wc')

  " go to end (this includes empty lines)
  execute 'normal! Vo'.l:end.'G'

  " skip backwards to last selected non-empty line
  call search('^[^\n\r]', 'bWc')

  " go to end-of-line 'cause why not
  normal! $o

  " restore magic
  let &magic = l:magic
endfunction

" "in indentation" (indentation level sans any surrounding empty lines)
xnoremap <silent> ii :<c-u>call <sid>inIndentation()<cr>
onoremap <silent> ii :<c-u>call <sid>inIndentation()<cr>

function! s:aroundIndentation()
  " select all text in the current indentation level including any emtpy
  " lines that precede or follow the current indentation level;
  "
  " the current implementation is pretty fast, even for many lines since it
  " uses "search()" with "\%v" to find the unindented levels
  "
  " NOTE: if the current level of indentation is 1 (ie in virtual column 1),
  "       then the entire buffer will be selected
  "
  " WARNING: python devs have been known to become addicted to this

  " magic is needed for this (/\v doesn't seem work)
  let l:magic = &magic
  set magic

  " move to beginning of line and get virtcol (current indentation level)
  " BRAM: there is no searchpairvirtpos() ;)
  normal! ^
  let l:vCol = virtcol(getline('.') =~# '^\s*$' ? '$' : '.')

  " pattern matching anything except empty lines and lines with recorded
  " indentation level
  let l:pat = '^\(\s*\%'.l:vCol.'v\|^$\)\@!'

  " find first match (backwards & don't wrap or move cursor)
  let l:start = search(l:pat, 'bWn') + 1

  " NOTE: if l:start is 0, then search() failed; otherwise search() succeeded
  "       and l:start does not equal line('.')
  " FORMER: l:start is 0; so, if we add 1 to l:start, then it will match
  "         everything from beginning of the buffer (if you don't like
  "         this, then you can modify the code) since this will be the
  "         equivalent of "norm! 1G" below
  " LATTER: l:start is not 0 but is also not equal to line('.'); therefore,
  "         we want to add one to l:start since it will always match one
  "         line too high if search() succeeds

  " next, find first match (forwards & don't wrap or move cursor)
  let l:end = search(l:pat, 'Wn')

  " NOTE: if l:end is 0, then search() failed; otherwise, if l:end is not
  "       equal to line('.'), then the search succeeded.
  " FORMER: l:end is 0; we want this to match until the end-of-buffer if it
  "         fails to find a match for same reason as mentioned above;
  "         again, modify code if you do not like this); therefore, keep
  "         0--see "NOTE:" below inside the if block comment
  " LATTER: l:end is not 0, so the search() must have succeeded, which means
  "         that l:end will match a different line than line('.')

  if (l:end !=# 0)
    " if l:end is 0, then the search() failed; if we subtract 1, then it
    " will effectively do "norm! -1G" which is definitely not what is
    " desired for probably every circumstance; therefore, only subtract one
    " if the search() succeeded since this means that it will match at least
    " one line too far down
    " NOTE: exec "norm! 0G" still goes to end-of-buffer just like "norm! G",
    "       so it's ok if l:end is kept as 0. As mentioned above, this means
    "       that it will match until end of buffer, but that is what I want
    "       anyway (change code if you don't want)
    let l:end -= 1
  endif

  " finally, select from l:start to l:end
  execute 'normal! '.l:start.'G0V'.l:end.'G$o'

  " restore magic
  let &magic = l:magic
endfunction

" "around indentation" (indentation level and any surrounding empty lines)
xnoremap <silent> ai :<c-u>call <sid>aroundIndentation()<cr>
onoremap <silent> ai :<c-u>call <sid>aroundIndentation()<cr>
"
"

" Filetype specific settings
" Text
augroup ft_text
  au!
  " au BufNewFile,BufRead,BufEnter *.txt setlocal spell spelllang=en_gb
  au BufNewFile,BufRead,BufEnter *.txt setlocal textwidth=0
augroup END
augroup ft_report
  au!
  au BufNewFile,BufRead,BufEnter *.rpt setlocal nowrap
  au BufNewFile,BufRead,BufEnter *.rpt call ColorRpt()
  au BufNewFile,BufRead,BufEnter *.log call ColorRpt()
augroup END

function! ColorRpt()
  " Color numbers based on length
  syn match String "\v<\d{1,3}>"
  syn match Number "\v<\d{4,6}>"
  syn match Statement "\v<\d{7,9}>"

  " Color errors
  syn match Error "\v^ERROR:.*$"
endfunction
"
" Git commit messages
augroup ft_git
  au!
  au FileType gitcommit setlocal spell spelllang=en_gb
  autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete
augroup END
"
" Ruby
augroup ft_ruby
  au!
  autocmd BufRead *_spec.rb set filetype=rspec
augroup END
"
" Matlab
augroup ft_matlab
  au!
  autocmd FileType matlab setlocal commentstring=\%\ %s
augroup END
"
" C
augroup ft_c
  au!
  au FileType c setlocal foldmethod=syntax
augroup END
"
" TCL

augroup ft_tcl
  au!
  autocmd FileType tcl setlocal commentstring=#\ %s
  " autocmd FileType tcl compiler nagelfar
  autocmd BufRead *.do set filetype=tcl
  autocmd BufRead *.hal set filetype=tcl
  autocmd FileType tcl setlocal iskeyword+=:
  autocmd FileType tcl setlocal breakat-=:
  autocmd FileType tcl setlocal suffixesadd+=.tcl,.do
augroup END
" shortcuts
iabbrev procargs array set arg [::argument_processing::proces_arguments $args];
"
" GPG
" Don't save backups of gpg asc files
set backupskip+=*.asc

" Convenient editing of ascii-armoured encrypted files
augroup GPGASCII
  au!
  au BufReadPost *.asc :%!gpg -q -d
  au BufReadPost *.asc |redraw
  au BufWritePre *.asc :%!gpg -q -e -a
  au BufWritePost *.asc u
  au VimLeave *.asc :!clear
augroup END
"
" System Verilog
augroup ft_systemverilog
  au!
  au FileType systemverilog setlocal suffixesadd+=.sv,.v
  au FileType systemverilog setlocal foldmethod=expr
  au FileType systemverilog,verilog call SVAlign()
  au FileType systemverilog,verilog let b:delimitMate_quotes = "\""
  au FileType systemverilog,verilog setlocal iskeyword+='
augroup END

function! SVAlign()
  let g:easy_align_delimiters = {
        \  ')': { 'pattern': '[()]', 'left_margin': 0, 'right_margin': 0, 'stick_to_left': 0}
        \}
endfunction
"
" Make
augroup ft_make
  autocmd!
  autocmd BufEnter *.make setlocal filetype=make
  autocmd FileType make setlocal noexpandtab
augroup END
" JSON
augroup ft_json
  autocmd!
  autocmd FileType json setlocal equalprg=jq
augroup END
"
"
" Python
augroup f_python
  autocmd!
  autocmd FileType python setlocal shiftwidth=4
  au FileType python setlocal formatprg=autopep8\ -
  autocmd FileType python setlocal path-=**
  autocmd Filetype python let b:delimitMate_nesting_quotes = ['"', "'"]
augroup END

let g:python_highlight_all=1
"
"

" Plugin settings
" Gundo tree
nnoremap <leader>u :GundoToggle<CR>
"
" Projectionist
let g:projectionist_heuristics = {
      \ "*.c": {
      \   "*.c": {
      \     "alternate": "{}.h",
      \     "type": "source",
      \     "template": ["#include \"{}.h\""],
      \     "make": "make -wC {project}"
      \   },
      \   "*.h": {
      \     "alternate": "{}.c",
      \     "type": "header",
      \     "template": ["#ifndef {uppercase}_H", "#define {uppercase}_H", "", "#endif"]
      \   },
      \   "Makefile": {"type": "makefile"},
      \ },
      \ "*.py": {
      \   "*.py": { "make": "ipython {}" }
      \ },
      \ }
"
" Grep
let g:grepper = {
      \ 'tools': ['ag', 'hg'],
      \ 'highlight': 1,
      \ 'ag': {
      \  'grepprg': 'rg --vimgrep',
      \ }}

nnoremap gs <plug>(GrepperOperator)
xnoremap gs <plug>(GrepperOperator)


command! -nargs=* -complete=file Ag Grepper -noprompt -tool ag -grepprg rg --vimgrep <args>
"
" Vinegar/NetRW
autocmd FileType netrw setl bufhidden=delete
"

function! SendOSCClipboard(lines, regtype)
   call SendViaOSC52(join(a:lines, "\n"))
endfunction

let g:clipboard = {
      \   'name': 'TMUX',
      \   'copy': {
      \      '+': function('SendOSCClipboard'),
      \      '*': 'tmux load-buffer -',
      \    },
      \   'paste': {
      \      '+': 'tmux save-buffer -',
      \      '*': 'tmux save-buffer -',
      \   },
      \   'cache_enabled': 1,
      \ }
" Load local vimrc
if filereadable($HOME . '/.vimrc.local')
  source ~/.vimrc.local
endif

" Load project local vimrc
if filereadable('.vimrc.local')
  source .vimrc.local
endif

augroup Chezmoi
  autocmd!
  autocmd BufWritePost ~/.local/share/chezmoi/* silent !chezmoi apply --source-path %
  autocmd BufWritePost ~/.local/share/chezmoi/.chezmoitemplates/init.lua silent !chezmoi apply --source-path ~/.local/share/chezmoi/dot_config/nvim/init.lua.tmpl
  autocmd BufWritePost ~/.local/share/chezmoi/.chezmoitemplates/config.vim silent !chezmoi apply --source-path ~/.local/share/chezmoi/dot_config/nvim/plugin/config.vim.tmpl
  autocmd BufWritePost ~/.local/share/chezmoi/dot_config/nvim/init.lua source <afile> | PackerCompile
augroup END
