#!/bin/bash

# pipでインストールするものリスト

packages=(
    # ユーティリティ
    csvkit
    watchdog
    pyyaml
    yq # jqのyaml用ラッパー

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
    pynvim
    jedi
    autopep8
    mypy
    pylint
    python-language-server

    # Linux
    pywal # 壁紙に合わせたカラースキームを使用
)

pip install ${packages[@]}
