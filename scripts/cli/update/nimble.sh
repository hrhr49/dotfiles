#!/usr/bin/env bash

# aptでインストールするものリスト
packages=(
    # マルチバイト文字を含む文字列の表示幅を取得
    eastasianwidth

    # マルチバイト文字を含む文字列を整列
    alignment

    # 関数から自動でCLIを作成
    cligen

    # REPL
    inim
)

gui_packages=(
    # クロスプラットフォームGUIライブラリ
    # nimxの方はWindowsだと別途SDL2を用意する必要がありそう？
    nigui
)

if  xset q > /dev/null 2>&1 || [ "$(uname)" == 'Darwin' ]; then
  packages=("${packages[@]}" "${gui_packages[@]}")
fi

if type "nimble" > /dev/null 2>&1; then
    nimble install -y "${packages[@]}"
fi
