" ~/.dotfiles/vim/sessions/work.vim:
" Vim session script.
" Created by session.vim 2.6.1 on 30 juli 2014 at 18:12:10.
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
call setqflist([{'lnum': 40, 'col': 5, 'valid': 1, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'source/main.c', 'text': '    USART_SendData(USART1, *str++);'}, {'lnum': 178, 'col': 9, 'valid': 1, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'source/main.c', 'text': '        USART_SendData(USART1, data[count]);'}, {'lnum': 534, 'col': 6, 'valid': 1, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'STM32F0-Discovery_FW_V1.0.0/Libraries/STM32F0xx_StdPeriph_Driver/inc/stm32f0xx_usart.h', 'text': 'void USART_SendData(USART_TypeDef* USARTx, uint16_t Data);'}, {'lnum': 864, 'col': 68, 'valid': 1, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'STM32F0-Discovery_FW_V1.0.0/Libraries/STM32F0xx_StdPeriph_Driver/src/stm32f0xx_usart.c', 'text': '         Whereas a write access to the USART_TDR can be done using USART_SendData()'}, {'lnum': 877, 'col': 6, 'valid': 1, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'STM32F0-Discovery_FW_V1.0.0/Libraries/STM32F0xx_StdPeriph_Driver/src/stm32f0xx_usart.c', 'text': 'void USART_SendData(USART_TypeDef* USARTx, uint16_t Data)'}, {'lnum': 1878, 'col': 48, 'valid': 1, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'STM32F0-Discovery_FW_V1.0.0/Libraries/STM32F0xx_StdPeriph_Driver/src/stm32f0xx_usart.c', 'text': '  *           operation to USART_TDR register (USART_SendData()).'}, {'lnum': 1879, 'col': 73, 'valid': 1, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'STM32F0-Discovery_FW_V1.0.0/Libraries/STM32F0xx_StdPeriph_Driver/src/stm32f0xx_usart.c', 'text': '  * @note     TXE flag is cleared by a write to the USART_TDR register (USART_SendData())'}, {'lnum': 1980, 'col': 56, 'valid': 1, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'STM32F0-Discovery_FW_V1.0.0/Libraries/STM32F0xx_StdPeriph_Driver/src/stm32f0xx_usart.c', 'text': '  *           a write operation to USART_TDR register (USART_SendData()).'}, {'lnum': 1982, 'col': 16, 'valid': 1, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'STM32F0-Discovery_FW_V1.0.0/Libraries/STM32F0xx_StdPeriph_Driver/src/stm32f0xx_usart.c', 'text': '  *           (USART_SendData()) or by writing 1 to the TXFRQ in the register '}])
let SessionLoad = 1
if &cp | set nocp | endif
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/Documents/UGent/Wifi-modules/controller
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +97 ~/.zshrc
badd +78 source/main.c
badd +405 STM32F0-Discovery_FW_V1.0.0/Libraries/STM32F0xx_StdPeriph_Driver/inc/stm32f0xx_usart.h
badd +901 STM32F0-Discovery_FW_V1.0.0/Libraries/STM32F0xx_StdPeriph_Driver/src/stm32f0xx_usart.c
badd +1 ~/Documents/Projects/STM-Quadrocopter/source/main.c
badd +22 ~/Documents/Projects/STM-Quadrocopter/source/motors.c
badd +28 ~/Documents/Projects/STM-Quadrocopter/source/motors.h
badd +301 ~/Documents/Projects/STM-Quadrocopter/STM32F3-Discovery_FW_V1.1.0/Libraries/STM32F30x_StdPeriph_Driver/inc/stm32f30x_gpio.h
badd +454 ~/Documents/Projects/STM-Quadrocopter/STM32F3-Discovery_FW_V1.1.0/Libraries/STM32F30x_StdPeriph_Driver/inc/stm32f30x_rcc.h
badd +89 source/stm32f0_discovery.c
badd +260 STM32F0-Discovery_FW_V1.0.0/Libraries/STM32F0xx_StdPeriph_Driver/inc/stm32f0xx_gpio.h
badd +417 STM32F0-Discovery_FW_V1.0.0/Libraries/STM32F0xx_StdPeriph_Driver/src/stm32f0xx_gpio.c
badd +371 STM32F0-Discovery_FW_V1.0.0/Libraries/CMSIS/ST/STM32F0xx/Include/stm32f0xx.h
badd +63 STM32F0-Discovery_FW_V1.0.0/Libraries/STM32F0xx_StdPeriph_Driver/inc/stm32f0xx_misc.h
badd +55 ~/Documents/UGent/Wifi-modules/config/config.py
badd +1 ~/Documents/UGent/Wifi-modules/controller
badd +104 ~/Documents/UGent/Wifi-modules/measurement
badd +31 ~/Documents/UGent/Wifi-modules/process_dlogs
badd +385 STM32F0-Discovery_FW_V1.0.0/Libraries/STM32F0xx_StdPeriph_Driver/inc/stm32f0xx_rcc.h
badd +111 source/stm32f0_discovery.h
badd +1 source/Makefile
badd +1 ~/Documents/UGent/Wifi-modules/config/xbee_config.py
" argglobal
silent! argdel *
argadd ~/Documents/UGent/Wifi-modules/controller
edit source/main.c
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
set nosplitbelow
wincmd t
set winheight=1 winwidth=1
exe 'vert 1resize ' . ((&columns * 92 + 92) / 184)
exe 'vert 2resize ' . ((&columns * 91 + 92) / 184)
" argglobal
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
41
silent! normal! zo
47
silent! normal! zo
49
silent! normal! zo
54
silent! normal! zo
58
silent! normal! zo
59
silent! normal! zo
185
silent! normal! zo
196
silent! normal! zo
197
silent! normal! zo
235
silent! normal! zo
240
silent! normal! zo
241
silent! normal! zo
64
silent! normal! zo
191
silent! normal! zo
202
silent! normal! zo
203
silent! normal! zo
241
silent! normal! zo
246
silent! normal! zo
247
silent! normal! zo
270
silent! normal! zo
let s:l = 45 - ((44 * winheight(0) + 24) / 49)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
45
normal! 0
lcd ~/Documents/UGent/Wifi-modules/controller
wincmd w
" argglobal
edit ~/Documents/UGent/Wifi-modules/controller/source/stm32f0_discovery.h
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 111 - ((5 * winheight(0) + 24) / 49)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
111
normal! 0
lcd ~/Documents/UGent/Wifi-modules/controller
wincmd w
exe 'vert 1resize ' . ((&columns * 92 + 92) / 184)
exe 'vert 2resize ' . ((&columns * 91 + 92) / 184)
tabedit ~/Documents/UGent/Wifi-modules/controller/source/Makefile
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
let s:l = 57 - ((5 * winheight(0) + 24) / 49)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
57
normal! 034|
lcd ~/Documents/UGent/Wifi-modules/controller
tabedit ~/Documents/UGent/Wifi-modules/config/xbee_config.py
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
let s:l = 74 - ((21 * winheight(0) + 24) / 49)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
74
normal! 06|
lcd ~/Documents/UGent/Wifi-modules/controller
tabedit ~/Documents/UGent/Wifi-modules/measurement
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
let s:l = 47 - ((44 * winheight(0) + 24) / 49)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
47
normal! 0
lcd ~/Documents/UGent/Wifi-modules/controller
tabedit ~/Documents/UGent/Wifi-modules/process_dlogs
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
let s:l = 97 - ((39 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
97
normal! 017|
lcd ~/Documents/UGent/Wifi-modules/controller
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

1wincmd w
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
