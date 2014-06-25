" ~/.dotfiles/vim/sessions/quadcopter.vim:
" Vim session script.
" Created by session.vim 2.4.11 on 23 juni 2014 at 12:32:25.
" Open this file in Vim and run :source % to restore your session.

set guioptions=egm
silent! set guifont=Inconsolata\ for\ Powerline:h12
if exists('g:syntax_on') != 1 | syntax on | endif
if exists('g:did_load_filetypes') != 1 | filetype on | endif
if exists('g:did_load_ftplugin') != 1 | filetype plugin on | endif
if exists('g:did_indent_on') != 1 | filetype indent on | endif
if &background != 'dark'
	set background=dark
endif
if !exists('g:colors_name') || g:colors_name != 'hybrid' | colorscheme hybrid | endif
call setqflist([])
let SessionLoad = 1
if &cp | set nocp | endif
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/Documents/projects/STM-Quadcopter
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +40 source/main.c
badd +81 source/bluetooth.c
badd +44 Makefile
badd +19 source/Makefile
badd +55 STM32F3-Discovery_FW_V1.1.0/Libraries/STM32F30x_StdPeriph_Driver/inc/stm32f30x_dma.h
badd +1 STM32F3-Discovery_FW_V1.1.0/Libraries/STM32F30x_StdPeriph_Driver/src/stm32f30x_dma.c
badd +1 STM32F3-Discovery_FW_V1.1.0/Utilities/STM32F3_Discovery/stm32f3_discovery.c
badd +39 STM32F3-Discovery_FW_V1.1.0/Utilities/STM32F3_Discovery/stm32f3_discovery_l3gd20.h
badd +1 source/sensors.c
badd +13 source/sensors.h
badd +1 STM32F3-Discovery_FW_V1.1.0/Utilities/STM32F3_Discovery/stm32f3_discovery.h
badd +457 STM32F3-Discovery_FW_V1.1.0/Utilities/STM32F3_Discovery/stm32f3_discovery_l3gd20.c
badd +0 ./
badd +0 source/bluetooth.h
" argglobal
silent! argdel *
argadd ./
edit source/main.c
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd _ | wincmd |
split
1wincmd k
wincmd w
set nosplitbelow
wincmd t
set winheight=1 winwidth=1
exe 'vert 1resize ' . ((&columns * 93 + 93) / 187)
exe '2resize ' . ((&lines * 33 + 34) / 68)
exe 'vert 2resize ' . ((&columns * 93 + 93) / 187)
exe '3resize ' . ((&lines * 32 + 34) / 68)
exe 'vert 3resize ' . ((&columns * 93 + 93) / 187)
" argglobal
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=20
setlocal fen
14
silent! normal! zo
26
silent! normal! zo
36
silent! normal! zo
49
silent! normal! zo
let s:l = 36 - ((35 * winheight(0) + 33) / 66)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
36
normal! 0
wincmd w
" argglobal
edit source/bluetooth.c
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=3
setlocal fml=1
setlocal fdn=20
setlocal fen
14
normal! zc
55
normal! zc
72
normal! zc
80
silent! normal! zo
94
normal! zc
105
silent! normal! zo
let s:l = 85 - ((72 * winheight(0) + 16) / 33)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
85
normal! 05|
wincmd w
" argglobal
edit source/bluetooth.h
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 46 - ((7 * winheight(0) + 16) / 32)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
46
normal! 0
wincmd w
3wincmd w
exe 'vert 1resize ' . ((&columns * 93 + 93) / 187)
exe '2resize ' . ((&lines * 33 + 34) / 68)
exe 'vert 2resize ' . ((&columns * 93 + 93) / 187)
exe '3resize ' . ((&lines * 32 + 34) / 68)
exe 'vert 3resize ' . ((&columns * 93 + 93) / 187)
tabedit source/sensors.c
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd _ | wincmd |
split
1wincmd k
wincmd w
set nosplitbelow
wincmd t
set winheight=1 winwidth=1
exe 'vert 1resize ' . ((&columns * 93 + 93) / 187)
exe '2resize ' . ((&lines * 21 + 34) / 68)
exe 'vert 2resize ' . ((&columns * 93 + 93) / 187)
exe '3resize ' . ((&lines * 44 + 34) / 68)
exe 'vert 3resize ' . ((&columns * 93 + 93) / 187)
" argglobal
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 21 - ((20 * winheight(0) + 33) / 66)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
21
normal! 01|
wincmd w
" argglobal
edit source/sensors.h
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 13 - ((4 * winheight(0) + 10) / 21)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
13
normal! 027|
wincmd w
" argglobal
edit source/main.c
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=1
setlocal fml=1
setlocal fdn=20
setlocal fen
14
silent! normal! zo
26
silent! normal! zo
let s:l = 26 - ((19 * winheight(0) + 22) / 44)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
26
normal! 012|
wincmd w
3wincmd w
exe 'vert 1resize ' . ((&columns * 93 + 93) / 187)
exe '2resize ' . ((&lines * 21 + 34) / 68)
exe 'vert 2resize ' . ((&columns * 93 + 93) / 187)
exe '3resize ' . ((&lines * 44 + 34) / 68)
exe 'vert 3resize ' . ((&columns * 93 + 93) / 187)
tabedit STM32F3-Discovery_FW_V1.1.0/Libraries/STM32F30x_StdPeriph_Driver/inc/stm32f30x_dma.h
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
set nosplitbelow
wincmd t
set winheight=1 winwidth=1
exe 'vert 1resize ' . ((&columns * 93 + 93) / 187)
exe 'vert 2resize ' . ((&columns * 93 + 93) / 187)
" argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 55 - ((4 * winheight(0) + 33) / 66)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
55
normal! 091|
wincmd w
" argglobal
edit STM32F3-Discovery_FW_V1.1.0/Libraries/STM32F30x_StdPeriph_Driver/src/stm32f30x_dma.c
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
350
silent! normal! zo
417
silent! normal! zo
let s:l = 481 - ((49 * winheight(0) + 33) / 66)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
481
normal! 019|
wincmd w
3wincmd w
exe 'vert 1resize ' . ((&columns * 93 + 93) / 187)
exe 'vert 2resize ' . ((&columns * 93 + 93) / 187)
tabedit source/Makefile
set splitbelow splitright
set nosplitbelow
wincmd t
set winheight=1 winwidth=1
" argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 54 - ((53 * winheight(0) + 33) / 66)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
54
normal! 0
3wincmd w
tabnext 1
if exists('s:wipebuf')
"   silent exe 'bwipe ' . s:wipebuf
endif
" unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToO
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save

" Support for special windows like quick-fix and plug-in windows.
" Everything down here is generated by vim-session (not supported
" by :mksession out of the box).

tabnext 1
3wincmd w
if exists('s:wipebuf')
  if empty(bufname(s:wipebuf))
if !getbufvar(s:wipebuf, '&modified')
  let s:wipebuflines = getbufline(s:wipebuf, 1, '$')
  if len(s:wipebuflines) <= 1 && empty(get(s:wipebuflines, 0, ''))
    silent execute 'bwipeout' s:wipebuf
  endif
endif
  endif
endif
doautoall SessionLoadPost
unlet SessionLoad
" vim: ft=vim ro nowrap smc=128
