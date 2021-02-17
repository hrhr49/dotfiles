#!/usr/bin/env bash
if type "setxkbmap" > /dev/null 2>&1; then
  # capsキーをctrlキーに
  setxkbmap -option ctrl:nocaps
fi
if type "gsettings" > /dev/null 2>&1; then
  # capsキーをctrlキーに
  gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']"
fi
if type "xset" > /dev/null 2>&1; then
  # 200msで30Hzのキーリピート
  # xset r rate 200 30
  xset r rate 180 50
fi

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
export DefaultIMModule=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"

export QT_QPA_PLATFORMTHEME="qt5ct"
