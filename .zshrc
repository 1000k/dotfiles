# Load default settings
source ~/.zsh.d/zshrc.default

case "$(uname)" in
  Darwin) # OSがMacならば
    if [[ -d /Applications/MacVim.app ]]; then # MacVimが存在するならば
      alias vim=/Applications/MacVim.app/Contents/MacOS/Vim
      alias vi=vim
    fi
    ;;

  *) ;; # OSがMac以外ならば何もしない
esac

alias tmux="TERM=screen-256color-bce tmux"
alias ll="ls -l -G"

# enhancd
if [ -f "/home/vagrant/.enhancd/zsh/enhancd.zsh" ]; then
    source "/home/vagrant/.enhancd/zsh/enhancd.zsh"
fi
