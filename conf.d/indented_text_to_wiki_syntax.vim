" Scripts to convert tab indented text to several Wiki syntax

" Trac
function! TabbedTextToTrac()
  silent! %s/^\(\t\)\@!/= /g
  silent! %s/^\t\{6}/         * /g
  silent! %s/^\t\{5}/       * /g
  silent! %s/^\t\{4}/     * /g
  silent! %s/^\t\{3}/   * /g
  silent! %s/^\t\{2}/ * /g
  silent! %s/^\t\{1}\(.\)/== \1/g
  noh
endfunction

" Redmine
function! TabbedTextToRedmine()
  silent! %s/^\t\{6}/***** /g
  silent! %s/^\t\{5}/**** /g
  silent! %s/^\t\{4}/*** /g
  silent! %s/^\t\{3}/** /g
  silent! %s/^\t\{2}/* /g
  silent! %s/^\t\{1}\(.*\)/h3. \1/g
  "silent! %s/^\[\*\n\]\@!/=== /g
  noh
endfunction
