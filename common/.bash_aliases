set -o vi

export TERM=xterm-256color
eval `dircolors ~/git/dot/common/dircolors.ansi-dark`

alias ls="ls --color"
alias less="less -R"
alias ack="ack-grep"

export PATH=$PATH:~/bin
