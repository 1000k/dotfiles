" Enable backspace
set backspace=2
set backspace=indent,eol,start

" Set color scheme
colorscheme molokai
let g:molokai_original=1

" Disable beep and flash
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

" Disable auto IME
set iminsert=0
set imsearch=-1

