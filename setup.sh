#!/usr/bin/env bash

DISTRO=

set -o nounset

function info() {
  echo -n '🌿 '
  echo "$1"
}

function item() {
  justified=$(printf "\033[%sm[%-12s%s] \033[0m" $1 $2)
  $2 | awk -vT="$justified " '{print T  $0}'
  echo
}

function random_color() {
  RED='0;31'
  GREEN='0;32'
  ORANGE='0;33'
  BLUE='0;34'
  PURPLE='0;35'
  CYAN='0;36'
  LIGHTRED='1;31'
  LIGHTGREEN='1;32'
  YELLOW='1;33'
  LIGHTBLUE='1;34'
  LIGHTPURPLE='1;35'
  LIGHTCYAN='1;36'
  WHITE='1;37'

  declare -a colors=(
    $RED
    $GREEN
    $ORANGE
    $BLUE
    $PURPLE
    $CYAN
    $LIGHTRED
    $LIGHTGREEN
    $YELLOW
    $LIGHTBLUE
    $LIGHTPURPLE
    $LIGHTCYAN
    $WHITE
  )
  size=${#colors[@]}
  idx=$(($RANDOM % $size))
  echo ${colors[$idx]}
}

function missing() {
  if [[ ! -z "$(command -v $1)" ]]; then
    return 1
  else
    return 0
  fi
}

function setup_os() {
  name=$(uname -a)
  if [[ $name == *"Ubuntu"* ]] || [[ $name == *"Debian" ]]; then
    DISTRO=debian
    bash -c "sudo apt-get update"
  fi
  if [[ $name == *"Darwin"* ]]; then
    DISTRO=macos

    if $(missing "brew"); then
      info "Getting homebrew..."
      /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

  fi
}

function pkgmgr() {
  name=$(uname -a)
  if [[ $DISTRO == "debian" ]]; then
    bash -c "sudo apt-get $@"
  fi

  if [[ $DISTRO == "macos" ]]; then
    bash -c "brew $@"
  fi
}

function install() {
  name=$(uname -a)
  if [[ $name == *"Darwin"* ]]; then
    pkgmgr "install $@"
  else
    pkgmgr "install -y $@"
  fi
}


delete_and_link() {
    rm -r $HOME/$2 2> /dev/null
    echo "🔗 Linking $PWD/$1 to $HOME/$2"
    ln -s $PWD/$1 $HOME/$2
  }

function setup_vim() {
  DIR="./vim/autoload/plug.vim"
  if [[ -f $DIR ]]; then
    info "Vim plug installed..."
  else
    info "Getting vim plug..."
    curl -fLo ./vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi

  delete_and_link vim .vim
  delete_and_link vim/.vimrc .vimrc

  mkdir -p ~/.config/nvim
  delete_and_link neovim/init.vim .config/nvim/init.vim
}


function setup_zsh() {
  if [[ ! -x "$(command -v antibody)" ]]; then
    info "Getting antibody & zsh stuff..."
    curl -sfL git.io/antibody | sh -s - -b /usr/local/bin
  else
    info "Antibody installed..."
  fi

  delete_and_link zsh/.zshrc .zshrc
  delete_and_link zsh/.zsh_plugins.txt .zsh_plugins.txt
}


function setup_python() {
  if $(missing "pyenv"); then
    info "Getting pyenv..." 
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv
  else
    info "Pyenv is installed."
  fi
}

function setup_nim() {
  if $(missing "nim") ; then
    info "Getting nim..."
    curl https://nim-lang.org/choosenim/init.sh -sSf | sh
  else
    info "Nim is installed."
  fi
}

function setup_node() {
  if $(missing "node"); then
    install nodejs
  fi
  if $(missing "npm"); then
    install npm
  fi
}


function setup_tmux() {
  info "Getting tmux stuff..."
  delete_and_link tmux/.tmux.conf .tmux.conf
}

# z.sh
function setup_misc() {
  info "Getting z.sh..."
  delete_and_link z.sh .z.sh

  info "Getting dircolors for nicer ls output..."
  delete_and_link terminal/dircolors.ansi-dark .dircolors.ansi-dark
}

declare -a setups=(
  "setup_os"
  "setup_zsh"
  "setup_vim"
  "setup_python"
  "setup_nim"
  "setup_node"
  "setup_tmux"
  "setup_misc"
)

for setup in ${setups[@]}; do
  item "$(random_color)" $setup
done

echo "🎉 All done!"
