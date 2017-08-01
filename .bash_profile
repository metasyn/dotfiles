C_DEFAULT="\[\033[m\]"
C_WHITE="\[\033[1m\]"
C_BLACK="\[\033[30m\]"
C_RED="\[\033[31m\]"
C_GREEN="\[\033[32m\]"
C_YELLOW="\[\033[33m\]"
C_BLUE="\[\033[34m\]"
C_PURPLE="\[\033[35m\]"
C_CYAN="\[\033[36m\]"
C_LIGHTGRAY="\[\033[37m\]"
C_DARKGRAY="\[\033[1;30m\]"
C_LIGHTRED="\[\033[1;31m\]"
C_LIGHTGREEN="\[\033[1;32m\]"
C_LIGHTYELLOW="\[\033[1;33m\]"
C_LIGHTBLUE="\[\033[1;34m\]"
C_LIGHTPURPLE="\[\033[1;35m\]"
C_LIGHTCYAN="\[\033[1;36m\]"
C_BG_BLACK="\[\033[40m\]"
C_BG_RED="\[\033[41m\]"
C_BG_GREEN="\[\033[42m\]"
C_BG_YELLOW="\[\033[43m\]"
C_BG_BLUE="\[\033[44m\]"
C_BG_PURPLE="\[\033[45m\]"
C_BG_CYAN="\[\033[46m\]"
C_BG_LIGHTGRAY="\[\033[47m\]"
OCTO=$'\xf0\x9f\x90\x99'
ARROW=$'\xe2\x9e\x9c'

# Make ls use colors this way
export LSCOLORS=hxfxcxdxbxegedabagacad
export CLICOLOR=1
export PS1="$C_WHITE$OCTO  \u$C_DARKGRAY@$C_CYAN\h $C_LIGHTGRAY: $C_LIGHTGRAY\w$C_LIGHTGREEN\$(parse_git_branch)\n$C_LIGHTGRAY$ARROW $C_DEFAULT"
export EDITOR=vim
export SPLUNK_HOME=/opt/splunk
export GOPATH=~/gowork
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# we so lazy
alias vim="/usr/local/bin/vim" # clipboard
alias metaws="ssh -i ~/.ssh/xandahome.pem ubuntu@metasyn.pw"
alias pyserve="python -m SimpleHTTPServer"
alias gcm="git commit -m"
alias iris='ipython --profile=iris'

alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."

alias rsw='/opt/splunk/bin/splunk restart splunkweb'
alias rsp='/opt/splunk/bin/splunk restart'
alias spip="pip install -r requirements.txt -i https://repo.splunk.com/artifactory/api/pypi/pypi-virtual/simple"
alias orca="docker run --rm -it --name orca -e USER=$USER \
   -v /var/run/docker.sock:/var/run/docker.sock \
   -v $HOME/.orca:/root/.orca \
   -v $HOME/.ssh:/root/.ssh \
   -v \$(pwd -P):/orca-home repo.splunk.com/splunk/products/orca"


function cless () {
  pygmentize -f terminal "$1" | less -R
}

function mcd () {
  mkdir -p $1
  cd $1
}

parse_git_branch() {
         git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
     }
     
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

. ~/code/z/z.sh

eval "$(pyenv init -)"
