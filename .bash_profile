#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
. "$HOME/.cargo/env"
. "/home/konosuke/.deno/env"
source /home/konosuke/.local/share/bash-completion/completions/deno.bash