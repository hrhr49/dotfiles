#!/usr/bin/env bash
# クリップボードの内容をQRコードにして表示する

cmd="xsel -ob | qrencode -t ansiutf8 && read"
$terminal --command "$shell -i -c \"$cmd\""
