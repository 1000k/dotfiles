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
let g:unite_enable_start_insert = 1 " launch in insert mode
NeoBundle 'Shougo/neomru.vim' " Enhance unite.vim to access to recent opened files (`:Unite file_mru`)
if has('lua')
  NeoBundle 'Shougo/neocomplete.vim' " keyword completion
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_smart_case = 1

  " Plugin key-mappings.
  inoremap <expr><C-g>     neocomplete#undo_completion()
  inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
  " <CR>: close popup and save indent.
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    return neocomplete#close_popup() . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
  endfunction
  " <TAB>: completion.
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><C-y>  neocomplete#close_popup()
  inoremap <expr><C-e>  neocomplete#cancel_popup()
end
NeoBundle 'ujihisa/unite-colorscheme' " Preview color scheme (`:Unite colorscheme -auto-preview`)
NeoBundle 'ntpeters/vim-better-whitespace'  " highlight trailing whitespaces
NeoBundle 'tyru/caw.vim'  " support comment out
NeoBundle 'tpope/vim-unimpaired'  " pairs of handy bracket mappings
NeoBundle 'nathanaelkane/vim-indent-guides' " Indent guide
NeoBundle 'tpope/vim-surround' " the plugin provied mappings to easily modify such surroundings in pairs
NeoBundle 'vim-scripts/Align'  " text formater
NeoBundle 'LeafCage/yankround.vim' " advanced YankRing
NeoBundle 'itchyny/lightline.vim' " improve statusline
let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ }
NeoBundle 'terryma/vim-multiple-cursors' " multi line manupilation like Sublime text (`Ctrl+n` to launch)
NeoBundle 'thinca/vim-quickrun' " `:QuickRun {filetype}`
NeoBundle 'osyo-manga/shabadou.vim' " QuickRun snippets
NeoBundle 'osyo-manga/vim-watchdogs' " check syntax
if !exists("g:quickrun_config")
  let g:quickrun_config = {}
endif
let g:quickrun_config = {
\  "watchdogs_checker/_" : {
\  },
\}
NeoBundle 'cohama/vim-hier' " highlight error line
NeoBundle 'bpearson/vim-phpcs' " PHP CodeSniffer


call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

call watchdogs#setup(g:quickrun_config)

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
"set matchtime=1 " hightlight braces just a second
set matchpairs& matchpairs+=<:> " add pair of braces
set incsearch " enable incremental search
set hlsearch " highlight matched text
set ignorecase " ignore cases on search
set smartcase " ignore cases on search
set showtabline=2 " show tab always
set cursorline " show cursorline
set encoding=utf-8 " set default character encoding
set whichwrap+=<,>,h,l,[,] " automatically wrap left and right
set colorcolumn=80 " show line ruler
set tags+=.tags " add '.tags' as default ctags file

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
let g:molokai_original=0
colorscheme molokai

" visualize tab, space, line break
set list
set listchars=tab:▸\ ,trail:_,extends:»,precedes:«,nbsp:%,eol:↲

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

" Recover last cursor position
if has("autocmd")
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif



" ----------------
" Neat folding text
" see: http://dhruvasagar.com/2013/03/28/vim-better-foldtext
" ----------------
function! NeatFoldText() "{{{2
  let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
  let foldchar = matchstr(&fillchars, 'fold:\zs.')
  let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(foldchar, 8)
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
set foldtext=NeatFoldText()
" }}}2


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
" leader key
let mapleader = ","

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
map <S-Insert>	"+gP
"cmap <S-Insert>	"+gP+
imap <S-Insert>	<C-o>p
vmap <S-Insert>	"+gP

" bind frequently used keys to useful position
noremap <Space>h  ^
noremap <Space>l  $
nnoremap <Space>/  *

" open .vimrc
nnoremap <Space>. :<C-u>tabedit $MYVIMRC<CR>

" turn off highlight by double <Esc>
nmap <silent> <Esc><Esc> :nohlsearch<CR>

" search word under cursor by '*'
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

" redraw line to center of a cursor after search
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" select all
map <C-a> <Esc>ggVG

" cursor keys moves rows as display)
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" plugin: Unite
nnoremap [unite] <Nop>
nmap <Space>u [unite]
nnoremap <silent> [unite]b :Unite buffer<CR>
nnoremap <silent> [unite]f :Unite file_rec<CR>
nnoremap <silent> [unite]m :Unite file_mru<CR>

" plugin: caw (toggle comment out on/off)
nmap <leader>c <plug>(caw:i:toggle)
vmap <leader>c <plug>(caw:i:toggle)

" plugin: yankround
nmap p <Plug>(yankround-p)
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)
xmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)


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

