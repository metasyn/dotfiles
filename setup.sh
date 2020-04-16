#!/usr/bin/env bash
source tools.sh
set -o nounset

declare -a setups=(
  "setup_os"
  "setup_zsh"
  "setup_vim"
  "setup_python"
  "setup_nim"
  "setup_node"
  "setup_tmux"
  "setup_fonts"
  "setup_misc"
)

detect_os

for setup in ${setups[@]}; do
  item "$(random_color)" $setup
done

echo "🎉 All done!"
