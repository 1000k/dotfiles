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
let g:unite_enable_start_insert = 1 " launch in insert mode
NeoBundle 'Shougo/vimproc.vim', {
\  'build' : {
\    'windows' : 'tools\\update-dll-mingw',
\    'cygwin'  : 'make -f make_cygwin.mak',
\    'mac'     : 'make -f make_mac.mak',
\    'linux'   : 'make',
\    'unix'    : 'gmake',
\    },
\  }

" Filer
NeoBundle 'Shougo/vimfiler'
let g:vimfiler_as_default_explorer = 1 " use VimFiler instead of netrw
let g:vimfiler_safe_mode_by_default = 0 " start with safe mode = off

" Enhance unite.vim to access to recent opened files (`:Unite file_mru`)
NeoBundle 'Shougo/neomru.vim'
if has('lua')
  NeoBundle 'Shougo/neocomplete.vim' " keyword completion
  " Disable AutoComplPop.
  let g:acp_enableAtStartup = 0
  " Use neocomplete.
  let g:neocomplete#enable_at_startup = 1
  " Use smartcase.
  let g:neocomplete#enable_smart_case = 1
  " Set minimum syntax keyword length.
  let g:neocomplete#sources#syntax#min_keyword_length = 3
  let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

  " Define dictionary.
  let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
  \ }
  " Enable omni completion.
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

  " Enable heavy omni completion.
  if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
  endif

  " Recommended key-mappings.
  " <CR>: close popup and save indent.
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    "return neocomplete#close_popup() . "\<CR>"
    " For no inserting <CR> key.
    return pumvisible() ? neocomplete#close_popup() : "\<CR>"
  endfunction
  " <TAB>: completion.
  " inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><C-y>  neocomplete#close_popup()
  inoremap <expr><C-e>  neocomplete#cancel_popup()
end


" add snippet support
NeoBundle 'Shougo/neosnippet'

" default snippets for neosnippet
NeoBundle 'Shougo/neosnippet-snippets'

" extra snippets
NeoBundle 'honza/vim-snippets'
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
" SuperTab like snippets behavior.
" imap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
imap <expr><TAB> pumvisible() ? "\<C-n>" : neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1
" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'


" Preview color scheme (`:Unite colorscheme -auto-preview`)
NeoBundle 'ujihisa/unite-colorscheme'

" highlight trailing whitespaces
NeoBundle 'ntpeters/vim-better-whitespace'

" support comment out
NeoBundle 'tyru/caw.vim'

" pairs of handy bracket mappings
NeoBundle 'tpope/vim-unimpaired'

" Indent guide
NeoBundle 'nathanaelkane/vim-indent-guides'
let g:indent_guides_enable_on_vim_startup=1

" the plugin provied mappings to easily modify such surroundings in pairs
NeoBundle 'tpope/vim-surround'

" text formater
NeoBundle 'vim-scripts/Align'

" advanced YankRing
NeoBundle 'LeafCage/yankround.vim'

" show quickfix contents in status line
NeoBundle 'KazuakiM/vim-qfstatusline'

" improve statusline
NeoBundle 'itchyny/lightline.vim'
let g:lightline = {
\  'active': {
\    'right': [ [ 'qfstatusline', 'lineinfo' ], [ 'percent' ], [ 'fileformat', 'fileencoding', 'filetype' ] ],
\  },
\  'component_expand': {
\    'qfstatusline': 'qfstatusline#Update',
\  },
\  'component_type': {
\    'qfstatusline': 'error',
\  },
\}
let g:Qfstatusline#UpdateCmd = function('lightline#update') " update lightline after :WatchdogsRun

" multi line manupilation like Sublime text (`Ctrl+n` to launch)
NeoBundle 'terryma/vim-multiple-cursors'
" prevent conflict with Neocomplete
function! Multiple_cursors_before()
  if exists(':NeoCompleteLock')==2
    exe 'NeoCompleteLock'
  endif
endfunction
function! Multiple_cursors_after()
  if exists(':NeoCompleteUnlock')==2
    exe 'NeoCompleteUnlock'
  endif
endfunction

" show syntax errors in status line
NeoBundle 'dannyob/quickfixstatus'

" `:QuickRun {filetype}`
NeoBundle 'thinca/vim-quickrun'
let g:quickrun_config = {
\  '*': { 'split' : '' },
\  '_': {
\    'runner': 'vimproc',
\    'runner/vimproc/updatetime' : 10,
\    'hook/unite_quickfix/enable' : 0,
\    'hook/echo/enable' : 0,
\    'hook/back_buffer/enable' : 0,
\    'hook/close_unite_quickfix/enable' : 0,
\    'hook/close_buffer/enable_exit' : 0,
\    'hook/close_quickfix/enable_exit' : 1,
\    'hook/redraw_unite_quickfix/enable_exit' : 0,
\    'hook/close_unite_quickfix/enable_exit' : 1,
\    'outputter/quickfix/open_cmd' : '',
\    'hook/qfstatusline_update/enable_exit' : 1,
\    'hook/qfstatusline_update/priority_exit' : 4,
\  }
\}

" QuickRun snippets
NeoBundle 'osyo-manga/shabadou.vim'

" check syntax
NeoBundle 'osyo-manga/vim-watchdogs'

" highlight error line
NeoBundle 'cohama/vim-hier'

" Git wrapper
NeoBundle 'tpope/vim-fugitive'

" add cloes chars automatically
NeoBundle 'townk/vim-autoclose'

" JSON formatter (type `gqij` or `gqaj` to pretty format)
NeoBundle 'tpope/vim-jdaddy.git'

