# for macOS big sur
#
set -o vi

export TERM=xterm-256color

export VISUAL=$(which vim)

export CLICOLOR=1

export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
export PATH="~/bin:/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";

alias jq='jq --unbuffered'
alias grep='grep --line-buffered'
alias sha256='shasum --algorithm 256'

# zsh specific
zle_highlight+=(paste:none)

# history with cursor at beginning of line
# https://unix.stackexchange.com/questions/562292/zsh-history-with-cursor-at-beginning-of-line
bindkey -a j vi-down-line-or-history
bindkey -a k vi-up-line-or-history
