export TERM=xterm-256color
export CLICOLOR=1
export JQ_COLORS='0;35:0;39:0;39:0;39:0;32:1;39:1;39'
# zsh specific
zle_highlight+=(paste:none)

export HISTSIZE=1000
export SAVEHIST=$HISTSIZE
export HISTFILESIZE=999999

setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY

setopt EXTENDED_HISTORY

setopt HIST_REDUCE_BLANKS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE

setopt HIST_IGNORE_ALL_DUPS
# this may be a better option if HIST_IGNORE_ALL_DUPS is slow
# setopt HIST_EXPIRE_DUPS_FIRST

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
  autoload -Uz compinit
  compinit
fi

export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
export PATH="~/bin:/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";

# map 'v' to edit command line in nvim
export VISUAL=$(which nvim)
autoload -z edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

export PATH=~/new-day/bin:~/bin:$PATH

set -o vi

alias jq='jq --unbuffered'
alias grep='grep --line-buffered'
alias sha256='shasum --algorithm 256'
alias curl='curl -s'

# history with cursor at beginning of line
# https://unix.stackexchange.com/questions/562292/zsh-history-with-cursor-at-beginning-of-line
bindkey -a j vi-down-line-or-history
bindkey -a k vi-up-line-or-history

eval "$(atuin init zsh)"
