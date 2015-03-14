@echo off

set home_dir=%USERPROFILE%
set dotfiles_dir="%USERPROFILE%\dotfiles"

mklink "%home_dir%\_vimrc" "%dotfiles_dir%\.vimrc" 
mklink "%home_dir%\_gvimrc" "%dotfiles_dir%\.gvimrc"

md "%home_dir%\.vim"
md "%home_dir%\.vim\bundle"
git clone https://github.com/Shougo/neobundle.vim "%home_dir%\.vim\bundle\neobundle.vim"

