#!/bin/sh
files=(.vimrc .zshrc .zshenv .tmux.conf)

for item in ${files[@]}; do
  ln -sf ~/dotfiles/${item} ~/${item}
done

# Vim
mkdir ~/.vim
mkdir ~/.vim/bundle

links=(conf.d colors indent after)
for link in ${links[@]}; do
  ln -sf ~/dotfiles/.vim/${link} ~/.vim/${link}
done
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

# tmux
mkdir ~/.tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# dotfiles
git clone https://github.com/1000k/dotfiles
