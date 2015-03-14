" --------
" General
" --------
" show line number
set nu

" set paste mode
set paste

" visualize tab, space, line break
set list
set listchars=tab:\|-,trail:_,eol:$,extends:>,precedes:<,nbsp:%

" highlight zenkaku space
function! ZenkakuSpace()
	highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
endfunction

if has('syntax')
	augroup ZenkakuSpace
		autocmd!
		autocmd ColorScheme * call ZenkakuSpace()
		autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
	augroup END
	call ZenkakuSpace()
endif

" set tab width
set ts=4 sw=4 sts=0

set expandtab

" enable auto indentation
set autoindent
set smartindent

" enable incremental search
set incsearch

" status line
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2


" --------
" Plugins
" --------
