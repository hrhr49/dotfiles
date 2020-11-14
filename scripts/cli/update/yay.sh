#!/usr/bin/env bash
packages=(
  nkf
  perl-graph-easy
  gibo
  neovim-git
  tmux-git
)

gui_packages=(
)

# GUI環境がある場合はgui_packagesもインストール
if  xset q > /dev/null 2>&1; then
  packages=("${packages[@]}" "${gui_packages[@]}")
fi

if type "yay" > /dev/null 2>&1; then
  yay -Syyu --noconfirm "${packages[@]}"
fi
