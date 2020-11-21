#!/usr/bin/env bash
set -e

# npmでインストールするものリスト
packages=(
    # パッケージ管理
    yarn

    # Markdown
    doctoc    # Markdown目次自動生成
    textlint  # 文章校正
    textlint-rule-preset-ja-technical-writing
    textlint-rule-spellcheck-tech-word
    # mdr       # CLIでいい感じに表示 # pipのmdvの方を使う

    daff # csvのdiff

    # 開発
    neovim
    json-server # とりあえずJSONを返すモックがほしいときに使う
    json2csv
    jsondiffpatch

    # CLI
    undollar # コマンドライン先頭に「$」がついていたらそれを削除する
    trash-cli
    # fkill-cli # インタラクティブにプロセスを選んでkill
    # cli-scrape # htmlのタグ抽出

    slack-tui # slackのtui
)

gui_packages=(
    reveal-md # Markdownでプレゼン作成用
    # Web
    # localtunnel # localhostをグローバルに公開
    live-server

    # ユーティリティ
    # wifi-password-cli # wifi-passwordコマンドでwifiのパスワードを表示
)

# GUI環境がある場合はgui_packagesもインストール
if  xset q > /dev/null 2>&1 || [ "$(uname)" == 'Darwin' ]; then
  packages=("${packages[@]}" "${gui_packages[@]}")
fi

if type "npm" > /dev/null 2>&1; then
  npm install -g "${packages[@]}"
fi
