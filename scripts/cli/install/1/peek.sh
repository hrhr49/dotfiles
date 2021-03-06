#!/usr/bin/env bash
set -e

# Gifで録画できるやつ

if xset q > /dev/null 2>&1; then
  if type "peek" > /dev/null 2>&1; then
      echo "peek is already installed"
  else
      sudo add-apt-repository ppa:peek-developers/stable
      sudo apt update
      sudo apt install -y peek
  fi
else
  # GUI環境がない場合はインストールしない
  echo 'peek will not be installed. GUI is not found.'
fi
