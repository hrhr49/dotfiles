#!/usr/bin/env bash

# Cicaフォントのインストール

# 参考 [Ubuntu初心者の集いブログ フォントのインストール](http://omoiyari.nishinari.coop/ubuntu-tips/%E3%83%95%E3%82%A9%E3%83%B3%E3%83%88%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB/)

CICA_FONT_DIR=$HOME/.fonts/Cica_v5.0.1_with_emoji
if [ -e "$CICA_FONT_DIR" ]; then
    echo 'Cica font already exists.'
else
    mkdir -p "$CICA_FONT_DIR"
    cd "$CICA_FONT_DIR" || exit
    wget https://github.com/miiton/Cica/releases/download/v5.0.1/Cica_v5.0.1_with_emoji.zip
    # linuxbrew入れていたら別のほうのunzipが呼ばれてしまい、うまく行かなかったのでフルパスで指定
    # (参考 https://ja.stackoverflow.com/questions/57889/unzip%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%81%A7zip%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E8%A7%A3%E5%87%8D%E3%81%8C%E5%87%BA%E6%9D%A5%E3%81%AA%E3%81%84)
    /usr/bin/unzip "$CICA_FONT_DIR"/Cica_v5.0.1_with_emoji.zip
    rm "$CICA_FONT_DIR"/Cica_v5.0.1_with_emoji.zip
fi
