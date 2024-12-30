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
export PATH="${HOME}/.local/bin:${PATH}"
eval "$(zoxide init bash)"
eval "$(mcfly init bash)"
export PATH="${HOME}/.dotnet/tools:${PATH}"

# Functions
cpfast() { mkdir "$2" && find "$1" -type d | cpio -p "$2" && find "$1" ! -type d | split --filter="cpio -p '$2'" -n "r/$(nproc)" -u; }

create_unity_project() { mkdir -p "$1/Assets"; }
alias cup=create_unity_project

# Aliases
alias find=fd
alias cd=z
alias top=btm
alias cat=bat
alias grep=rg
alias ls=lsd
alias diff=delta
alias ping=gping
alias xxd=hexyl
alias du=dust
alias sed=sd
alias ps=procs
alias vi=nvim
alias rm=trash

alias g=git
alias l=ls
. "$HOME/.cargo/env"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
. "/home/konosuke/.deno/env"
source /home/konosuke/.local/share/bash-completion/completions/deno.bash
# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

case ":$PATH:" in
    *:/home/konosuke/.juliaup/bin:*)
        ;;

    *)
        export PATH=/home/konosuke/.juliaup/bin${PATH:+:${PATH}}
        ;;
esac

# <<< juliaup initialize <<<
