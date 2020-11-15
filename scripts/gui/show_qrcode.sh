#!/usr/bin/env bash
# クリップボードの内容をQRコードにして表示する

cmd="xsel -ob | qrencode -t ansi && read"
$TERMINAL --command "$SHELL -i -c \"$cmd\""
