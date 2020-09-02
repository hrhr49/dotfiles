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


    # Linux
    pywal # 壁紙に合わせたカラースキームを使用
)

pip install "${packages[@]}"
