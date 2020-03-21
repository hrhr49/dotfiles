#!/bin/bash

# ranger deviconsのインストール

if [ -e ~/.config/ranger/plugins/ranger_devicons ]; then
    echo 'ranger_devicons already exists'
else
    git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons
fi
