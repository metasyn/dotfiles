#!/usr/bin/env bash

set -o errexit
set -o nounset

function check() {
  if [[ ! -z "$(command -v $1)" ]]; then
    return 1
  else
    return 0
  fi
}

function setup_python() {
  if $(check "pyenv"); then
    echo "Getting pyenv..." 
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv
  else
    echo "Pyenv is installed."
  fi
}

function setup_nim() {
  if $(check "nim") ; then
    echo "Getting nim..."
    curl https://nim-lang.org/choosenim/init.sh -sSf | sh
  else
    echo "Nim is installed."
  fi
}

setup_python
setup_nim
