#!/usr/bin/env bash

set -o errexit
set -o nounset

delete_and_link() {
    rm -r $HOME/$2 2> /dev/null
    echo "Linking $PWD/$1 to $HOME/$2"
    ln -s $PWD/$1 $HOME/$2
  }

function setup_vim() {
  echo
  echo "Getting vim plug..."
  curl -fLo ./vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  delete_and_link vim .vim
  delete_and_link vim/.vimrc .vimrc

  mkdir -p ~/.config/nvim
  delete_and_link neovim/init.vim .config/nvim/init.vim
}


function setup_zsh() {
  echo
  echo "Getting antibody & zsh stuff..."
  [[ ! -x "$(command -v antibody)" ]] && curl -sfL git.io/antibody | sh -s - -b /usr/local/bin

  delete_and_link zsh/.zshrc .zshrc
  delete_and_link zsh/.zsh_plugins.txt .zsh_plugins.txt
}

function setup_tmux() {
  echo
  echo "Getting tmux stuff..."
  delete_and_link tmux/.tmux.conf .tmux.conf
}

# z.sh
function setup_misc() {
  echo
  echo "Getting z.sh..."
  delete_and_link z.sh .z.sh

  echo
  echo "Getting dircolors for nicer ls output..."
  delete_and_link terminal/dircolors.ansi-dark .dircolors.ansi-dark
}

setup_zsh
setup_vim
setup_tmux
setup_misc

