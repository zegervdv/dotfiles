" vim:fdm=marker:ts=2:sw=2

let s:darwin = has('mac')
let s:windows = has('win32')


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

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'


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

" Plugin settings

"
" Vinegar/NetRW
autocmd FileType netrw setl bufhidden=delete
"
augroup Chezmoi
  autocmd!
  autocmd BufWritePost ~/.local/share/chezmoi/* silent !chezmoi apply --source-path %
  autocmd BufWritePost ~/.local/share/chezmoi/.chezmoitemplates/init.lua silent !chezmoi apply --source-path ~/.local/share/chezmoi/dot_config/nvim/init.lua.tmpl
  autocmd BufWritePost ~/.local/share/chezmoi/.chezmoitemplates/config.vim silent !chezmoi apply --source-path ~/.local/share/chezmoi/dot_config/nvim/plugin/config.vim.tmpl
  autocmd BufWritePost ~/.local/share/chezmoi/dot_config/nvim/init.lua source <afile> | PackerCompile
augroup END
