@echo off

set vim_dir="%USERPROFILE%\.vim"
set dotfiles_dir="%USERPROFILE%\dotfiles"

fsutil hardlink create "%vim_dir%\_vimrc" "%dotfiles_dir\.vimrc" 
fsutil hardlink create "%vim_dir%\_gvimrc" "%dotfiles_dir\.gvimrc"

