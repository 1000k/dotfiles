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

" cursor keys moves rows as display)
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" expand current directory path
cnoremap <expr>%% getcmdtype() == ':' ? expand('%:h') : '%%'
