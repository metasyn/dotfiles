#!/usr/bin/env bash

set -o nounset

function info() {
  echo -n '🌿 '
  echo "$1"
}

function item() {
  justified=$(printf "[%-15s%s] " $1)
  $1 | awk -vT="$justified " '{print T  $0}'
  echo
}

function check() {
  if [[ ! -z "$(command -v $1)" ]]; then
    return 1
  else
    return 0
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
  if $(check "pyenv"); then
    info "Getting pyenv..." 
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv
  else
    info "Pyenv is installed."
  fi
}

function setup_nim() {
  if $(check "nim") ; then
    info "Getting nim..."
    curl https://nim-lang.org/choosenim/init.sh -sSf | sh
  else
    info "Nim is installed."
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
  "setup_zsh"
  "setup_vim"
  "setup_python"
  "setup_nim"
  "setup_tmux"
  "setup_misc"
)

for setup in ${setups[@]}; do
  item $setup
done

echo "🎉 All done!"
