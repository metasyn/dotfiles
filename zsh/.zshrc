#!/bin/zsh
set -o vi
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit

HISTFILE=~/.zsh_history
ulimit -S -n 2048

# Plugins
source <(antibody init)
antibody bundle < ~/.zsh_plugins.txt

# jump around
source ~/.z.sh

# pretty ls
eval `gdircolors ~/.dircolors.ansi-dark`
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

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

alias vim="/usr/local/bin/vim" # clipboard

# Splunk
export SPLUNK_HOME=/opt/splunk
alias rsw='/opt/splunk/bin/splunk restart splunkweb'
alias rsp='/opt/splunk/bin/splunk restart'
alias spip="pip3 install --extra-index-url https://repo.splunk.com/artifactory/api/pypi/pypi-local/simple"
alias orca="docker run --rm -it --name orca -e USER=$USER \
   -v /var/run/docker.sock:/var/run/docker.sock \
   -v $HOME/.orca:/root/.orca \
   -v $HOME/.ssh:/root/.ssh \
   -v \$(pwd -P):/orca-home repo.splunk.com/splunk/products/orca"

# k8s
alias k='kubectl'
if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi

# alacritty
alias alacritty='open -n /Applications/Alacritty.app'
