setlocal iskeyword-=/

" Requires vim-fireplace
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
nnoremap <buffer> <Leader>t :<C-u>MyRunTests<CR>

nnoremap <buffer> <Leader>s :<C-u>Require<CR>

aug MyLispWords
  au!
  au FileType clojure set lispwords+=ns,are
  " compojure
  au FileType clojure set lispwords+=defroutes,GET,POST
  " midje
  au FileType clojure set lispwords+=facts,fact
  " conjure
  au FileType clojure set lispwords+=stubbing
aug END

