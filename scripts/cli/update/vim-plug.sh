#!/usr/bin/env bash
set -e

if type "vim" > /dev/null 2>&1; then
  # *「警告: 端末からの入力ではありません」を暫定的に回避する
  #     vimコマンドの引数に - をつけて確かめる
  # * 「続けるにはENTERを押すかコマンドを入力してください」を回避する
  #     次のURLを参照
  #     https://scrapbox.io/uochan/vim_%E3%81%A7_echo_%E6%99%82%E3%81%AB%E3%80%8C%E7%B6%9A%E3%81%91%E3%82%8B%E3%81%AB%E3%81%AFENTER%E3%82%92%E6%8A%BC%E3%81%99%E3%81%8B%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%82%92%E5%85%A5%E5%8A%9B%E3%81%97%E3%81%A6%E3%81%8F%E3%81%A0%E3%81%95%E3%81%84%E3%80%8D%E3%82%92%E5%87%BA%E3%81%95%E3%81%AA%E3%81%84
  # vim-plug
  echo dummy | vim -c 'let max_length = v:echospace + ((&cmdheight - 1) * &columns)|PlugInstall|qa!' -

  # coc.nvimの更新
  # 先にディレクトリ作っておかないと、Vim側でディレクトリ作成時にENTERキー入力待ちになってしまう。
  mkdir -p ~/.config/coc
  # vimrcのg:coc_global_extensionsのを全部Installする。dockerビルド時だと、何も表示されない時間が数分続いたけど、ちゃんとできていた。
  echo dummy | vim -c 'let max_length = v:echospace + ((&cmdheight - 1) * &columns)|execute "CocInstall -sync " . join(g:coc_global_extensions, " ")|qa!' -
fi
