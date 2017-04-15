" ================
" Install plugins
" ================
call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'Shougo/unite.vim'
Plug 'Shougo/neomru.vim'
Plug 'ujihisa/unite-colorscheme'
Plug 'Shougo/vimfiler'

" caw.vim: better comment out
Plug 'tyru/caw.vim'

" yankround: advanced YankRing
Plug 'LeafCage/yankround.vim'

" Lightline: improve statusline
Plug 'itchyny/lightline.vim'

" vim-multiple-cursors: multi line manupilation like Sublime text (`Ctrl+n` to launch)
Plug 'terryma/vim-multiple-cursors'

" vim-expand-region: visually select incresingly larger regions of text
Plug 'terryma/vim-expand-region'

" vim-rooter: find current projects' root directory and lcd
Plug 'airblade/vim-rooter'

Plug 'Shougo/neocomplete.vim'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'honza/vim-snippets'

" Unite-Everything: Search from Everything
if has('win32') || has ('win64')
  Plug 'sgur/unite-everything'
  let g:unite_source_everything_limit = 100 " A number of output from everything
  let g:unite_source_everything_full_path_search = 1 " Setting 1 makes everything do a full path search.
  "let g:unite_source_everything_posix_regexp_search = 0 " Setting 1 makes everything search with basic POSIX regular expression.
endif

"  enhanced incsearch
Plug 'haya14busa/incsearch.vim'

" ----------------
"  Clojure support plugins
" ----------------
Plug 'tpope/vim-fireplace', {'for':'clojure'}
Plug 'tpope/vim-classpath', {'for':'clojure'}
" Better Rainbow Parentheses
Plug 'kien/rainbow_parentheses.vim', {'for':'clojure'}
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

" pairs of handy bracket mappings
Plug 'tpope/vim-unimpaired'

" Indent guide
Plug 'Yggdroot/indentLine'

" the plugin provied mappings to easily modify such surroundings in pairs
Plug 'tpope/vim-surround'

" Enhanced Javascript support
Plug 'jelera/vim-javascript-syntax', {'for':'javascript'}

" PHP CodeSniffer (run with `:CodeSniff`)
Plug 'bpearson/vim-phpcs', {'for': 'php'}

" class outline viewer
Plug 'majutsushi/tagbar'

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

call plug#end()


" ================
" Helper functions
" ================
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
