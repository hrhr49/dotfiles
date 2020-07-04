#!/bin/bash

# cpanでインストールするものリスト
packages=(
    Graph::Easy
)

cpan install "${packages[@]}"
