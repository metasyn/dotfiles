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
delete_and_link zsh/.zshrc .zshrc
delete_and_link zsh/.zsh_plugins.txt .zsh_plugins.txt

# z.sh
delete_and_link z.sh .z.sh
