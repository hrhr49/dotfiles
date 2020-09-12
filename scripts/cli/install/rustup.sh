#!/usr/bin/env bash

if type "rustup" > /dev/null 2>&1; then
  echo 'rustup is already installed'
else
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi
