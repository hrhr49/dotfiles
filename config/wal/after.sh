#!/usr/bin/env bash

# dunstの設定
mkdir -p "${HOME}/.config/dunst/"
ln -sf "${HOME}/.cache/wal/dunstrc" "${HOME}/.config/dunst/dunstrc"

# dunstを再起動
pkill dunst
dunst &
