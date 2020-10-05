#!/usr/bin/env bash

if type "vim" > /dev/null 2>&1; then
  # vim-plug
  vim -c 'PlugInstall|qa'

  # 以下を行うと、端末の入力がおかしくなるので一旦保留
  # coc.nvimの更新
  # 先にディレクトリ作っておかないと、Vim側でディレクトリ作成時にENTERキー入力待ちになってしまう。
  # mkdir -p ~/.config/coc
  # vimrcのg:coc_global_extensionsのを全部Installする。dockerビルド時だと、何も表示されない時間が数分続いたけど、ちゃんとできていた。
  # vim -c 'execute "CocInstall -sync " . join(g:coc_global_extensions, " ")|qa'
fi
