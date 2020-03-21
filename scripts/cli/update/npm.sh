#!/bin/bash

# npmでインストールするものリスト
packages=(
    # パッケージ管理
    yarn

    # Markdown
    doctoc # Markdown目次自動生成
    reveal-md # Markdownでプレゼン作成用

    # Web
    # localtunnel # localhostをグローバルに公開
    live-server

    # ユーティリティ
    # wifi-password-cli # wifi-passwordコマンドでwifiのパスワードを表示

    # 開発
    neovim

    # CLI
    undollar # コマンドライン先頭に「$」がついていたらそれを削除する
    trash-cli
    # fkill-cli # インタラクティブにプロセスを選んでkill
)

gem install -g ${packages[@]}
