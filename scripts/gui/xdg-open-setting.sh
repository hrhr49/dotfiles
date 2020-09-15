#!/usr/bin/env bash

# xdg-openで開くアプリの設定
# 参考: 
# https://qiita.com/apu4se/items/ff7efd8d351e09bb9b54
# https://developer.mozilla.org/ja/docs/Web/HTTP/Basics_of_HTTP/MIME_types/Common_types

# 画像
xdg-mime default sxiv.desktop image/jpg
xdg-mime default sxiv.desktop image/jpeg
xdg-mime default sxiv.desktop image/png

xdg-mime default org.pwmt.zathura.desktop application/pdf

xdg-mime default google-chrome.desktop text/html

xdg-mime default mpv.desktop audio/mpeg
xdg-mime default mpv.desktop audio/wav
xdg-mime default mpv.desktop audio/webm

xdg-mime default mpv.desktop video/mpeg
xdg-mime default mpv.desktop video/webm
