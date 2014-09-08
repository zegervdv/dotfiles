" ~/.dotfiles/vim/sessions/quadcopter.vim:
" Vim session script.
" Created by session.vim 2.6.4 on 03 september 2014 at 17:47:19.
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
cd ~/Documents/Projects/STM-Quadrocopter
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +11 .
badd +252 source/sensors.c
badd +90 source/main.c
badd +47 app/main.py
badd +61 app/BluetoothThread.py
badd +0 source/sensors.h
badd +1 source/motors.c
badd +426 STM32F3-Discovery_FW_V1.1.0/Libraries/STM32F30x_StdPeriph_Driver/inc/stm32f30x_rcc.h
badd +27 README.md
badd +1014 STM32F3-Discovery_FW_V1.1.0/Libraries/STM32F30x_StdPeriph_Driver/inc/stm32f30x_tim.h
badd +349 STM32F3-Discovery_FW_V1.1.0/Libraries/STM32F30x_StdPeriph_Driver/src/stm32f30x_tim.c
badd +0 source/motors.h
badd +0 source/system.c
badd +57 source/stm32f30x_it.c
badd +522 STM32F3-Discovery_FW_V1.1.0/Libraries/STM32F30x_StdPeriph_Driver/inc/stm32f30x_adc.h
badd +694 STM32F3-Discovery_FW_V1.1.0/Libraries/STM32F30x_StdPeriph_Driver/src/stm32f30x_adc.c
badd +56 STM32F3-Discovery_FW_V1.1.0/Libraries/STM32F30x_StdPeriph_Driver/inc/stm32f30x_misc.h
badd +230 STM32F3-Discovery_FW_V1.1.0/Libraries/CMSIS/Device/ST/STM32F30x/Include/stm32f30x.h
badd +306 STM32F3-Discovery_FW_V1.1.0/Libraries/STM32F30x_StdPeriph_Driver/inc/stm32f30x_gpio.h
badd +228 STM32F3-Discovery_FW_V1.1.0/Libraries/STM32F30x_StdPeriph_Driver/src/stm32f30x_gpio.c
argglobal
silent! argdel *
argadd .
edit source/sensors.c
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd w
wincmd _ | wincmd |
split
1wincmd k
wincmd w
set nosplitbelow
wincmd t
set winheight=1 winwidth=1
exe '1resize ' . ((&lines * 24 + 25) / 51)
exe 'vert 1resize ' . ((&columns * 105 + 106) / 212)
exe '2resize ' . ((&lines * 24 + 25) / 51)
exe 'vert 2resize ' . ((&columns * 105 + 106) / 212)
exe '3resize ' . ((&lines * 24 + 25) / 51)
exe 'vert 3resize ' . ((&columns * 106 + 106) / 212)
exe '4resize ' . ((&lines * 24 + 25) / 51)
exe 'vert 4resize ' . ((&columns * 106 + 106) / 212)
argglobal
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
143
silent! normal! zo
201
silent! normal! zo
let s:l = 149 - ((5 * winheight(0) + 12) / 24)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
149
normal! 0
lcd ~/Documents/Projects/STM-Quadrocopter
wincmd w
argglobal
edit ~/Documents/Projects/STM-Quadrocopter/source/sensors.c
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
201
silent! normal! zo
let s:l = 253 - ((5 * winheight(0) + 12) / 24)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
253
normal! 039|
lcd ~/Documents/Projects/STM-Quadrocopter
wincmd w
argglobal
edit ~/Documents/Projects/STM-Quadrocopter/source/motors.h
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 13 - ((12 * winheight(0) + 12) / 24)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
13
normal! 0
lcd ~/Documents/Projects/STM-Quadrocopter
wincmd w
argglobal
edit ~/Documents/Projects/STM-Quadrocopter/source/motors.c
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 1 - ((0 * winheight(0) + 12) / 24)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
lcd ~/Documents/Projects/STM-Quadrocopter
wincmd w
2wincmd w
exe '1resize ' . ((&lines * 24 + 25) / 51)
exe 'vert 1resize ' . ((&columns * 105 + 106) / 212)
exe '2resize ' . ((&lines * 24 + 25) / 51)
exe 'vert 2resize ' . ((&columns * 105 + 106) / 212)
exe '3resize ' . ((&lines * 24 + 25) / 51)
exe 'vert 3resize ' . ((&columns * 106 + 106) / 212)
exe '4resize ' . ((&lines * 24 + 25) / 51)
exe 'vert 4resize ' . ((&columns * 106 + 106) / 212)
tabedit ~/Documents/Projects/STM-Quadrocopter/source/system.c
set splitbelow splitright
set nosplitbelow
wincmd t
set winheight=1 winwidth=1
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 30 - ((29 * winheight(0) + 24) / 49)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
30
normal! 03|
lcd ~/Documents/Projects/STM-Quadrocopter
2wincmd w
tabedit ~/Documents/Projects/STM-Quadrocopter/source/sensors.h
set splitbelow splitright
set nosplitbelow
wincmd t
set winheight=1 winwidth=1
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 1 - ((0 * winheight(0) + 24) / 49)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 029|
lcd ~/Documents/Projects/STM-Quadrocopter
2wincmd w
tabedit ~/Documents/Projects/STM-Quadrocopter/source/stm32f30x_it.c
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
set nosplitbelow
wincmd t
set winheight=1 winwidth=1
exe 'vert 1resize ' . ((&columns * 105 + 106) / 212)
exe 'vert 2resize ' . ((&columns * 106 + 106) / 212)
argglobal
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
57
silent! normal! zo
57
normal! zc
71
silent! normal! zo
let s:l = 72 - ((71 * winheight(0) + 24) / 49)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
72
normal! 023|
lcd ~/Documents/Projects/STM-Quadrocopter
wincmd w
argglobal
edit ~/Documents/Projects/STM-Quadrocopter/source/system.c
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
7
silent! normal! zo
let s:l = 1 - ((0 * winheight(0) + 24) / 49)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 01|
lcd ~/Documents/Projects/STM-Quadrocopter
wincmd w
2wincmd w
exe 'vert 1resize ' . ((&columns * 105 + 106) / 212)
exe 'vert 2resize ' . ((&columns * 106 + 106) / 212)
tabedit ~/Documents/Projects/STM-Quadrocopter/README.md
set splitbelow splitright
set nosplitbelow
wincmd t
set winheight=1 winwidth=1
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 12 - ((4 * winheight(0) + 24) / 49)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
12
normal! 07|
lcd ~/Documents/Projects/STM-Quadrocopter
2wincmd w
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

2wincmd w
tabnext 1
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
