" ~/.dotfiles/vim/sessions/quadcopter.vim:
" Vim session script.
" Created by session.vim 2.4.14 on 26 juni 2014 at 18:27:48.
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
badd +45 source/sensors.c
badd +27 source/main.c
badd +81 source/bluetooth.c
badd +44 Makefile
badd +54 source/Makefile
badd +55 STM32F3-Discovery_FW_V1.1.0/Libraries/STM32F30x_StdPeriph_Driver/inc/stm32f30x_dma.h
badd +442 STM32F3-Discovery_FW_V1.1.0/Libraries/STM32F30x_StdPeriph_Driver/src/stm32f30x_dma.c
badd +1 STM32F3-Discovery_FW_V1.1.0/Utilities/STM32F3_Discovery/stm32f3_discovery.c
badd +39 STM32F3-Discovery_FW_V1.1.0/Utilities/STM32F3_Discovery/stm32f3_discovery_l3gd20.h
badd +13 source/sensors.h
badd +1 STM32F3-Discovery_FW_V1.1.0/Utilities/STM32F3_Discovery/stm32f3_discovery.h
badd +457 STM32F3-Discovery_FW_V1.1.0/Utilities/STM32F3_Discovery/stm32f3_discovery_l3gd20.c
badd +1 ~/Documents/projects/STM-Quadcopter
badd +1 source/bluetooth.h
badd +1 source/sensor_data.h
badd +1 debug/read_sensors.c
badd +1 debug/Makefile
badd +0 STM32F3-Discovery_FW_V1.1.0/Utilities/STM32F3_Discovery/stm32f3_discovery_lsm303dlhc.h
" argglobal
silent! argdel *
argadd ~/Documents/projects/STM-Quadcopter
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
exe '2resize ' . ((&lines * 35 + 35) / 70)
exe 'vert 2resize ' . ((&columns * 93 + 93) / 187)
exe '3resize ' . ((&lines * 32 + 35) / 70)
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
17
silent! normal! zo
31
silent! normal! zo
54
silent! normal! zo
let s:l = 49 - ((33 * winheight(0) + 34) / 68)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
49
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
55
normal! zc
72
normal! zc
80
silent! normal! zo
97
normal! zc
108
silent! normal! zo
let s:l = 91 - ((47 * winheight(0) + 17) / 35)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
91
normal! 018|
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
let s:l = 28 - ((2 * winheight(0) + 16) / 32)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
28
normal! 0
wincmd w
exe 'vert 1resize ' . ((&columns * 93 + 93) / 187)
exe '2resize ' . ((&lines * 35 + 35) / 70)
exe 'vert 2resize ' . ((&columns * 93 + 93) / 187)
exe '3resize ' . ((&lines * 32 + 35) / 70)
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
exe '2resize ' . ((&lines * 21 + 35) / 70)
exe 'vert 2resize ' . ((&columns * 93 + 93) / 187)
exe '3resize ' . ((&lines * 46 + 35) / 70)
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
61
silent! normal! zo
64
silent! normal! zo
61
normal! zc
let s:l = 42 - ((41 * winheight(0) + 34) / 68)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
42
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
let s:l = 63 - ((20 * winheight(0) + 10) / 21)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
63
normal! 039|
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
17
silent! normal! zo
31
silent! normal! zo
54
silent! normal! zo
let s:l = 43 - ((22 * winheight(0) + 23) / 46)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
43
normal! 033|
wincmd w
exe 'vert 1resize ' . ((&columns * 93 + 93) / 187)
exe '2resize ' . ((&lines * 21 + 35) / 70)
exe 'vert 2resize ' . ((&columns * 93 + 93) / 187)
exe '3resize ' . ((&lines * 46 + 35) / 70)
exe 'vert 3resize ' . ((&columns * 93 + 93) / 187)
tabedit debug/read_sensors.c
set splitbelow splitright
set nosplitbelow
wincmd t
set winheight=1 winwidth=1
" argglobal
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
11
silent! normal! zo
65
silent! normal! zo
71
silent! normal! zo
79
silent! normal! zo
let s:l = 76 - ((59 * winheight(0) + 34) / 68)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
76
normal! 015|
tabedit source/sensor_data.h
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
let s:l = 10 - ((9 * winheight(0) + 34) / 68)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
10
normal! 0
tabedit source/Makefile
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
let s:l = 25 - ((23 * winheight(0) + 34) / 68)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
25
normal! 017|
wincmd w
" argglobal
edit debug/Makefile
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 22 - ((21 * winheight(0) + 34) / 68)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
22
normal! 09|
wincmd w
exe 'vert 1resize ' . ((&columns * 93 + 93) / 187)
exe 'vert 2resize ' . ((&columns * 93 + 93) / 187)
tabedit STM32F3-Discovery_FW_V1.1.0/Utilities/STM32F3_Discovery/stm32f3_discovery_lsm303dlhc.h
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
let s:l = 478 - ((33 * winheight(0) + 34) / 68)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
478
normal! 0
tabnext 3
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

1wincmd w
tabnext 3
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
