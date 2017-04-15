if has('gui')
  runtime! $MYGVIMRC
end

set runtimepath+=$HOME/.vim/
runtime! customload/init/*.vim
runtime! customload/plugins/*.vim
