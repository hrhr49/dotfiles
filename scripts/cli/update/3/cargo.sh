#!/usr/bin/env bash
set -e

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
  cargo-edit  # Cargo.tomlの編集用, add, rm, upgradeなどのサブコマンドを追加する。
  cargo-generate  # テンプレートリポジトリからプロジェクトを始める
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
