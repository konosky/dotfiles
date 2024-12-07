#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
eval "$(starship init bash)"
export GOROOT="${HOME}/.local/go"
export PATH="${PATH}:${GOROOT}/bin"
export GOPATH="${HOME}/go"
export PATH="${PATH}:${GOPATH}/bin"
