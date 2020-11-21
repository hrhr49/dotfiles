#!/usr/bin/env bash
set -e
# クリップボードの内容をQRコードにして表示する

cmd="xsel -ob | qrencode -t ansiutf8 && read"
$TERMINAL --command "$SHELL -i -c \"$cmd\""
