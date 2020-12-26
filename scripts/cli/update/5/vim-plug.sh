#!/usr/bin/env bash
set -e

if type "vim" > /dev/null 2>&1; then
  # vim-plug
  vim -c 'PlugInstall' -c 'q' -c 'q'

  # coc.nvimの更新
  # 先にディレクトリ作っておかないと、Vim側でディレクトリ作成時にENTERキー入力待ちになってしまう。
  mkdir -p ~/.config/coc
  # vimrcのg:coc_global_extensionsのを全部Installする。dockerビルド時だと、何も表示されない時間が数分続いたけど、ちゃんとできていた。
  vim -c 'execute "CocInstall -sync " . join(g:coc_global_extensions, " ")' -c 'q' -c 'q'
fi

# 端末の表示がおかしくなるのをリセット
reset
