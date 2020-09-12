#!/usr/bin/env bash

# cargoでインストールするものリスト
packages=(
  ripgrep
  bat
  fd-find
  tokei
  lsd
  zoxide
  hexyl
  du-dust
  hyperfine
  ytop
)

gui_packages=(
  alacritty
  silicon
)

if  xset q > /dev/null 2>&1 || [ "$(uname)" == 'Darwin' ]; then
  packages=("${packages[@]}" "${gui_packages[@]}")
fi

# 一時的にコメントアウト
# if type "cargo" > /dev/null 2>&1; then
#   cargo install "${packages[@]}"
# fi
