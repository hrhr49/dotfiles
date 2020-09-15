# .profileの内容
# 注意:どうもGUI環境のない状態でzshをインタラクティブシェルとして使うと
# .profileが読み込まれないみたい

if type "setxkbmap" > /dev/null 2>&1; then
  # capsキーをctrlキーに
  setxkbmap -option ctrl:nocaps
fi
if type "xset" > /dev/null 2>&1; then
  # 200msで30Hzのキーリピート
  xset r rate 200 30
fi


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
