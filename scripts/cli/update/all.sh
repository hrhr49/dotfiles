#!/usr/bin/env bash
set -e

# パッケージやプラグインなどをインストールするスクリプト

SCRIPT_DIR=$(cd "$(dirname "$0")" || exit; pwd)
find "$SCRIPT_DIR" -maxdepth 1 -type f | while read -r scriptfile ; do
    # 実行可能なら
    if [ -x "$scriptfile" ]; then
        # このファイルじゃなければ
        if [ "$scriptfile" != "$0" ]; then
            echo ""
            echo "***********************************************************"
            echo "Running $scriptfile ..."
            echo "***********************************************************"
            echo ""
            if echo "$scriptfile" | grep --quiet "vim-plug"; then
              echo "skipped"
            else
              # 実行
              $scriptfile
            fi
        fi
    fi
done
