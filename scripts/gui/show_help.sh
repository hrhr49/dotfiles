#!/usr/bin/env bash

# チートシートをおいておく場所
CHEAT_SHEET_DIR="$HOME/ghq/github.com/hrhr49/memo/content/"

# フォーカスがあたっているウィンドウのタイトルを取得
title=$( \
  xdotool getwindowfocus getwindowname \
  | tr '[:upper:]' '[:lower:]' \
  | tr ' ' '_'
)

# チートシート名がタイトルに含まれているやつを探す
cheat_sheet_file=''

# 注意：findで見つけたものをパイプでwhileに流し込むと、
# cheat_sheet_fileへの代入がうまく行かないので以下のやり方に変更。
# これは、パイプでつながったwhileがサブシェルで実行されることが原因
while read -r file; do
  cheat_sheet_name=$(basename "$file" .md)
  if echo "$title" | grep --quiet "$cheat_sheet_name"; then
    cheat_sheet_file=$file
  fi
done < <(find "$CHEAT_SHEET_DIR" -type f)

if [ -n "$cheat_sheet_file" ]; then
  # 該当のチートシートをvimで開く
  cmd="vim \"$cheat_sheet_file\""
  $TERMINAL --command "$SHELL -i -c \"$cmd\""

  # 行単位で見れる場合は、以下のほうがいい？
  # cat "$cheat_sheet_file" | rofi -show -dmenu 
fi
