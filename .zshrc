# Load default settings
source ~/.zsh.d/zshrc.default

alias tmux="TERM=screen-256color-bce tmux"
alias ll="ls -l --color"

# enhancd
if [ -f "/home/vagrant/.enhancd/zsh/enhancd.zsh" ]; then
    source "/home/vagrant/.enhancd/zsh/enhancd.zsh"
fi
