#!/bin/zsh
set -o vi

#zmodload zsh/zprof

autoload -U +X compinit && compinit -u
autoload -U +X bashcompinit && bashcompinit
autoload -U promptinit && promptinit
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=2'

# Setup history
HISTSIZE=5000
SAVEHIST=10000
HISTFILE=~/.zsh_history
set -o incappendhistory

ulimit -S -n 2048

export GIT_EDITOR=vi

# Plugins
source <(antibody init)
antibody bundle < ~/.zsh_plugins.txt

# jump around
source ~/.z.sh

if [[ $(hostname) == *"NYC"* ]]; then
  eval $(gdircolors ~/.dircolors.ansi-dark)
  alias ls="gls --color=auto"
else
  eval $(dircolors ~/.dircolors.ansi-dark)
  alias ls="ls --color=auto"
fi;


# Nvim
if [ $commands[nvim] ]; then
  alias vim=nvim
fi

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

alias pyserve="python3 -m http.server"
alias pycrm="find . | grep -e pyc$ | xargs rm && find . | grep pycache | xargs rm -rf"


# Nim
export PATH=~/code/Nim/bin:$PATH
export PATH=~/.nimble/bin:$PATH

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Javascript

# Fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
function look() {
  fzf \
    --preview '[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file ||  (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -500' \
    --bind 'enter:execute(nvim {}),ctrl-y:execute-silent(echo {} | pbcopy)+abort'
}
alias fzf=look

# work
SLACK_RC=~/.slackrc
if [[ -f $SLACK_RC ]]; then
    source $SLACK_RC
fi
