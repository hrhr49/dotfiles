#!/usr/bin/env bash
set -e

# 動画編集のやつ
# 現時点でのメモ
# この手順で入ったやつ 20.12.1-1
# デフォルトのaptで入ったやつだとバージョンが古いうえ(確か19だった)に
# タイムラインで右クリックするとsegmentation faultが起きてしまうバグがあった
# SnapやAppImageを使う手もあるが、
# 環境変数QT_QPA_PLATFORMTHEMEで設定していたqt5ctが
# 反映されないため、フォントが小さくて辛かったので断念

if xset q > /dev/null 2>&1; then
  if type "kdenlive" > /dev/null 2>&1; then
      echo "kdenlive is already installed"
  else
      sudo add-apt-repository ppa:kdenlive/kdenlive-stable
      sudo apt-get update
      sudo apt install -y kdenlive
  fi
else
  # GUI環境がない場合はインストールしない
  echo 'kdenlive will not be installed. GUI is not found.'
fi
