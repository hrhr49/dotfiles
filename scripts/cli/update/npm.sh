#!/bin/bash

# npmでインストールするものリスト
packages=(
    # パッケージ管理
    yarn

    # Markdown
    doctoc    # Markdown目次自動生成
    reveal-md # Markdownでプレゼン作成用
    textlint  # 文章校正
    # mdr       # CLIでいい感じに表示 # pipのmdvの方を使う

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

npm install -g ${packages[@]}
