#!/bin/bash

# npmでインストールするものリスト
packages=(
    doctoc # Markdown目次自動生成
)

for package in "${packages[@]}"; do
    npm install $package
done

echo "all packages are successfully installed!"
