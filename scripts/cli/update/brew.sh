#!/bin/bash

# brewでインストールするものリスト
formulas=(
    # シェル
    # "--without-etcdir zsh"
    # zsh
    # zsh-completions

    # バージョン管理
#    git
    ghq
    hub
    tig

    # 文字コード
    nkf

    # 表示
    tree
    htop
    bat
    exa # lsのいい感じバージョン

    # 開発 効率化
    direnv
    ctags

    # テキストエディタ
    neovim
    kakoune # vim インスパイアなエディタ
    micro # ベーシックな感じのキーバインドのエディタ。nanoの代わりに使えそう？

    # TUI
    # ranger # localeの設定がうまく行ってない？のでpipの方で入れる(https://github.com/ranger/ranger/issues/937)
    tmux
    sc-im # スプレッドシート

    # Markdown
    mdp # CLIでのプレゼンツール

    # 検索
    ripgrep
    the_silver_searcher
    fzf
    peco
    fd

    # 各種言語
    ruby
    node
    go
    rust
    perl
    # python3
    lua
    nim

    # ユーティリティ
    fasd
    httpie    # curlのようなやつ
    trash-cli # ゴミ箱操作
    jq        # JSONをいい感じにフィルター
    fx        # jqみたいだけどインタラクティブにできたりする
    navi      # チートシート
    bitwise   # ビット表示

    # 図形作成
    graphviz
    plantuml
    ditaa

    # 文書
    pandoc
    # redpen # 文章校正

    # 見た目
    figlet   # 文字をアスキーアートで出すやつ
    neofetch # アスキーアートでOSのアイコン出す
    emojify  # 絵文字を入力するため
)

installed_formulas=$(brew list)

# インストールしていないものだけインストール
# 直接installコマンドに与えると警告やエラーが出るので、それを回避
for formula in "${formulas[@]}"; do
    if echo $installed_formulas | grep $formula > /dev/null 2>&1; then
        echo "$formula already exists"
    else
        brew install $formula
    fi
done
