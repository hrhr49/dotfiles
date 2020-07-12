#!/usr/bin/env bash

# cpanでインストールするものリスト
packages=(
    Graph::Easy
)

cpan install "${packages[@]}"
