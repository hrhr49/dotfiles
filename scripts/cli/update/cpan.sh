#!/usr/bin/env bash

# cpanでインストールするものリスト
packages=(
    Graph::Easy
)

if type "cpan" > /dev/null 2>&1; then
  cpan install "${packages[@]}"
fi
