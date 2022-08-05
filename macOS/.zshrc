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

export PATH=$PATH:~/bin

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

# map 'v' to edit command line in vim
export VISUAL=vim
autoload -z edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# opam configuration
[[ ! -r /Users/andy/.opam/opam-init/init.zsh ]] || source /Users/andy/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null