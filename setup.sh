#!/bin/bash

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
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.gvimrc ~/.gvimrc

echoCol 36 "Creating directories..."
mkdir ~/.vim

echoCol 36 "Creating symlink..."
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
links=(after autoload colors customload ftplugin indent)
for link in ${links[@]}; do
  ln -sf ~/dotfiles/.vim/${link} ~/.vim/${link}
done


echo
echoCol 32 "=====  fish  ====="
echoCol 36 "Creating directories..."
mkdir -p ~/.config/fish

echoCol 36 "Creating symlink..."
ln -sf ~/dotfiles/config.fish ~/.config/fish/config.fish
ln -sf ~/dotfiles/fishfile ~/.config/fish/fishfile

echoCol 36 "Installing fisherman..."
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher

echoCol 33 "Fish is not installed yet. Run chef-apply."


echo
echoCol 32 "=====  tmux  ====="
echoCol 36 'Installing dotfiles...'
lnDotfile .tmux.conf

echoCol 36 "Cloning tmux plugins..."
mkdir ~/.tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm


echo
echoCol 32 "=====  misc  ====="
echoCol 36 "Cloning dotfiles..."
cd ~
git clone https://github.com/1000k/dotfiles

echoCol 36 "Installing chef-apply..."
curl -L https://www.chef.io/chef/install.sh | sudo bash

echoCol 36 "Creating symlink..."
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig

echo
echoCol 32 "Done."
