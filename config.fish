eval (direnv hook fish)

set TERM screen-256color
set fish_plugins theme peco

function fish_user_key_bindings
  bind \cr 'peco_select_history (commandline -b)'
end
