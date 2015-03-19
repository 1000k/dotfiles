@echo off

set home_dir=%USERPROFILE%
set vim_dir="%USERPROFILE%\.vim"
set vimfiles_dir="%USERPROFILE%\vimfiles"
set dotfiles_dir="%USERPROFILE%\dotfiles"

md "%vim_dir%"
md "%vim_dir%\bundle"
md "%vimfiles_dir%"

mklink "%home_dir%\_vimrc" "%dotfiles_dir%\.vimrc"
mklink "%home_dir%\_gvimrc" "%dotfiles_dir%\.gvimrc"
mklink /d "%vim_dir%\conf.d" "%dotfiles_dir%\conf.d"
mklink /d "%vimfiles_dir%\colors" "%dotfiles_dir%\colors"
mklink /d "%vimfiles_dir%\indent" "%dotfiles_dir%\indent"

git clone https://github.com/Shougo/neobundle.vim "%vim_dir%\bundle\neobundle.vim"

