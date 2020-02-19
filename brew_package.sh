#!/bin/bash

# brewでインストールするものリスト
formulas=(
    # "--without-etcdir zsh"
    zsh
#    git
    tree
    htop
    ctagsk
    node
#    python3
    neovim
    ripgrep
#    ag
    fzf
    fasd
    ranger
    bat
    ghq
    hub
    zsh-completions
    tmux
    ruby
    go
    rust
    httpie # curlのようなやつ
    mdp # CLIでのプレゼンツール
    trash-cli # ゴミ箱操作
    figlet # 文字をアスキーアートで出すやつ
    neofetch # アスキーアートでOSのアイコン出す
    jq
    fx # jqみたいだけどインタラクティブにできたりする
    navi # チートシート
    exa # lsのいい感じバージョン
)

for formula in "${formulas[@]}"; do
    brew install $formula
done

echo "all packages are successfully installed!"
