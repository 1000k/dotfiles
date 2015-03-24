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

NeoBundle 'Shougo/unite.vim'  " File finder
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }
NeoBundle 'Shougo/vimfiler' " Filer
NeoBundle 'Shougo/neomru.vim' " Enhance unite.vim to access to recent opened files
NeoBundle 'ntpeters/vim-better-whitespace'  " highlight trailing whitespaces
NeoBundle 'tyru/caw.vim'  " support comment out
nmap <leader>c <plug>(caw:i:toggle)
vmap <leader>c <plug>(caw:i:toggle)
NeoBundle 'nathanaelkane/vim-indent-guides' " Indent guide
NeoBundle 'tpope/vim-surround' " the plugin provied mappings to easily modify such surroundings in pairs
NeoBundle 'vim-scripts/Align'  " text formater
NeoBundle 'LeafCage/yankround.vim' " advanced YankRing
nmap p <Plug>(yankround-p)
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)
xmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)


call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck


" ----------------
" General
" ----------------

syntax enable " enable syntax highlight
set wildmenu " file name completion
set shellslash " set directory separator '/' instead of '\'
set number " show line number
set ts=2 sw=2 sts=4 " set tab width
set expandtab " Soft indent (use space not tab)
set showmatch " highlight pair of braces
set matchtime=1 " hightlight braces just a second
set matchpairs& matchpairs+=<:> " add pair of braces
set incsearch " enable incremental search
set hlsearch " highlight matched text
set smartcase " ignore cases on search
set showtabline=2 " show tab always
set cursorline " show cursorline
set encoding=utf-8 " set default character encoding
set whichwrap+=<,>,h,l,[,] " automatically wrap left and right
set colorcolumn=80 " show line ruler

" enable auto indentation
set autoindent
set smartindent
set cindent

" disable legacy backup functions (useless)
set nowritebackup
set nobackup
set noswapfile

"" set paste mode
"" *This option intercepts any other commands (like <S-Insert> as paste)*
"set paste

" enable backspace to delete any special characters
set backspace=2
set backspace=indent,eol,start

" customize status line
set statusline=[%n]\        " buffer number
set statusline+=%f\         " relative file path
set statusline+=%m\         " modifiable flag ([+]|[-])
set statusline+=%r          " read only flag
set statusline+=%<          " separator
set statusline+=%=          " align right
set statusline+=%{(&fenc!=''?&fenc:&enc)}\  " character code
set statusline+=%{&ff}\     " character code
set statusline+=%y\         " file type
set statusline+=%l/%L       " current line number / total line number
set statusline+=:%c\        " column number
set statusline+=%P\         " cursor position (%)
set laststatus=2

" set colorscheme
set t_Co=256
colorscheme molokai
let g:molokai_original=1

" visualize tab, space, line break
set list
set listchars=tab:»-,trail:_,extends:»,precedes:«,nbsp:%,eol:↲

" highlight zenkaku space
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
endfunction

if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd ColorScheme * call ZenkakuSpace()
    autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '縲')
  augroup END
  call ZenkakuSpace()
endif

" Recover last cursor position
if has("autocmd")
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif


" ----------------
" Custom tabline
" ----------------

set tabline=%!MakeTabLine()

" 各タブページのカレントバッファ名+αを表示
function! s:tabpage_label(n)
  " t:title と言う変数があったらそれを使う
  let title = gettabvar(a:n, 'title')
  if title !=# ''
    return title
  endif

  " タブページ内のバッファのリスト
  let bufnrs = tabpagebuflist(a:n)

  " カレントタブページかどうかでハイライトを切り替える
  let hi = a:n is tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'

  " バッファが複数あったらバッファ数を表示
  let no = len(bufnrs)
  if no is 1
    let no = ''
  endif
  " タブページ内に変更ありのバッファがあったら '+' を付ける
  let mod = len(filter(copy(bufnrs), 'getbufvar(v:val, "&modified")')) ? '+' : ''
  let sp = (no . mod) ==# '' ? '' : ' '  " 隙間空ける

  " カレントバッファ
  let curbufnr = bufnrs[tabpagewinnr(a:n) - 1]  " tabpagewinnr() は 1 origin
  let fname = pathshorten(bufname(curbufnr))

  let label = no . mod . sp . fname

  return '%' . a:n . 'T' . hi . label . '%T%#TabLineFill#'
endfunction

function! MakeTabLine()
  let titles = map(range(1, tabpagenr('$')), 's:tabpage_label(v:val)')
  let sep = ' | '  " タブ間の区切り
  let tabpages = join(titles, sep) . sep . '%#TabLineFill#%T'
  let info = ''  " 好きな情報を入れる
  return tabpages . '%=' . info  " タブリストを左に、情報を右に表示
endfunction


" ----------------
" 日本語対応
" ----------------
" 文字コードの自動認識
set fileencodings=iso-2022-jp,cp932,sjis,euc-jp,utf-8

if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
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
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif


" ----------------
" Custom key mappings
" ----------------
" tab operation
nnoremap tn :<C-u>tabnew<CR>
nnoremap th :<C-u>tabprevious<CR>
nnoremap tl :<C-u>tabnext<CR>
nnoremap t0 :<C-u>tabfirst<CR>
nnoremap t$ :<C-u>tablast<CR>

" stay inside bracket
imap () ()<Left>
imap [] []<Left>
imap {} {}<Left>
imap "" ""<Left>
imap '' ''<Left>

" fix vim regex dialect
nmap / /\v

" SHIFT-Insert are Paste
map <S-Insert>		"+gP
cmap <S-Insert>		"+gP+
imap <S-Insert>		<Esc>"+gP
vmap <S-Insert>		<Esc>"+gP

" ESCを二回押すことでハイライトを消す
nmap <silent> <Esc><Esc> :nohlsearch<CR>

" カーソル下の単語を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

" 検索後にジャンプした際に検索単語を画面中央に持ってくる
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz


" ----------------
" Custom commands
" ----------------
" change file encodings
command! ToUtf8 set fileencoding=utf-8
command! ToEUC set fileencoding=euc-jp
command! ToSjis set fileencoding=sjis

" change linebreak character
command! ToUnix set ff=unix


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

