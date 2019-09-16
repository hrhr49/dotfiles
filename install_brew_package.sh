#!/bin/bash

# パッケージマネージャでインストールできないもののみにしておく
formulas=(
    "--without-etcdir zsh"
    git
    tree
    htop
    ctagsk
    node
    python3
    neovim
    ripgrep
    ag
    fzf
    fasd
    ranger
)

for formula in "${formulas[@]}"; do
    brew install $formula
done

echo "all packages are successfully installed!"
