#!/bin/bash

# Open JTalk(日本語音声読み上げソフト)のインストール(注意：root権限必要)
# 参考： https://thr3a.hatenablog.com/entry/20180223/1519360909

TMP_DIR=/tmp/
HTS_VOICE_DIR=$HOME/.config/myfiles/hts-voice/
if [ -e "$HTS_VOICE_DIR" ]; then
    echo 'Open JTalk is already installed'
else
    sudo apt install open-jtalk open-jtalk-mecab-naist-jdic hts-voice-nitech-jp-atr503-m001
    cd $TMP_DIR || exit
    # Meiのボイスをダウンロード
    if [ -e $TMP_DIR/MMDAgent_Example-1.7.zip ]; then
        echo 'Mei voice is already downloaded'
    else
        wget http://sourceforge.net/projects/mmdagent/files/MMDAgent_Example/MMDAgent_Example-1.7/MMDAgent_Example-1.7.zip
    fi
    # linuxbrew入れていたら別のほうのunzipが呼ばれてしまい、うまく行かなかったのでフルパスで指定
    /usr/bin/unzip MMDAgent_Example-1.7.zip
    mkdir -p "$HTS_VOICE_DIR"
    cp -r $TMP_DIR/MMDAgent_Example-1.7/Voice/mei/ "$HTS_VOICE_DIR"
fi
