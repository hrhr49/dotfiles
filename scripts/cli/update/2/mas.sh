#!/usr/bin/env bash
set -e

# mas(App Storeのアプリ)でインストールするものリスト
# TODO: ちゃんと動作するようにする

# packages=(
#   418073146  # Snap: Cmd + 数字でアプリ起動・切り替え
#   931571202  # QuickShade: 外部ディスプレイの輝度調整
# )


# if [ "$(uname)" == 'Darwin' ]; then
#   if type "mas" > /dev/null 2>&1; then
#     for package in "${packages[@]}"; do
#       mas install "$package"
#     done
#   fi
# fi
