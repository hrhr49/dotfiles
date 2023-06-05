#!/usr/bin/env bash
set -e

# pipでインストールするものリスト

packages=(
    # ユーティリティ
    csvkit
    csvtotable # csvファイルから、ソートやフィルタ可能ないい感じのHTMLを生成
    watchdog
    pyyaml
    yq # jqのyaml用ラッパー
    rich # コンソールでリッチテキスト
    trypackage # パッケージをお試しで使う

    # 環境管理
    pipenv
    poetry

    # CLI
    mdv # Markdown表示
    percol # インタラクティブな絞り込み
    ranger-fm # ファイルマネージャ

    # 開発環境
    neovim
    flask
    pyflakes
    flake8
    pynvim
    jedi
    autopep8
    mypy
    pylint
    python-language-server

    # デバッグ
    better_exceptions  # 例外のメッセージをより詳しく
    icecream  # print関数よりもいい感じの表示

    # # 機械学習関連で使うやつ
    # jupytext
    # numpy
    # pandas
    # matplotlib

    # その他
    requests
    jinja2
    flask
    beautifulsoup4

    # # 音声関連
    # librosa # 音声信号処理
    # pyworld # 音声解析

    # 入れるかどうか検討
    # dominate # htmlを作るためのDSL

    # AWS
    ec2instanceconnectcli  # インスタンスID指定でssh接続

    # 競技プログラミングのオンラインジャッジ
    online-judge-tools

    streamlit
)

gui_packages=(
    # Linux
    pywal # 壁紙に合わせたカラースキームを使用
    simpleaudio # 音声再生
)

# GUI環境がある場合はgui_packagesもインストール
if  xset q > /dev/null 2>&1 || [ "$(uname)" == 'Darwin' ]; then
  packages=("${packages[@]}" "${gui_packages[@]}")
fi

if type "pip" > /dev/null 2>&1; then
  pip install --no-warn-script-location "${packages[@]}"
fi
if type "pip3" > /dev/null 2>&1; then
  pip3 install --no-warn-script-location "${packages[@]}"
fi
