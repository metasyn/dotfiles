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

eval $(gdircolors ~/.dircolors.ansi-dark)
alias ls="gls --color=auto"

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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# work
SLACK_RC=.slackrc
if [[ -f $SLACK_RC ]]; then
    source $SLACK_RC
fi

