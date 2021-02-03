#!/usr/bin/env bash
source tools.sh

if [[ -n $DEBUG ]]; then
  trap '(read -p "[$BASH_SOURCE:$LINENO - ${FUNCNAME[0]}] $BASH_COMMAND?")' DEBUG
fi

set -o nounset

declare -a setups=(
  "setup_os"
  "setup_zsh"
  "setup_vim"
  "setup_python"
  "setup_nim"
  "setup_node"
  "setup_golang"
  "setup_tmux"
  "setup_fonts"
  "setup_misc"
)

detect_os

for setup in ${setups[@]}; do
  item "$(random_color)" $setup
done

echo "🎉 All done!"
