#!/usr/bin/env bash

if type "brew" > /dev/null 2>&1; then
    echo 'brew already exists'
    exit
fi

# brewインストールに必要パッケージのインストール
if type "apt" > /dev/null 2>&1; then
    sudo apt install build-essential curl file git
elif type "yum" > /dev/null 2>&1; then
    sudo yum groupinstall 'Development Tools'
    sudo yum install curl file git
    sudo yum install libxcrypt-compat # needed by Fedora 30 and up
else
  # aptとかyumじゃないときは入れない
    echo "package manager is not found!"
    exit
fi

# brewをインストール
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"

# PATHの設定
test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile

# 終了のメッセージ表示
echo "brew is successfully installed!"
