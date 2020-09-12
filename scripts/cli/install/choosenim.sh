#!/usr/bin/env bash

if type choosenim > /dev/null 2>&1; then
  echo 'choosenim is already installed'
else
  curl 'https://nim-lang.org/choosenim/init.sh' -sSf | sh
fi
