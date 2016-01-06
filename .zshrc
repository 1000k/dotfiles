# Load default settings
source ~/.zsh.d/zshrc.default

alias tmux="TERM=screen-256color-bce tmux"

# enhancd
if [ -f "/home/vagrant/.enhancd/zsh/enhancd.zsh" ]; then
    source "/home/vagrant/.enhancd/zsh/enhancd.zsh"
fi
