#!/usr/bin/env bash
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
  rust
  nim
  nimble
  perl

  # development tools
  zsh
  vim
  # neovim # yayの方で入れる
  python-pynvim
  # tmux # yayの方で入れる
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
  scrot
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
  sudo pacman -Syyu --noconfirm "${packages[@]}"
fi
