" ~/.dotfiles/vim/sessions/quadcopter.vim:
" Vim session script.
" Created by session.vim 2.6.1 on 27 juli 2014 at 20:08:24.
" Open this file in Vim and run :source % to restore your session.

if exists('g:syntax_on') != 1 | syntax on | endif
if exists('g:did_load_filetypes') != 1 | filetype on | endif
if exists('g:did_load_ftplugin') != 1 | filetype plugin on | endif
if exists('g:did_indent_on') != 1 | filetype indent on | endif
if &background != 'light'
	set background=light
endif
if !exists('g:colors_name') || g:colors_name != 'hybrid' | colorscheme hybrid | endif
call setqflist([{'lnum': 1217, 'col': 6, 'valid': 1, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'STM32F3-Discovery_FW_V1.1.0/Libraries/STM32F30x_StdPeriph_Driver/inc/stm32f30x_tim.h', 'text': 'void TIM_SetCompare1(TIM_TypeDef* TIMx, uint32_t Compare1);'}, {'lnum': 1275, 'col': 6, 'valid': 1, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'STM32F3-Discovery_FW_V1.1.0/Libraries/STM32F30x_StdPeriph_Driver/src/stm32f30x_tim.c', 'text': 'void TIM_SetCompare1(TIM_TypeDef* TIMx, uint32_t Compare1)'}])
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
badd +39 source/motors.c
badd +0 source/motors.h
badd +293 STM32F3-Discovery_FW_V1.1.0/Libraries/STM32F30x_StdPeriph_Driver/inc/stm32f30x_gpio.h
badd +67 STM32F3-Discovery_FW_V1.1.0/Libraries/STM32F30x_StdPeriph_Driver/inc/stm32f30x_tim.h
badd +43 source/Makefile
badd +1276 STM32F3-Discovery_FW_V1.1.0/Libraries/STM32F30x_StdPeriph_Driver/src/stm32f30x_tim.c
badd +0 source/main.c
badd +1 source/bluetooth.h
badd +1 source/bluetooth.c
" argglobal
silent! argdel *
argadd .
edit source/motors.c
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
set nosplitbelow
wincmd t
set winheight=1 winwidth=1
exe 'vert 1resize ' . ((&columns * 73 + 73) / 147)
exe 'vert 2resize ' . ((&columns * 73 + 73) / 147)
" argglobal
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
let s:l = 39 - ((20 * winheight(0) + 20) / 41)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
39
normal! 03|
lcd ~/Documents/projects/STM-Quadcopter
wincmd w
" argglobal
edit ~/Documents/projects/STM-Quadcopter/source/motors.h
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 41 - ((29 * winheight(0) + 20) / 41)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
41
normal! 0
lcd ~/Documents/projects/STM-Quadcopter
wincmd w
exe 'vert 1resize ' . ((&columns * 73 + 73) / 147)
exe 'vert 2resize ' . ((&columns * 73 + 73) / 147)
tabedit ~/Documents/projects/STM-Quadcopter/source/bluetooth.h
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
set nosplitbelow
wincmd t
set winheight=1 winwidth=1
exe 'vert 1resize ' . ((&columns * 73 + 73) / 147)
exe 'vert 2resize ' . ((&columns * 73 + 73) / 147)
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
let s:l = 1 - ((0 * winheight(0) + 20) / 41)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
lcd ~/Documents/projects/STM-Quadcopter
wincmd w
" argglobal
edit ~/Documents/projects/STM-Quadcopter/source/bluetooth.c
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
76
silent! normal! zo
let s:l = 79 - ((78 * winheight(0) + 20) / 41)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
79
normal! 0
lcd ~/Documents/projects/STM-Quadcopter
wincmd w
2wincmd w
exe 'vert 1resize ' . ((&columns * 73 + 73) / 147)
exe 'vert 2resize ' . ((&columns * 73 + 73) / 147)
tabedit ~/Documents/projects/STM-Quadcopter/source/main.c
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
20
silent! normal! zo
let s:l = 9 - ((8 * winheight(0) + 20) / 41)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
9
normal! 018|
lcd ~/Documents/projects/STM-Quadcopter
2wincmd w
tabedit ~/Documents/projects/STM-Quadcopter/source/Makefile
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
let s:l = 12 - ((5 * winheight(0) + 20) / 41)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
12
normal! 014|
lcd ~/Documents/projects/STM-Quadcopter
2wincmd w
tabnext 2
if exists('s:wipebuf')
"   silent exe 'bwipe ' . s:wipebuf
endif
" unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToOc
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save

" Support for special windows like quick-fix and plug-in windows.
" Everything down here is generated by vim-session (not supported
" by :mksession out of the box).

2wincmd w
tabnext 2
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
