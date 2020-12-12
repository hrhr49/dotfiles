#!/usr/bin/env bash
set -e

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
    # libreadline6-dev
    libsqlite3-dev
    libssl-dev
    python3-dev
    python3-pip
    sqlite3
    tk-dev
    uuid-dev
    zip
    zlib1g-dev
    # zlibbz2-dev
    bison
    flex

    # 開発
    # ccache # gccやg++の結果をキャッシュしてコンパイルを高速化
    # distcc # 複数のコンピュータで並列にgccやg++を実行できるらしい

    git
    zsh

    # CUI
    w3m
    w3m-img
    lynx
    visidata # スプレッドシート
    pv # パイプの進捗を表示

    # 画像
    libgraph-easy-perl

    # ユーティリティ
    preload # アプリ起動速度を改善
    iftop # ネットワークインタフェースの情報表示
    iptraf-ng # ip通信の情報表示
    aria2 # curlやwgetの高速版(複数のコネクションを使うのでサーバの負荷で迷惑にならないよう気をつける)
    rename # ファイル名変更
    # fzf # brewの方を入れる(fzf.vimの方とのバージョンの関係で、最新のほうが良さそう)

    unar # 圧縮ファイルの解凍
    atool # 圧縮・伸長コマンドのラッパー
    # 圧縮・伸長を並列でやって高速化するやつ(参考 http://mickey-happygolucky.hatenablog.com/entry/2018/04/21/011811)
    pigz
    # pzip2
    # pxz
    entr # ファイルを監視して、変更時にコマンドの実行
)

gui_packages=(
    # polybarの依存 https://gist.github.com/kuznero/f4e983c708cd2bdcadc97be695baacf8
    cmake
    cmake-data
    libcairo2-dev
    libxcb1-dev
    libxcb-ewmh-dev
    libxcb-icccm4-dev
    libxcb-image0-dev
    libxcb-randr0-dev
    libxcb-util0-dev
    libxcb-xkb-dev
    pkg-config
    # python-xcbgen
    python3-xcbgen
    xcb-proto
    libxcb-xrm-dev
    i3-wm
    libasound2-dev
    libmpdclient-dev
    libiw-dev
    libcurl4-openssl-dev
    libpulse-dev
    libxcb-composite0-dev
    xcb
    libxcb-ewmh2

    # QT
    # qtbase5-dev
    # qttools5-dev-tools
    # qt5-default
    # qtcreator

    # alacrittyの依存
    libxcb-shape0-dev
    libxcb-xfixes0-dev

    # gtk
    lxappearance # gtkの見た目を設定

    # gnome
    gnome-tweaks
    # cairo-dock # 下の方にアイコンを置くやつ

    # リモートデスクトップ
    remmina # RDPクライアント

    # 同期
    syncthing

    # QRコード
    qtqr
    qrencode

    # GUI
    rofi              # ウィンドウスイッチャー
    sxiv              # 画像表示
    zathura           # PDF表示
    chromium-browser  # Webブラウザ
    mpv               # 動画・音声再生
    xsel              # クリップボード
    xfce4-terminal    # ターミナル
    mlterm            # ターミナル
    mlterm-im-uim
    mlterm-im-fcitx
    mlterm-im-ibus
    mlterm-im-m17nlib
    mlterm-im-scim
    stterm            # ターミナル
    ffmpegthumbnailer # rangerでのサムネイル
    zenity            # コマンドラインからのGUIダイアログなどの表示
    wmctrl            # ウィンドウマネージャの操作
    xdotool           # ウィンドウ情報

    # i3wmで使用するもの
    i3
    i3status
    i3blocks
    fcitx-mozc
    feh         # 壁紙を表示
    compton     # コンポジットマネージャ。ウィンドウを透明にしたいときなどに必要
    variety     # 壁紙の設定
    pulseaudio  # サウンド
    pavucontrol # サウンド調整GUI
    alsa-utils  # サウンド
    dunst       # 通知表示
    pasystray   # ボリュームアイコン
    rofi        # ウィンドウスイッチャー
    xclip       # クリップボード
    # scrot       # スクリーンショット
    # scrotだと境界線が画像に入ってしまうのでmaimの方を使う
    # https://github.com/dreamer/scrot/issues/2
    maim        # スクリーンショット
    arandr      # マルチディスプレイ設定用
    parcellite  # クリップボードマネージャ
    conky       # 常に表示されるシステムモニタ
    conky-all   # 上に同じ
    gcal        # conkyでのカレンダー表示用

    # ユーティリティ
    urlview # URL抽出。tmux-urlviewに必要。linuxbrewのだとうまく動作しなかった。
    flameshot # スクリーンショット
    meld # 差分ビューア

    # 日本語音声読み上げソフト
    open-jtalk
    open-jtalk-mecab-naist-jdic
    hts-voice-nitech-jp-atr503-m001

    # 自然言語
    mecab # 形態素解析
    icu-devtools # uconvコマンドで、日本語文字列とローマ字を変換できる
    
    # 画像編集
    imagemagick
    pinta
    gimp

    # ベクター画像編集
    inkscape

    # お絵描き
    krita

    # USBカメラ
    # guvcview # 撮影
    # fswebcam # 画像取得

    # ノートPCの省電力用
    powertop
    tlp tlp-rdw
    # TODO: sudo tlp start

    # メモリへのプリロードによるプログラム起動高速化
    preload
)

# GUI環境がある場合はgui_packagesもインストール
if xset q > /dev/null 2>&1; then
  packages=("${packages[@]}" "${gui_packages[@]}")
fi

if type "apt" > /dev/null 2>&1; then
    if type "apt-fast" > /dev/null 2>&1; then
        sudo apt-fast install -y "${packages[@]}"
    else
        sudo apt install -y "${packages[@]}"
    fi
fi
