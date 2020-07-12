#!/usr/bin/env bash

# ダイアログに入力された透明度に現在のウィンドウを変更
opacity=$(zenity --entry --width=400 --title="Opacity" --text="Input opacity [0~100]")
compton-trans -c "$opacity"
