#!/usr/bin/env zsh

if type "zsh" > /dev/null 2>&1; then
  if [ -f ~/.zinit/bin/zinit.zsh ]; then
    zsh -i ~/.zinit/bin/zinit.zsh
  fi
fi

