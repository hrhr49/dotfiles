# .profileの内容
# 注意:どうもGUI環境のない状態でzshをインタラクティブシェルとして使うと
# .profileが読み込まれないみたい

setxkbmap -option ctrl:nocaps
# キーリピートの設定 https://wiki.archlinux.jp/index.php/Xorg_%E3%81%A7%E3%81%AE%E3%82%AD%E3%83%BC%E3%83%9C%E3%83%BC%E3%83%89%E8%A8%AD%E5%AE%9A
# 200msで30Hzのキーリピート
xset r rate 200 30


# homebrew経由のpython3をデフォルトで使用するように、PATHの先頭にpython3のパスを追加
# if [ -d "/home/linuxbrew/.linuxbrew/opt/python@3/libexec/bin" ] ; then
#   export PATH="/home/linuxbrew/.linuxbrew/opt/python@3/libexec/bin:$PATH"
# fi

# gnomeがいるときにはxinitrcが無視される可能性があるため,明示的に.profileから呼び出す
# [ -e "$HOME/.xinitrc" ] && source "$HOME/.xinitrc"


[ -d "$HOME/bin" ] && export PATH=$PATH:~/bin

if type "alacritty" > /dev/null 2>&1; then
    export TERMINAL="alacritty"
fi

if type "xfce4-terminal" > /dev/null 2>&1; then
    export TERMINAL="xfce4-terminal"
fi
