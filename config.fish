eval (direnv hook fish)

set TERM screen-256color
set fish_plugins theme peco

# Bind for prco history to Ctrl+r
function fish_user_key_bindings
  bind \cr peco_select_history
end
