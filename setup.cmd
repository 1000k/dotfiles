@echo off

set home_dir=%USERPROFILE%
set dotfiles_dir="%USERPROFILE%\dotfiles"

mklink "%home_dir%\_vimrc" "%dotfiles_dir%\.vimrc" 
mklink "%home_dir%\_gvimrc" "%dotfiles_dir%\.gvimrc"

