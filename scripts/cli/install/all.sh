#!/usr/bin/env bash
set -eu

# 各種ツールなどをインストールするスクリプト

SCRIPT_DIR=$(cd "$(dirname "$0")" || exit; pwd)
find "$SCRIPT_DIR" -type f | sort | while read -r scriptfile ; do
    # 実行可能なら
    if [ -x "$scriptfile" ]; then
        # このファイルじゃなければ
        if [ "$scriptfile" != "$0" ]; then
            echo ""
            echo "***********************************************************"
            echo "Running $scriptfile ..."
            echo "***********************************************************"
            echo ""
            # 実行
            $scriptfile
        fi
    fi
done
