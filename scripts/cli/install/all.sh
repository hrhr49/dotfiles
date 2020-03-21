#!/bin/bash

# 各種ツールなどをインストールするスクリプト

SCRIPT_DIR=$(cd $(dirname $0); pwd)
ls $SCRIPT_DIR | while read scriptfile ; do
    target=$SCRIPT_DIR/$scriptfile

    # 実行可能なら
    if [ -x $target ]; then
        # このファイルじゃなければ
        if [ $target != $0 ]; then
            echo ""
            echo "***********************************************************"
            echo "Running $scriptfile ..."
            echo "***********************************************************"
            echo ""
            # 実行
            $target
        fi
    fi
done
