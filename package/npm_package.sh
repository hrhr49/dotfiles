#!/bin/bash

# npmでインストールするものリスト
packages=(
    yarn # パッケージマネージャ
    doctoc # Markdown目次自動生成
    # localtunnel # localhostをグローバルに公開
    # wifi-password-cli # wifi-passwordコマンドでwifiのパスワードを表示
    reveal-md # Markdownでプレゼン作成用
    live-server
    neovim
    undollar # コマンドライン先頭に「$」がついていたらそれを削除する
    trash-cli
    fkill-cli # インタラクティブにプロセスを選んでkill
)

for package in "${packages[@]}"; do
    npm install -g $package
done

echo "all packages are successfully installed!"
