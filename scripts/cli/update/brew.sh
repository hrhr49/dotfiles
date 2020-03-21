#!/bin/bash

# brewでインストールするものリスト
formulas=(
    # シェル
    # "--without-etcdir zsh"
    # zsh
    zsh-completions

    # バージョン管理
#    git
    ghq
    hub

    # 表示
    tree
    htop
    bat
    exa # lsのいい感じバージョン

    # 開発 効率化
    direnv
    ctags
    neovim

    # TUI
    ranger
    tmux

    # 検索
    ripgrep
    the_silver_searcher
    fzf
    fasd

    # 各種言語
    ruby
    node
    go
    rust
    perl
#    python3

    # ユーティリティ

    httpie # curlのようなやつ
    mdp # CLIでのプレゼンツール
    trash-cli # ゴミ箱操作
    jq
    fx # jqみたいだけどインタラクティブにできたりする
    navi # チートシート
    bitwise # ビット表示

    # 文書・図形作成
    graphviz
    plantuml
    pandoc
    ditaa

    # 見た目
    figlet # 文字をアスキーアートで出すやつ
    neofetch # アスキーアートでOSのアイコン出す
    emojify # 絵文字を入力するため
)

brew install ${formulas[@]}
