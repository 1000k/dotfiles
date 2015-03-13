#!/bin/sh
files=(.vimrc .zshrc)

for item in ${files[@]}; do
  ln -sf ~/dotfiles/${item} ~/${item}
done
