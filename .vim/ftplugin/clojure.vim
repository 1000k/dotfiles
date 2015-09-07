setlocal iskeyword-=/

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
