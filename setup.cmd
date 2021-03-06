@echo off

set home_dir=%USERPROFILE%
set vim_dir="%USERPROFILE%\.vim"
set vimfiles_dir="%USERPROFILE%\vimfiles"
set dotfiles_dir="%USERPROFILE%\dotfiles"

md "%vim_dir%"
md "%vimfiles_dir%"

mklink "%home_dir%\_vimrc" "%dotfiles_dir%\.vimrc"
mklink "%home_dir%\_gvimrc" "%dotfiles_dir%\.gvimrc"
mklink "%home_dir%\.vimrc" "%dotfiles_dir%\.vimrc"
mklink "%home_dir%\.gvimrc" "%dotfiles_dir%\.gvimrc"
mklink /d "%vim_dir%\after" "%dotfiles_dir%\.vim\after"
mklink /d "%vim_dir%\autoload" "%dotfiles_dir%\.vim\autoload"
mklink /d "%vim_dir%\colors" "%dotfiles_dir%\.vim\colors"
mklink /d "%vim_dir%\customload" "%dotfiles_dir%\.vim\customload"
mklink /d "%vim_dir%\ftplugin" "%dotfiles_dir%\.vim\ftplugin"
mklink /d "%vim_dir%\indent" "%dotfiles_dir%\.vim\indent"
