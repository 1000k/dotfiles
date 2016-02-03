" ----------------
" NeoBudle initialization
"
" run at first time: `vim +NeoBundleInstall +qall`
" see: https://github.com/Shougo/neobundle.vim
" ----------------
" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath^=~/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'


" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

" File finder
NeoBundle 'Shougo/unite.vim'
let g:unite_enable_start_insert = 1 " launch in insert mode
nnoremap [unite] <Nop>
nmap <Leader>u [unite]
nnoremap <silent> [unite]b :<C-u>Unite bookmark<CR>
nnoremap <silent> [unite]B :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]f :<C-u>Unite file_rec<CR>
nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
nnoremap <silent> [unite]r :<C-u>Unite register<CR>
nnoremap <silent> [unite]g :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
nnoremap <silent> [unite]y :<C-u>Unite yankround<CR>
nnoremap <silent> [unite]e :<C-u>Unite everything<CR>
" exit Unite immediately from Unite with <ESC>*2
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

" Multi process
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\   'windows' : 'tools\\update-dll-mingw',
\   'cygwin' : 'make -f make_cygwin.mak',
\   'mac' : 'make -f make_mac.mak',
\   'linux' : 'make -f make_unix.mak',
\   'unix' : 'gmake',
\   },
\ }

" Filer
NeoBundle 'Shougo/vimfiler'
let g:vimfiler_as_default_explorer = 1 " use VimFiler instead of netrw
let g:vimfiler_safe_mode_by_default = 0 " start with safe mode = off
nmap <F10> :VimFiler<CR>
"
" Search from Everything
" https://github.com/sgur/unite-everything
if has('win32') || has ('win64')
  NeoBundle 'sgur/unite-everything'
  let g:unite_source_everything_limit = 100 " A number of output from everything
  "let g:unite_source_everything_posix_regexp_search = 0 " Setting 1 makes everything search with basic POSIX regular expression.
endif

" Enhance unite.vim to access to recent opened files (`:Unite file_mru`)
NeoBundle 'Shougo/neomru.vim'

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
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
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
nmap <Leader>c <plug>(caw:i:toggle)
vmap <Leader>c <plug>(caw:i:toggle)

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
nmap p <Plug>(yankround-p)
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)
xmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)

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

" visually select incresingly larger regions of text
NeoBundle 'terryma/vim-expand-region'
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

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

" Create Ctags file automatically
" (It requires Ctags.exe in your $PATH and vimproc.dll)
NeoBundleLazy 'alpaca-tc/alpaca_tags', {
\  'depends': ['Shougo/vimproc.vim'],
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
nnoremap <F5> :<C-u>call vimproc#system_bg('ctags -R')<CR>

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
NeoBundleLazy 'mattn/emmet-vim', {'autoload': {'filetypes': ['html', 'css', 'scss', 'sass']}}

" define custom mode
NeoBundle 'kana/vim-submode'

" helps to end certain structures automatically for Ruby, Bash, VC, C/C++, Lua
NeoBundle 'tpope/vim-endwise'

" enhanced incsearch
NeoBundle 'haya14busa/incsearch.vim'
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

" Enhanced Javascript support
NeoBundleLazy 'jelera/vim-javascript-syntax', {'autoload':{'filetypes':['javascript']}}

" PHP CodeSniffer (run with `:CodeSniff`)
NeoBundleLazy 'bpearson/vim-phpcs', {'autoload': {'filetypes': ['php']}}

" vim-clojure-static
NeoBundleLazy 'guns/vim-clojure-static', {'autoload': {'filetypes': ['clojure']}}
let g:clojure_align_multiline_strings = 1

" Better Rainbow Parentheses
NeoBundleLazy 'kien/rainbow_parentheses.vim', {'autoload': {'filetypes': ['clojure']}}
if neobundle#is_installed('rainbow_parentheses.vim')
  au BufEnter *.clj RainbowParenthesesActivate
  au Syntax clojure RainbowParenthesesLoadRound
  au Syntax clojure RainbowParenthesesLoadSquare
  au Syntax clojure RainbowParenthesesLoadBraces
endif

" Clojure REPL support
NeoBundleLazy 'tpope/vim-fireplace', {'autoload': {'filetypes': ['clojure']}}
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

NeoBundleLazy 'tpope/vim-classpath', {'autoload': {'filetypes': ['clojure']}}

" Rails support plugins
NeoBundleLazy 'tpope/vim-rails', {'autoload':{'filetypes':['rb', 'erb']}}
NeoBundleLazy 'tpope/vim-bundler', {'autoload':{'filetypes':['rb', 'erb']}}

" Syntax check
NeoBundle 'scrooloose/syntastic'
let g:syntastic_ruby_checkers = ['rubocop']


call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck


" ----------------
" Color scheme
" ----------------
set t_Co=256
colorscheme hybrid
" let g:molokai_original=0
" let g:rehash256=1
" colorscheme molokai

