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
"set colorcolumn=80 " show line ruler
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
set noundofile

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

" visualize tab, space, line break
set list
set listchars=tab:>\ ,trail:_,extends:>,precedes:<,eol:$

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
if has('autocmd')
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
let mapleader = "\<Space>"

" tab operation
nnoremap tn :<C-u>tabnew<CR>
nnoremap th :<C-u>tabprevious<CR>
nnoremap tl :<C-u>tabnext<CR>
nnoremap t0 :<C-u>tabfirst<CR>
nnoremap t$ :<C-u>tablast<CR>

" [Copy to|Paste from] system clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" fix vim regex dialect (use very magic mode)
" nnoremap / /\v
" vnoremap / /\v
cnoremap %s %s/\v

" SHIFT-Insert are Paste
map <S-Insert>	"+gp
"cmap <S-Insert>	"+gp+
imap <S-Insert>	<C-o>p
vmap <S-Insert>	"+gp

" bind frequently used keys to useful position
noremap <Leader>h  ^
noremap <Leader>l  $
nnoremap <Leader>/  *

" serial paste
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" open .vimrc
nnoremap <Leader>. :<C-u>tabedit $MYVIMRC<CR>

" reload .vimrc and .gvimrc
nnoremap <Leader>R :<C-u>so $MYVIMRC<CR>

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

" expand current directory path
cnoremap <expr>%% getcmdtype() == ':' ? expand('%:h') : '%%'


" ----------------
" Custom commands
" ----------------
" change file encodings
command! ToUtf8 set fileencoding=utf-8
command! ToEUC set fileencoding=euc-jp
command! ToSjis set fileencoding=sjis

" change linebreak character
command! ToUnix set ff=unix

" rename (delete current file and create new one)
command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))

command! LcdCurrentFile lcd %:h


" ----------------
" vim-plug
" ----------------
call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'Shougo/unite.vim'
Plug 'Shougo/neomru.vim'
Plug 'ujihisa/unite-colorscheme'
Plug 'Shougo/vimfiler'
call plug#end()

" プラグインがインストールされているかどうか
let s:plug = {
      \ "plugs": get(g:, 'plugs', {})
      \ }

function! s:plug.is_installed(name)
  return has_key(self.plugs, a:name) ? isdirectory(self.plugs[a:name].dir) : 0
endfunction

" 未インストールプラグインを検知してインストール
function! s:plug.check_installation()
  if empty(self.plugs)
    return
  endif

  let list = []
  for [name, spec] in items(self.plugs)
    if !isdirectory(spec.dir)
      call add(list, spec.uri)
    endif
  endfor

  if len(list) > 0
    let unplugged = map(list, 'substitute(v:val, "^.*github\.com/\\(.*/.*\\)\.git$", "\\1", "g")')

    " Ask whether installing plugs like NeoBundle
    echomsg 'Not installed plugs: ' . string(unplugged)
    if confirm('Install plugs now?', "yes\nNo", 2) == 1
      PlugInstall
      " Close window for vim-plug
      silent! close
      " Restart vim
      silent! !vim
      quit!
    endif
  endif
endfunction

augroup check-plug
  autocmd!
  autocmd VimEnter * if !argc() | call s:plug.check_installation() | endif
augroup END

" ----------------
"  caw.vim
"  support better comment out
" ----------------
Plug 'tyru/caw.vim'
nmap <Leader>c <plug>(caw:i:toggle)
vmap <Leader>c <plug>(caw:i:toggle)

" ----------------
"  yankround
"  advanced YankRing
" ----------------
Plug 'LeafCage/yankround.vim'
nmap p <Plug>(yankround-p)
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)
xmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
" nmap <C-p> <Plug>(yankround-prev)
" nmap <C-n> <Plug>(yankround-next)

" ----------------
"  Lightline
"  improve statusline
" ----------------
Plug 'itchyny/lightline.vim'
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

" ----------------
"  vim-multiple-cursors
"  multi line manupilation like Sublime text (`Ctrl+n` to launch)
" ----------------
Plug 'terryma/vim-multiple-cursors'
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

" ----------------
" vim-expand-region
" visually select incresingly larger regions of text
" ----------------
Plug 'terryma/vim-expand-region'
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" ----------------
" plugin configurations
" ----------------
if s:plug.is_installed("vimfiler")
  let g:vimfiler_as_default_explorer = 1 " use VimFiler instead of netrw
  let g:vimfiler_safe_mode_by_default = 0 " start with safe mode = off
  nmap <F10> :VimFiler<CR>
endif

