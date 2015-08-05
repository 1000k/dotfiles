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
  hi Cursor guifg=bg guibg=White gui=NONE
  hi CursorIM guifg=NONE guibg=Cyan gui=NONE
endif

" Hide menu bar, toolbar and scroll bar
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L

" tab operation (only works in GUI because terminals don't see a difference between <Tab> and <C-Tab>)
nnoremap <C-S-Tab> :<C-u>tabprevious<CR>
nnoremap <C-Tab> :<C-u>tabnext<CR>

" use text base tabpage in gVim
set guioptions-=e

" Enable clipboard sync on Windows
set clipboard=unnamed
if has("win32")
  vnoremap <C-c> "*y
endif

" set font
if has("win32")
  set guifont=MeiryoKe_Gothic:h13
  set guifontwide=MeiryoKe_Gothic:h13
endif


" If starting gvim && arguments were given
" (assuming double-click on file explorer)
" see: http://tyru.hatenablog.com/entry/20130430/vim_resident
if has('gui_running') && argc()
  let s:running_vim_list = filter(
  \   split(serverlist(), '\n'),
  \   'v:val !=? v:servername')
  " If one or more Vim instances are running
  if !empty(s:running_vim_list)
    " Open given files in running Vim and exit.
    silent execute '!start gvim'
    \  '--servername' s:running_vim_list[0]
    \  '--remote-tab-silent' join(argv(), ' ')
    qa!
  endif
  unlet s:running_vim_list
endif


