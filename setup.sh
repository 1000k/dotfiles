#!/bin/sh
files=(.vimrc .zshrc .zshenv .tmux.conf)

for item in ${files[@]}; do
  ln -sf ~/dotfiles/${item} ~/${item}
done

# Vim
mkdir ~/.vim
mkdir ~/.vim/bundle
ln -sf ~/dotfiles/colors ~/.vim/colors
ln -sf ~/dotfiles/indent ~/.vim/indent
ln -sf ~/dotfiles/after ~/.vim/after
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

# tmux
mkdir ~/.tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# dotfiles
git clone https://github.com/1000k/dotfiles
