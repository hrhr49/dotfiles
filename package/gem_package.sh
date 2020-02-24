#!/bin/bash

# gemでインストールするものリスト
formulas=(
    tmuxinator
)

for formula in "${formulas[@]}"; do
    gem install $formula
done

echo "all packages are successfully installed!"
