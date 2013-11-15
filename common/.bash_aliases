set -o vi

export TERM=xterm-256color

alias ls="ls --color"
alias less="less -R"
alias ack="ack-grep"

eval `dircolors ~/.dircolors`

export PATH=$PATH:~/bin
