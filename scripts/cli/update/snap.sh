#!/usr/bin/env bash

if snap > /dev/null 2>&1; then
  if xset q > /dev/null 2>&1; then
    # snapでインストールするもの
    # sudo snap install typora-alanzanattadev # Markdownエディタ
    # sudo snap install sublime-text --classic
    sudo snap install google-cloud-sdk --classic
    sudo snap install code --classic
    # sudo snap install pycharm-community --classic
    # sudo snap install skype --classic
    sudo snap install drawio
  fi
fi
