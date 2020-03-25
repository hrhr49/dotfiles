#!/bin/bash

# pywalでランダムにファイルを選択して実行
# 対象ディレクトリにはvarietyで自動ダウンロードする
# 気分転換したいタイミングでこのスクリプトを実行する
TARGET_DIR=$HOME/.config/variety/Downloaded/
SCRIPT_AFTER_WAL=$HOME/.config/wal/after.sh
TARGET_FILE=$(find $TARGET_DIR \
    -name '*.png' -or \
    -name '*.jpg' -or \
    -name '*.jpeg' \
    | shuf -n 1)
echo $TARGET_FILE
wal -i $TARGET_FILE -o $SCRIPT_AFTER_WAL
