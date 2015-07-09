#!/bin/sh

# arg1: color code (30-37)
# arg2: strings
echoCol() {
  echo -en "\e[${1}m"
  echo ${2}
  echo -en "\e[m"
}

echoCol 36 'Installing dotfiles...'
files=(.vimrc .zshrc .zshenv .tmux.conf)
for file in ${files[@]}; do
  ln -sf ~/dotfiles/${file} ~/${file}
done

echoCol 36 "Setting synbolic links..."
mkdir ~/.vim
mkdir ~/.vim/bundle

links=(conf.d colors indent after)
for link in ${links[@]}; do
  ln -sf ~/dotfiles/.vim/${link} ~/.vim/${link}
done

echoCol 36 "Cloning NeoBundle..."
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
echoCol 33 "If you don't want to enable plugins, remove '~/dotfiles/.vim/conf.d/plugins.vim'."
echoCol 33 "Some plugins require vim >= 7.4. If you use old version, please update."
echoCol 33 "After install NeoBundle, launch vim and type ':NeoBundleInstall'."

echoCol 36 "Cloning tmux plugins..."
mkdir ~/.tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echoCol 36 "Cloning dotfiles..."
git clone https://github.com/1000k/dotfiles

echoCol 32 "Done."