" create Ctags file automatically
NeoBundleLazy 'alpaca-tc/alpaca_tags', {
\  'depends': ['Shougo/vimproc'],
\  'autoload' : {
\     'commands' : [
\        { 'name' : 'AlpacaTagsBundle', 'complete': 'customlist,alpaca_tags#complete_source' },
\        { 'name' : 'AlpacaTagsUpdate', 'complete': 'customlist,alpaca_tags#complete_source' },
\        'AlpacaTagsSet', 'AlpacaTagsCleanCache', 'AlpacaTagsEnable', 'AlpacaTagsDisable', 'AlpacaTagsKillProcess', 'AlpacaTagsProcessStatus',
\     ],
\  }
\}
let g:alpaca_tags#config = {
\  '_' : '-R --sort=yes',
\  'ruby': '--languages=+Ruby',
\  'php': '--languages=+php',
\}
augroup AlpacaTags
  autocmd!
  if exists(':AlpacaTags')
    autocmd BufWritePost Gemfile AlpacaTagsBundle
    autocmd BufEnter * AlpacaTagsSet
    autocmd BufWritePost * AlpacaTagsUpdate
  endif
augroup END

" find current projects' root directory and lcd
NeoBundle "airblade/vim-rooter"
if neobundle#is_installed("vim-rooter")
  " Change only current window's directory
  let g:rooter_use_lcd = 1
  " files/directories for the root directory
  let g:rooter_patterns = ['tags', '.git', '.git/', '_darcs/', '.hg/', '.bzr/', 'Makefile', 'GNUMakefile', 'GNUmakefile', '.svn/']
  " don't echo the project directory
  let g:rooter_silent_chdir = 1
  " Automatically change the directory
  "autocmd! BufEnter *.c,*.cc,*.cxx,*.cpp,*.h,*.hh,*.java,*.py,*.sh,*.rb,*.html,*.css,*.js :Rooter
endif
if has("path_extra")
  set tags+=tags; " find tags file recursively forwardparent directories
endif

" class outline viewer
NeoBundle 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>

" Emmet for vim
NeoBundle 'mattn/emmet-vim'

" searches '.lvimrc' under the current directories and adapt local settings
NeoBundle 'embear/vim-localvimrc'
let g:localvimrc_ask = 0 " Don't ask before loading a vimrc file

" define custom mode
NeoBundle 'kana/vim-submode'

" Enhanced Javascript support
NeoBundleLazy 'jelera/vim-javascript-syntax', {'autoload':{'filetypes':['javascript']}}

" PHP CodeSniffer (run with `:CodeSniff`)
NeoBundleLazy 'bpearson/vim-phpcs', {'autoload': {'filetypes': ['php']}}


call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck


" ----------------
" NeoBundle related customization
" ----------------
" setup WatchDogs
let g:watchdogs_check_BufWritePost_enable = 1 " check on save
let g:watchdogs_check_CursorHold_enable = 1 " check on interval
let g:watchdogs_check_CursorHold_enables = {
\ 'php' : 1,
\ 'ruby' : 1,
\}
call watchdogs#setup(g:quickrun_config)

" auto start Unite without argments
let file_name = expand('%')
if has('vim_starting') && file_name == ''
  autocmd VimEnter * Unite file_mru
endif

if neobundle#is_installed('vim-submode')
  let g:submode_timeout = 0
  " change windows size mode
  call submode#enter_with('window', 'n', '', '<C-w><C-w>', '<Nop>')
  call submode#leave_with('window', 'n', '', '<Esc>')
  call submode#map('window', 'n', '', 'j', '<C-w>j')
  call submode#map('window', 'n', '', 'J', '<C-w>J')
  call submode#map('window', 'n', '', 'k', '<C-w>k')
  call submode#map('window', 'n', '', 'K', '<C-w>K')
  call submode#map('window', 'n', '', 'l', '<C-w>l')
  call submode#map('window', 'n', '', 'L', '<C-w>L')
  call submode#map('window', 'n', '', 'h', '<C-w>h')
  call submode#map('window', 'n', '', 'H', '<C-w>h')
  call submode#map('window', 'n', '', 's', '<C-w>s')
  call submode#map('window', 'n', '', 'v', '<C-w>v')
  call submode#map('window', 'n', '', 'x', ':q<CR>')
  call submode#map('window', 'n', '', '>', '<C-w>5>')
  call submode#map('window', 'n', '', '<', '<C-w>5<lt>')
  call submode#map('window', 'n', '', '+', '<C-w>5+')
  call submode#map('window', 'n', '', '-', '<C-w>5-')
endif


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
set modeline " enable modeline
set scrolloff=3 " scroll offset

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
let g:rehash256=1
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

" fix vim regex dialect
nmap / /\v

" SHIFT-Insert are Paste
map <S-Insert>	"+gp
"cmap <S-Insert>	"+gp+
imap <S-Insert>	<C-o>p
vmap <S-Insert>	"+gp

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

" reload .vimrc and .gvimrc
nnoremap <Leader>R :<C-u>so $MYVIMRC<CR>

" expand current directory path
cnoremap <expr>%% getcmdtype() == ':' ? expand('%:h') : '%%'

" update ctags
nnoremap <F5> :<C-u>call vimproc#system_bg('ctags -R')<CR>

" plugin: Unite
nnoremap [unite] <Nop>
nmap U [unite]
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]f :<C-u>Unite file_rec<CR>
nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
nnoremap <silent> [unite]r :<C-u>Unite register<CR>
nnoremap <silent> [unite]g :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
nnoremap <silent> [unite]y :<C-u>Unite yankround<CR>
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

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

if has("gui")
  runtime! $MYGVIMRC
end
