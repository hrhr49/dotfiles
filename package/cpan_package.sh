#!/bin/bash

# cpanでインストールするものリスト
packages=(
    Graph::Easy
)

for package in "${packages[@]}"; do
    cpan install $package
done

echo "all packages are successfully installed!"
