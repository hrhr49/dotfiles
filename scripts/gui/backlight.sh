#!/usr/bin/env bash
# ディスプレイの明るさ調整
# xbacklightを使うやり方がうまく行かなかったのでxrandrを使うやり方の方にした
# 参考 [Ubuntu 14.04 で LCD の明るさをコマンドラインから変えたい - Qiita](https://qiita.com/xr0038/items/7a22a63f121ce2c205c7)

brightness_percent=$(zenity --scale --value=100 --min-value=20 --max-value=100 --width=400 --title="Brightness" --text="Input Brightness [20~100]")
display_name=$(xrandr -q | grep '\<connected' | awk '{print $1}')

if [ -n "$brightness_percent" ]; then
  brightness_rate=$(echo "$brightness_percent/100" | bc -l)
  echo "$brightness_rate"
  xrandr --output "$display_name" --brightness "$brightness_rate"
fi
