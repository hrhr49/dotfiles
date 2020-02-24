#!/bin/bash

# pipでインストールするものリスト
packages=(
    csvkit
    pipenv
    # watchdog
    neovim
    autopep8
    mypy
    pylint
    pyyaml
    python-language-server
)

for package in "${packages[@]}"; do
    pip install $package
done

echo "all packages are successfully installed!"
