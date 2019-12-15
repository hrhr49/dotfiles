#!/bin/bash

# パッケージマネージャでインストールできないもののみにしておく
formulas=(
    # "--without-etcdir zsh"
#    git
#    tree
#    htop
#    ctagsk
    node
#    python3
    neovim
    ripgrep
#    ag
#    fzf
    fasd
#    ranger
    bat
    ghq
    hub
)

for formula in "${formulas[@]}"; do
    brew install $formula
done

echo "all packages are successfully installed!"
