#!/usr/bin/env bash
set -e

# gemでインストールするものリスト
packages=(
    solargraph # Language Server
    neovim
    tmuxinator
)

if type "gem" > /dev/null 2>&1; then
  gem install "${packages[@]}"
fi
