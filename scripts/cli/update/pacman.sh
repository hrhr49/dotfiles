#!/usr/bin/env bash
set -e
packages=(
  # basic commands
  which
  curl
  wget
  man
  zip
  unzip
  tree

  # development environment
  python
  python-pip
  make
  cmake
  gcc
  nodejs
  npm
  yarn
  ruby
  rubygems
  go
  rustup
  nim
  nimble
  perl
  llvm
  llvm-libs
  llvm10
  llvm10-libs

  # development tools
  zsh
  vim
  neovim
  python-pynvim
  tmux
  git
  shellcheck
  ctags

  # utility
  fzf
  ripgrep
  ranger
  imagemagick
  aria2
  pigz
  entr
  # fasd
  hub
  bat
  tig
  tokei
  tldr
  fd
  jq
  htop
  unarchiver

  # other
  neofetch
  w3m
  catimg
)

gui_packages=(
  rofi
  otf-ipafont
  adobe-source-han-sans-jp-fonts
  alacritty
  sxiv
  zathura
  mpv
  xfce4-terminal
  zenity
  xdotool
  dunst
  # scrot
  maim
  xclip
  feh
  compton
  variety
  chromium

  fcitx-mozc
  fcitx-gtk2
  fcitx-gtk3
  fcitx-qt5
  fcitx-im
)

# GUI環境がある場合はgui_packagesもインストール
if  xset q > /dev/null 2>&1; then
  packages=("${packages[@]}" "${gui_packages[@]}")
fi

if type "pacman" > /dev/null 2>&1; then
  sudo pacman -S --noconfirm "${packages[@]}"
fi
