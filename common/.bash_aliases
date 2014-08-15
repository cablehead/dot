set -o vi

export TERM=xterm-256color

eval `dircolors ~/git/dot/common/dircolors.ansi-dark`

export PATH=/usr/bin:/bin:/usr/local/bin
export PATH=$PATH:~/bin
export PATH=$PATH:~/.dynamic-colors/bin

export VISUAL=$(which vim)

alias ls="ls --color"
alias less="less -R"
alias ack="ack-grep"

alias pytest="python -m unittest -v"

alias pythonpath="eval `echo export PYTHONPATH=$(cat ~/.pythonpath | tr '\n' ':')`"
pythonpath

alias solarize-light="dynamic-colors switch solarized-light"
alias solarize-light2="dynamic-colors switch solarized-light-desaturated"
alias solarize-dark="dynamic-colors switch solarized-dark"
alias solarize-dark2="dynamic-colors switch solarized-dark-desaturated"
