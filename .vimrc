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

" enable backspace
set backspace=2
set backspace=indent,eol,start

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
    autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', 'ã€€')
  augroup END
  call ZenkakuSpace()
endif

" set tab width
set ts=2 sw=2 sts=4

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
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set statusline=[%n]\        " buffer number
set statusline+=%f\         " relative file path
set statusline+=%m\         " fixable flag ([+]|[-])
set statusline+=%r          " read only flag
set statusline+=%<          " separator
set statusline+=%=          " align right
set statusline+=%{'['.(&fenc!=''?&fenc:'?').'-'.&ff.']'}\   " format & character code
set statusline+=%y\         " file type
set statusline+=%4l/%L      " current row / total row
set statusline+=,%3c\       " current column
set statusline+=%3p%%\      " cursor position (%)
set laststatus=2

" show tab always
set showtabline=2

" show cursor
set cursorline

" set colorscheme
set t_Co=256
colorscheme molokai
let g:molokai_original=1

" Recover last cursor position
if has("autocmd")
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif


" ----------------
" “ú–{Œê‘Î‰
" ----------------
" •¶šƒR[ƒh‚Ì©“®”F¯
set fileencodings=iso-2022-jp,cp932,sjis,euc-jp,utf-8

if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconv‚ªeucJP-ms‚É‘Î‰‚µ‚Ä‚¢‚é‚©‚ğƒ`ƒFƒbƒN
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconv‚ªJISX0213‚É‘Î‰‚µ‚Ä‚¢‚é‚©‚ğƒ`ƒFƒbƒN
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodings‚ğ\’z
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " ’è”‚ğˆ•ª
  unlet s:enc_euc
  unlet s:enc_jis
endif
" “ú–{Œê‚ğŠÜ‚Ü‚È‚¢ê‡‚Í fileencoding ‚É encoding ‚ğg‚¤‚æ‚¤‚É‚·‚é
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" ‰üsƒR[ƒh‚Ì©“®”F¯
set fileformats=unix,dos,mac
"  ‚Æ‚©›‚Ì•¶š‚ª‚ ‚Á‚Ä‚àƒJ[ƒ\ƒ‹ˆÊ’u‚ª‚¸‚ê‚È‚¢‚æ‚¤‚É‚·‚é
if exists('&ambiwidth')
  set ambiwidth=double
endif

" ----------------
" Custom key mappings
" ----------------
" TODO

" ----------------
" Custom commands
" ----------------
" TODO


" ----------------
" Load conf.d
" ----------------
set runtimepath+=$HOME/.vim/
runtime! conf.d/*.vim


" ----------------
" Reload .vimrc after save
" ----------------
augroup reload_vimrc " {
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

