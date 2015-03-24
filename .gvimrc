" **NOTE**
" If using VIM Kaoriya version, remove 'vimrc' and 'gvimrc' at first

" Disable beep and flash
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

" Disable auto IME
set iminsert=0
set imsearch=-1

" IME の on/off に合わせてカーソルの色を変える
if has('multi_byte_ime')
  hi Cursor guifg=bg guibg=Green gui=NONE
  hi CursorIM guifg=NONE guibg=Red gui=NONE
endif

" Hide menu bar and toolbar
set guioptions-=m
set guioptions-=T

" use text base tabpage in gVim
set guioptions-=e

" Enable clipboard sync on Windows
set clipboard=unnamed
if has("win32")
  vnoremap <C-c> "*y
  map <S-Insert> "+gP
endif

