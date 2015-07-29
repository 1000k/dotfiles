" Scripts to convert tab indented text to several Wiki syntax

" Trac
function! TabbedTextToTrac()
  silent! %s/^\(\t\)\@!/= /g
  silent! %s/^\t\{6}/         * /g
  silent! %s/^\t\{5}/       * /g
  silent! %s/^\t\{4}/     * /g
  silent! %s/^\t\{3}/   * /g
  silent! %s/^\t\{2}/ * /g
  silent! %s/^\t\{1}\(.\)/
  noh
endfunction

" Redmine
function! TabbedTextToRedmine()
  silent! %s/^\t\{6}/***** /g
  silent! %s/^\t\{5}/**** /g
  silent! %s/^\t\{4}/*** /g
  silent! %s/^\t\{3}/** /g
  silent! %s/^\t\{2}/* /g
  silent! %s/^\t\{1}\(.*\)/
  "silent! %s/^\[\*\n\]\@!/
  noh
endfunction

" Markdown
function! TabbedTextToMarkdown()
  silent! %s/^\t\{6}/        - /g
  silent! %s/^\t\{5}/      - /g
  silent! %s/^\t\{4}/    - /g
  silent! %s/^\t\{3}/  - /g
  silent! %s/^\t\{2}/- /g
  silent! %s/^\t\{1}\(.*\)/
  "silent! %s/^\[\*\n\]\@!/
  noh
endfunction

command! TabbedTextToTrac :call TabbedTextToTrac()
command! TabbedTextToRedmine :call TabbedTextToRedmine()
command! TabbedTextToMarkdown :call TabbedTextToMarkdown()
