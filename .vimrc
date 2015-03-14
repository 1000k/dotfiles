" ----------------
" NeoBudle initialization
"
" run at first time: `vim +NeoBundleInstall +qall`
" see: https://github.com/Shougo/neobundle.vim
" ----------------
" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

" Finder
NeoBundle 'scrooloose/nerdtree'

" Toggle On/Off of multiple line comments
NeoBundle 'tomtom/tcomment_vim'

" Highlight trailing whitespaces
" (to clean extra whitespace, call `:StripWhitespace`)
NeoBundle 'ntpeters/vim-better-whitespace'

" Add 'end' keyword automatically
NeoBundle 'tpope/vim-endwise'

" Highlight indent
NeoBundle 'nathanaelkane/vim-indent-guides'
let g:indent_guides_enable_no_vim_startup = 1

" Add closing brace automatically
NeoBundle 'Townk/vim-autoclose'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck


" ----------------
" General
" ----------------
" enable syntax highlight
syntax enable

" show line number
set number

" set paste mode
set paste

" visualize tab, space, line break
set list
set listchars=tab:\|-,trail:_,extends:>,precedes:<,nbsp:%

" highlight zenkaku space
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
endfunction

if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd ColorScheme * call ZenkakuSpace()
    autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
  augroup END
  call ZenkakuSpace()
endif

" set tab width
set ts=4 sw=4 sts=0

" Soft indent (use space not tab)
set expandtab

" enable auto indentation
set autoindent
set smartindent
set cindent

" highlight pair of braces
set showmatch

" enable incremental search
set incsearch

" ignore cases on search
set smartcase

" customize status line
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2

" Recover last cursor position
if has("autocmd")
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif


