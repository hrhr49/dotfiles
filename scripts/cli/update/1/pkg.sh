#!/usr/bin/env bash
set -e

# pkgでインストールするものリスト(termux用)
packages=(
  termux-api
  openssh

  bat
  ctags
  curl
  fd
  fzf
  git
  htop
  hub
  jq
  make
  man
  neofetch
  neovim
  nodejs-lts
  perl
  python
  ranger
  lf
  nnn
  ripgrep
  tig
  tmux
  tokei
  tree
  unzip
  vim
  wget
  zoxide
  zsh
)


if type "pkg" > /dev/null 2>&1; then
  pkg install -y "${packages[@]}"
fi
