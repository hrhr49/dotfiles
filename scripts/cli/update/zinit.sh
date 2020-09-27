#!/usr/bin/env bash

if type "zsh" > /dev/null 2>&1; then
  # 一旦、zshをインタラクティブモードで起動することで、zinitのパッケージインストール処理を実施する。
  zsh -i -c exit
fi

