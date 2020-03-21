#!/bin/bash

# ダイアログに入力されたワークスペース名に現在のワークスペース名を変更
new_workspace_name=$(zenity --entry --width=400 --title="Rename Window" --text="Input new workspace name.")
i3-msg rename workspace to $new_workspace_name
