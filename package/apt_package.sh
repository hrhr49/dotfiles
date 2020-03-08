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

    git
    zsh

    # CUI
    w3m

    # GUI
    rofi              # ウィンドウスイッチャー
    sxiv              # 画像表示
    zathura           # PDF表示
    chromium-browser  # Webブラウザ
    mpv               # 動画・音声再生
    xsel              # クリップボード
    xfce4-terminal    # ターミナル
    ffmpegthumbnailer # rangerでのサムネイル
    zenity            # コマンドラインからのGUIダイアログなどの表示
    wmctrl            # ウィンドウマネージャの操作
    xdotool           # ウィンドウ情報

    # i3wmで使用するもの
    i3
    fcitx-mozc
    feh        # 壁紙を表示
    compton    # コンポジットマネージャ。ウィンドウを透明にしたいときなどに必要
    variety    # 壁紙の設定
    alsa-utils # サウンド
    dunst      # 通知表示
    pasystray  # ボリュームアイコン
    rofi       # ウィンドウスイッチャー
    xclip      # クリップボード
    scrot      # スクリーンショット
    arandr     # マルチディスプレイ設定用
)

for package in "${packages[@]}"; do
    sudo apt install -y $package
done
echo "all packages are successfully installed!"
