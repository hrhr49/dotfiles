#!/bin/bash

# pipでインストールするものリスト
packages=(
    csvkit
    pipenv
    # watchdog
)

for package in "${packages[@]}"; do
    pip install $package
done

echo "all packages are successfully installed!"
