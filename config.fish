# Enable direnv
eval (direnv hook fish)

# Enable rbenv
set -x PATH $HOME/.rbenv/bin $PATH
rbenv init - | source

# vi mode
fish_vi_key_bindings

set TERM screen-256color
set fish_plugins theme peco

# Bind for prco history to Ctrl+r
function fish_user_key_bindings
  bind \cr peco_select_history
end

function peco_select_repository
  if set -q $argv
    ghq list -p | peco | read line; builtin cd $line
  else
    ghq list -p | peco --query $argv | read line; builtin cd $line
  end
  set -e line
end
bind \c] peco_select_repository
