#!/usr/bin/env bash
# gnomeの場合はこれを.profileに書かなければいけない
setxkbmap -option ctrl:nocaps
# キーリピートの設定 https://wiki.archlinux.jp/index.php/Xorg_%E3%81%A7%E3%81%AE%E3%82%AD%E3%83%BC%E3%83%9C%E3%83%BC%E3%83%89%E8%A8%AD%E5%AE%9A
# 200msで30Hzのキーリピート
xset r rate 200 30

# 必要ならi3の設定ファイルを動的に作成
# if [ -e $HOME/.config/i3/config.base ]; then
#     if [ -e $HOME/.config/i3/config.local ]; then
#         cat $HOME/.config/i3/config.base $HOME/.config/i3/config.local > $HOME/.config/i3/config
#     fi
# fi

# pywalの前回設定を引き継ぐ
# if type "wal" > /dev/null 2>&1; then
#     wal -R
# fi

#.xinitrc
export DefaultImModule=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
