#!/bin/sh

# arg1: color code (30-37)
# arg2: strings
echoCol() {
  echo -en "\e[${1}m"
  echo ${2}
  echo -en "\e[m"
}

lnDotfile() {
  echo "ln -sf ~/dotfiles/${1} ~/${1}"
  ln -sf ~/dotfiles/${1} ~/${1}
}


echo
echoCol 32 "=====  Vim  ====="
echoCol 36 'Installing dotfiles...'
lnDotfile .vimrc
lnDotfile .gvimrc

echoCol 36 "creating directories..."
mkdir ~/.vim
mkdir ~/.vim/bundle

links=(after colors conf.d ftplugin indent)
for link in ${links[@]}; do
  ln -sf ~/dotfiles/.vim/${link} ~/.vim/${link}
done


echo
echoCol 32 "=====  Zsh  ====="
echoCol 36 'Installing dotfiles...'
lnDotfile .zshrc
lnDotfile .zshenv

echoCol 36 "Creating directories..."
ln -sf ~/dotfiles/.zsh.d ~/.zsh.d

echoCol 36 "Installing Antigen..."
curl -L https://raw.githubusercontent.com/zsh-users/antigen/master/antigen.zsh > ~/dotfiles/.zsh.d/antigen.zsh
source ~/dotfiles/.zsh.d/antigen.zsh

echoCol 33 "Installing Zsh is completed. Please type 'chsh -s /bin/zsh' and restart terminal."

echo
echoCol 32 "=====  tmux  ====="
echoCol 36 'Installing dotfiles...'
lnDotfile .tmux.conf

echoCol 36 "Cloning tmux plugins..."
mkdir ~/.tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echoCol 36 "Cloning dotfiles..."
git clone https://github.com/1000k/dotfiles


echo
echoCol 32 "Done."
