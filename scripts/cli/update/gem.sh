#!/usr/bin/env bash

# gemでインストールするものリスト
packages=(
    solargraph # Language Server
    neovim
    tmuxinator
)

gem install "${packages[@]}"
