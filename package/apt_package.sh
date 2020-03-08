#!/bin/bash

# aptでインストールするものリスト
packages=(
    build-essential
    gfortran
    libbz2-dev
    libdb-dev
    libffi-dev
    libgdbm-dev
    liblapack-dev
    liblzma-dev
    libncursesw5-dev
    libreadline-dev
    libreadline6-dev
    libsqlite3-dev
    libssl-dev
    python3-dev
    python3-pip
    sqlite3
    tk-dev
    uuid-dev
    zip
    zlib1g-dev
    zlibbz2-dev

    # CUI
    w3m

    # GUI
    rofi
    sxiv
    zathura
    chromium-browser
    mpv
    xsel
    xfce4-terminal
    ffmpegthumbnailer
    wmctrl

    # i3wmで使用するもの
    i3
    fcitx-mozc
    feh
    compton
    variety
    alsa-utils
    dunst
    pasystray
    rofi
    xclip
    scrot
)

for package in "${packages[@]}"; do
    sudo apt install -y $package
done
echo "all packages are successfully installed!"
