#!/usr/bin/env bash

# cargoでインストールするものリスト
packages=(
  alacritty
  ripgrep
  bat
  fd-find
  tokei
  lsd
  zoxide
  hexyl
  silicon
  du-dust
  hyperfine
  ytop
)

if type "cargo" > /dev/null 2>&1; then
  cargo install "${packages[@]}"
fi
