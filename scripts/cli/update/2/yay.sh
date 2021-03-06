#!/usr/bin/env bash
set -e
packages=(
  nkf
  perl-graph-easy
  gibo
  zoxide-bin
  lf
  pistol-git
  ghq
)

gui_packages=(
)

# GUI環境がある場合はgui_packagesもインストール
if  xset q > /dev/null 2>&1; then
  packages=("${packages[@]}" "${gui_packages[@]}")
fi

if type "yay" > /dev/null 2>&1; then
  yay -S --noconfirm "${packages[@]}"
fi
