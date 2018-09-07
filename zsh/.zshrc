#!/bin/zsh
source <(antibody init)
antibody bundle < ~/.zsh_plugins.txt

# jump around
source ~/.z.sh

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

# Nim
export PATH=/Users/aljohnson/.nimble/bin:$PATH

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

alias vim="/usr/local/bin/vim" # clipboard
alias pyserve="python -m SimpleHTTPServer"

# Splunk
export SPLUNK_HOME=/opt/splunk
alias rsw='/opt/splunk/bin/splunk restart splunkweb'
alias rsp='/opt/splunk/bin/splunk restart'
alias spip="pip install -r requirements.txt -i https://repo.splunk.com/artifactory/api/pypi/pypi-virtual/simple"
alias orca="docker run --rm -it --name orca -e USER=$USER \
   -v /var/run/docker.sock:/var/run/docker.sock \
   -v $HOME/.orca:/root/.orca \
   -v $HOME/.ssh:/root/.ssh \
   -v \$(pwd -P):/orca-home repo.splunk.com/splunk/products/orca"

