#!/bin/bash

delete_and_link() {
    rm -r $HOME/$2
    echo "Linking $PWD/$1 to $HOME/$2"
    ln -s $PWD/$1 $HOME/$2
  }

# Vim setup
curl -fLo ./vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
delete_and_link vim .vim
delete_and_link vim/.vimrc .vimrc

# zsh setup
curl -sfL git.io/antibody | sh -s - -b /usr/local/bin
delete_and_link zsh/.zshrc .zshrc
delete_and_link zsh/.zsh_plugins.txt .zsh_plugins.txt

# tmux
delete_and_link tmux/.tmux.conf .tmux.conf

# alacritty
mkdir -p $HOME/.config/alacritty
delete_and_link alacritty/alacritty.yml .config/alacritty/alacritty.yml

# z.sh
delete_and_link z.sh .z.sh

# colors
delete_and_link terminal/dircolors.ansi-dark .dircolors.ansi-dark
