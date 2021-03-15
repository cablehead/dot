# for macOS big sur
#
set -o vi

export TERM=xterm-256color

export VISUAL=$(which vim)

export CLICOLOR=1

export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";

alias jq='jq --unbuffered'
alias grep='grep --line-buffered'

# zsh specific
zle_highlight+=(paste:none)
