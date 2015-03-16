@echo off

set home_dir=%USERPROFILE%
set vim_dir="%USERPROFILE%\.vim"
set vimfiles_dir="%USERPROFILE%\vimfiles"
set dotfiles_dir="%USERPROFILE%\dotfiles"

md "%vim_dir%"
md "%vim_dir%\bundle"
md "%vimfiles_dir%"

mklink "%vimfiles_dir%\vimrc" "%dotfiles_dir%\.vimrc" 
mklink "%vimfiles_dir%\gvimrc" "%dotfiles_dir%\.gvimrc"
mklink /d "%vimfiles_dir%\colors" "%dotfiles_dir%\colors"
mklink /d "%vimfiles_dir%\indent" "%dotfiles_dir%\indent"

git clone https://github.com/Shougo/neobundle.vim "%vim_dir%\bundle\neobundle.vim"

