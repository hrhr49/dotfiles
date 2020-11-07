#!/usr/bin/env bash

# pipでインストールするものリスト

packages=(
    # ユーティリティ
    csvkit
    csvtotable # csvファイルから、ソートやフィルタ可能ないい感じのHTMLを生成
    watchdog
    pyyaml
    yq # jqのyaml用ラッパー
    rich # コンソールでリッチテキスト

    # 環境管理
    pipenv

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
    better_exceptions

    # 機械学習関連で使うやつ
    jupytext
    numpy
    pandas
    matplotlib

    # その他
    requests
    jinja2
    flask
    beautifulsoup4

    # 音声関連
    librosa # 音声信号処理
    pyworld # 音声解析
    simpleaudio # 音声再生
)

gui_packages=(
    # Linux
    pywal # 壁紙に合わせたカラースキームを使用
)

# GUI環境がある場合はgui_packagesもインストール
if  xset q > /dev/null 2>&1 || [ "$(uname)" == 'Darwin' ]; then
  packages=("${packages[@]}" "${gui_packages[@]}")
fi

if type "pip" > /dev/null 2>&1; then
  pip install "${packages[@]}"
fi
