#!/usr/bin/env bash

# Anaconda3のインストール
# TODO: 最新版のAnacondaをインストールするように変更
# 全部自動化

echo 'Not implemented yet...'
exit

if type "conda" > /dev/null 2>&1; then
    echo 'conda already exists'
    exit
fi

# install dependencies
# sudo apt-get install libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6

# ANACONDA_SCRIPT='Anaconda3-2020.02-Linux-x86_64.sh'
# ANACONDA_ARCHIVE='https://repo.anaconda.com/archive/'
# wget $ANACONDA_ARCHIVE/$ANACONDA_SCRIPT

# chmod +x $ANACONDA_SCRIPT
# $ANACONDA_SCRIPT
# source ~/.bashrc
