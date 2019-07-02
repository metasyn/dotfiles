#!/bin/zsh
set -o vi

autoload -U +X compinit && compinit -u
autoload -U +X bashcompinit && bashcompinit
autoload -U promptinit && promptinit

HISTFILE=~/.zsh_history
ulimit -S -n 2048

# Plugins
source <(antibody init)
antibody bundle < ~/.zsh_plugins.txt

# jump around
source ~/.z.sh

eval $(dircolors ~/.dircolors.ansi-dark)
alias ls="ls --color=auto"

# GO 
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export PATH="$GOPATH/bin:$PATH"

# Python
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:/opt/python/bin"
export PYTHONDONTWRITEBYTECODE="true"

eval "$(pyenv init -)"

alias pyserve="python -m http.server"
alias pycrm="find . | grep -e pyc$ | xargs rm && find . | grep pycache | xargs rm -rf"

# Nim
export PATH=~/code/Nim/bin:$PATH
export PATH=~/.nimble/bin:$PATH

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# k8s
alias k='kubectl'
if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi

# alacritty
alias alacritty='open -n /Applications/Alacritty.app'
export PATH="/usr/local/opt/openssl/bin:$PATH"
