## Default shell configuration
# auto change directory
setopt auto_cd

# auto directory pushd that you can get dirs list by `cd -[tab]`
setopt auto_pushd

# command correct edition before each completion attempt
setopt correct

# no beep sound when complete list displayed
setopt nolistbeep


## Completion configuration
autoload -U compinit
compinit


## Command history configuration
HISTFILE=${HOME}/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data


## Customize prompt
autoload colors
colors
PROMPT="%{${fg[green]}%}[%n@%m]%% %{${reset_color}%}"
RPROMPT="[%/]"
PROMPT2="%_%% "
SPROMPT="%r is correct? [n,y,a,e]: "

## Enable 256 color if supported
if [ -e /usr/share/terminfo/x/xterm-256color ]; then
        export TERM='xterm-256color'
else
        export TERM='xterm-color'
fi

## Load user .zshrc configuration file
[ -f ${HOME}/.zshrc.mine ] && source ${HOME}/.zshrc.mine