" ----------------
"  vim-rooter
"  find current projects' root directory and lcd
" ----------------
Plug 'airblade/vim-rooter'
if s:plug.is_installed("vim-rooter")
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

" ----------------
"  Unite-Everything
"  Search from Everything
"  https://github.com/sgur/unite-everything
" ----------------
if has('win32') || has ('win64')
  Plug 'sgur/unite-everything'
  let g:unite_source_everything_limit = 100 " A number of output from everything
  let g:unite_source_everything_full_path_search = 1 " Setting 1 makes everything do a full path search.
  "let g:unite_source_everything_posix_regexp_search = 0 " Setting 1 makes everything search with basic POSIX regular expression.
endif

" ----------------
"  enhanced incsearch
" ----------------
Plug 'haya14busa/incsearch.vim'
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)


" ----------------
"  Clojure support plugins
" ----------------
" Clojure REPL support
Plug 'tpope/vim-fireplace', {'for':'clojure'}
" Require and Run test just in a command
function! s:myRunTests() abort
  let ns = fireplace#ns()
  if match(ns, 'test$') ==# -1
    let test_ns = ns . '-test'
  else
    let test_ns = ns
    let ns = substitute(ns, '-test', '', '')
  endif
  execute ':Require ' . ns
  execute ':RunTests ' . test_ns
endfunction
command! MyRunTests call s:myRunTests()
nnoremap <Leader>t :<C-u>MyRunTests<CR>
nnoremap <Leader>s :<C-u>Require<CR>

Plug 'tpope/vim-classpath', {'for':'clojure'}

" Better Rainbow Parentheses
Plug 'kien/rainbow_parentheses.vim', {'for':'clojure'}
if s:plug.is_installed('rainbow_parentheses.vim')
  au BufEnter *.clj RainbowParenthesesActivate
  au Syntax clojure RainbowParenthesesLoadRound
  au Syntax clojure RainbowParenthesesLoadSquare
  au Syntax clojure RainbowParenthesesLoadBraces
endif

" vim-clojure-static
Plug 'guns/vim-clojure-static', {'for':'clojure'}
let g:clojure_align_multiline_strings = 1



" ----------------
" Rails support plugins
" ----------------
Plug 'tpope/vim-rails', {'for':['rb', 'erb']}
Plug 'tpope/vim-bundler', {'for':['rb', 'erb']}

" ----------------
"  miscellaneous
" ----------------
" Syntax check
Plug 'scrooloose/syntastic'
let g:syntastic_ruby_checkers = ['rubocop']

" pairs of handy bracket mappings
Plug 'tpope/vim-unimpaired'

" Indent guide
Plug 'nathanaelkane/vim-indent-guides'
let g:indent_guides_enable_on_vim_startup=1

" the plugin provied mappings to easily modify such surroundings in pairs
Plug 'tpope/vim-surround'

" text formater
Plug 'vim-scripts/Align'

" Enhanced Javascript support
Plug 'jelera/vim-javascript-syntax', {'for':'javascript'}

" PHP CodeSniffer (run with `:CodeSniff`)
Plug 'bpearson/vim-phpcs', {'for': 'php'}

" class outline viewer
Plug 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>

" Emmet for vim
Plug 'mattn/emmet-vim', {'for': ['html', 'css', 'scss', 'sass']}

" define custom mode
Plug 'kana/vim-submode'

" helps to end certain structures automatically for Ruby, Bash, VC, C/C++, Lua
Plug 'tpope/vim-endwise'

" Git wrapper
Plug 'tpope/vim-fugitive'

" add close chars automatically
Plug 'townk/vim-autoclose'

" JSON formatter (type `gqij` or `gqaj` to pretty format)
Plug 'tpope/vim-jdaddy'

" Generate Ctags automatically
Plug 'szw/vim-tags'

" show quickfix contents in status line
Plug 'KazuakiM/vim-qfstatusline'

" highlight trailing whitespaces
Plug 'ntpeters/vim-better-whitespace'

" ag (requires ag binary in $PATH)
Plug 'rking/ag.vim'

" File search
Plug 'ctrlpvim/ctrlp.vim'

" Terraform support
Plug 'hashivim/vim-terraform'

" ===================================


" ----------------
" Load conf.d
" ----------------
if has('mac')
  set clipboard=unnamed
  " auto-pairs プラグインインストール後に日本語入力ができなくなる不具合を解消
  set imdisable
endif

if has('gui')
  runtime! $MYGVIMRC
end

set runtimepath+=$HOME/.vim/
runtime! conf.d/*.vim
