#!/usr/bin/env bash
set -e

if type "rustup" > /dev/null 2>&1; then
  echo 'rustup is already installed.'
else
  if type "pacman" > /dev/null 2>&1; then
    echo 'pacman found. please install by pacman.'
  else
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  fi
fi
