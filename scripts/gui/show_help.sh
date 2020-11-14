#!/usr/bin/env bash

# チートシートをおいておく場所
CHEAT_SHEET_DIR="$HOME/memo/memo/"

if [ ! -d "$CHEAT_SHEET_DIR" ]; then
  # ディレクトリがない場合はエラーを表示
  notify-send "directory '$CHEAT_SHEET_DIR' is not found" -t 3000
fi

# フォーカスがあたっているウィンドウのタイトルを取得
# title=$( \
#   xdotool getwindowfocus getwindowname \
#   | tr '[:upper:]' '[:lower:]' \
#   | tr ' ' '_'
# )
# 上のやり方だと、タイトル名にプログラム名が入らないため、以下のやり方に変更
# 参考: https://unix.stackexchange.com/questions/38867/is-it-possible-to-retrieve-the-active-window-process-title-in-gnome
title="$(cat /proc/"$(xdotool getwindowpid "$(xdotool getwindowfocus)")"/comm)"

# 微妙にプログラム名が想定と違うものがあるのでその場合は名前を置き換える
case $title in
  chrome ) title=google-chrome ;;
esac

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
  # cmd="vim \"$cheat_sheet_file\""
  # $TERMINAL --command "$SHELL -i -c \"$cmd\""

  # 行単位で見れる場合は、以下のほうがいい？
  # rofiでインクリメントに絞り込むため、ローマ字表記をつける
  # ローマ字表記は邪魔なので画面外になるように、長い空白で区切る(TODO: もう少しマシな方法を見つける)
  lines="$(grep '^\*' "$cheat_sheet_file")"
  paste -d " " \
    <(echo "$lines") \
    <(echo "$lines" | sed -e "s/.*/                                \
                                                                   \
                                                                   \
                                                                   \
                                                                   \
                                                                   \
                                                                   \
                                                                   \
                                                                   \
                                                                   \
                                                                   \
                                                                   \
                                                                   \
                                                                   \
                                                                   \
                                   /") \
    <(echo "$lines" | mecab -Oyomi | uconv -x latin) \
  | rofi -show -i -dmenu -p "help"
    # -markup-rows

else
  notify-send "no cheat sheet about '$title'" -t 3000
fi
