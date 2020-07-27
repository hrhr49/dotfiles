#!/usr/bin/env bash

# aptでインストールするものリスト
packages=(
    # クロスプラットフォームGUIライブラリ
    # nimxの方はWindowsだと別途SDL2を用意する必要がありそう？
    nigui
)

if type "nimble" > /dev/null 2>&1; then
    nimble install -y "${packages[@]}"
fi
