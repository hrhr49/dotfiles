#!/usr/bin/env bash
packages=(
    fzf
    zsh
    vim
    neovim
    tmux
    git
    w3m
    imagemagick
    aria2
    pigz
    entr
    nodejs
    npm
    ruby

    unzip
    shellcheck
    hub
    bat
    tig

    tokei
    tldr
    fd
    fasd

    jq
    neofetch
    go
    rust
    nim
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
    sudo pacman -S "${packages[@]}"
fi
