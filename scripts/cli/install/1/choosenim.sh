#!/usr/bin/env bash
set -e

if type choosenim > /dev/null 2>&1; then
  echo 'choosenim is already installed'
else
  if type "yay" > /dev/null 2>&1; then
    echo 'yay found. please install by yay.'
  else
    curl 'https://nim-lang.org/choosenim/init.sh' -sSf | sh
  fi
fi
