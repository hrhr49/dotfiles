#!/bin/bash

# brewでインストールするものリスト
formulas=(
    "--without-etcdir zsh"
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
)

for formula in "${formulas[@]}"; do
    brew install $formula
done

echo "all packages are successfully installed!"
