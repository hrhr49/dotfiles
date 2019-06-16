# gnomeの場合はこれを.profileに書かなければいけない
setxkbmap -option ctrl:nocaps
# キーリピートの設定 https://wiki.archlinux.jp/index.php/Xorg_%E3%81%A7%E3%81%AE%E3%82%AD%E3%83%BC%E3%83%9C%E3%83%BC%E3%83%89%E8%A8%AD%E5%AE%9A
# 200msで30Hzのキーリピート
xset r rate 50 60
#.xinitrc
export DefaultImModule=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
