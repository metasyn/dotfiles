#!/usr/bin/env bash

CURRENT_OS=""
DEBIAN="debian"
MACOS="macos"
ARCH="ARCH"
FORCE=${FORCE:-""}

set -o nounset

function info() {
  echo -n '🌿 '
  echo "$1"
}

function item() {
  justified=$(printf "\033[%sm[%-12s%s] \033[0m" $1 $2)
  $2 | awk -v T="$justified " '{print T  $0}'
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
  if [[ -n $FORCE ]]; then
    return 0
  elif [[ ! -z "$(command -v $1)" ]]; then
    return 1
  else
    return 0
  fi
}

function detect_os() {
  name=$(uname -a)
  if [[ $name == *"Ubuntu"* ]] || [[ $name == *"Debian"* ]]; then
    CURRENT_OS=$DEBIAN
  fi
  if [[ $name == *"Darwin"* ]]; then
    CURRENT_OS=$MACOS
  fi
  if [[ $name == *"ARCH"* ]]; then
    CURRENT_OS=$ARCH
  fi
  if [[ -z $CURRENT_OS ]]; then
    echo "Can't detect distro..."
    exit 1
  fi
  echo "Detected distro: $CURRENT_OS"
}

function os_equals() {
  if [[ -z $CURRENT_OS ]]; then
    detect_os &> /dev/null
  fi

  if [[ $CURRENT_OS == $1 ]]; then
    exit 0
  else
    exit 1
  fi
}


function setup_os() {
  if $(os_equals $MACOS); then
    if $(missing "brew"); then
      info "Getting homebrew..."
      /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
    bash -c "brew update"

  fi

  if $(os_equals $DEBIAN); then
    bash -c "sudo apt-get update"
  fi

  if $(os_equals $ARCH); then
    bash -c "pacman -Syyu"
  fi
}

function pkgmgr() {
  name=$(uname -a)

  if $(os_equals $DEBIAN); then
    bash -c "sudo apt-get $@"
  fi

  if $(os_equals $MACOS); then
    bash -c "brew $@"
  fi

  if $(os_equals $ARCH); then
    bash -c "pacman $@"
  fi
}

function install() {
  if $(os_equals $MACOS); then
    pkgmgr "install $@"
  fi
  if $(os_equals $DEBIAN); then
    pkgmgr "install -y $@"
  fi
  if $(os_equals $ARCH); then
    pkgmgr "-S --noconfirm $@"
  fi
}


delete_and_link() {
    mkdir -p ./.trash
    mv $HOME/$2 .trash/$2 2> /dev/null
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

  delete_and_link vim/.vimrc .vimrc

  if $(missing "nvim"); then


    if $(os_equals $DEBIAN); then
      add-apt-repository ppa:neovim-ppa/stable -y
      apt-get update
    fi;

    install neovim
  fi;

  mkdir -p ~/.config/nvim
  delete_and_link neovim/init.vim .config/nvim/init.vim
}


function setup_zsh() {
  if [[ ! -x "$(command -v antibody)" ]]; then
    info "Getting antibody & zsh stuff..."
    curl -sfL git.io/antibody | sudo sh -s - -b /usr/local/bin
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
    curl https://nim-lang.org/choosenim/init.sh -sSf | sh -s -- -y
  else
    info "Nim is installed."
  fi
}

function setup_node() {
  set -x
  info "Getting node..."

  if $(os_equals $DEBIAN); then
    if $(missing "nodejs"); then
      info "Installing nodejs..."
      add-apt-repository -y -r ppa:chris-lea/node.js
      rm -f /etc/apt/sources.list.d/chris-lea-node_js-*.list || true
      rm -f /etc/apt/sources.list.d/chris-lea-node_js-*.list.save || true
      curl -sSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
      dist="$(lsb_release -s -c)"
      VERSION=node_12.x
      echo "deb https://deb.nodesource.com/$VERSION $dist main" | sudo tee /etc/apt/sources.list.d/nodesource.list
      echo "deb-src https://deb.nodesource.com/$VERSION $dist main" | sudo tee -a /etc/apt/sources.list.d/nodesource.list
      apt-get update
      install nodejs
    else
      info "Nodejs is installed."
    fi
  # Not debian
  else
    if $(missing "node"); then
      install node
    else
      info "Node is installed."
    fi
  fi
}


function setup_tmux() {
  info "Getting tmux stuff..."
  delete_and_link tmux/.tmux.conf .tmux.conf
}

function setup_rust() {
  info "Getting rust..."
  curl https://sh.rustup.rs -sSf | sh
}


function setup_misc() {
  info "Getting dircolors for nicer ls output..."
  delete_and_link terminal/dircolors.ansi-dark .dircolors.ansi-dark

  if $(missing "rg"); then
    info "Installing ripgrep..."
    if $(os_equals $DEBIAN); then
       rg=ripgrep_11.0.2_amd64.deb
       curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/$rg
       sudo dpkg -i ripgrep_11.0.2_amd64.deb
       rm ripgrep*
    else
      install ripgrep
    fi
  else
    info "Ripgrep installed..."
  fi

  info "Git stuff..."
  git config --global push.default current

}

function setup_fonts() {
  info "Getting fonts for powerline..."
  git clone https://github.com/powerline/fonts.git --depth=1 2>&1
  # install
  cd fonts
  ./install.sh
  # clean-up a bit
  cd ..
  rm -rf fonts
}

set +o nounset
