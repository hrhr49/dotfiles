#!/usr/bin/env bash
set -e

if type "vim" > /dev/null 2>&1; then
  # 「警告: 端末からの入力ではありません」を暫定的に回避する
  # vim-plug
  echo dummy | vim -c 'PlugInstall|qa!' -

  # coc.nvimの更新
  # 先にディレクトリ作っておかないと、Vim側でディレクトリ作成時にENTERキー入力待ちになってしまう。
  mkdir -p ~/.config/coc
  # vimrcのg:coc_global_extensionsのを全部Installする。dockerビルド時だと、何も表示されない時間が数分続いたけど、ちゃんとできていた。
  echo dummy | vim -c 'execute "CocInstall -sync " . join(g:coc_global_extensions, " ")|qa!' -
fi
