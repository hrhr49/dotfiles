#!/usr/bin/env zsh
# プロファイリング用(参考 https://qiita.com/vintersnow/items/7343b9bf60ea468a4180)
if [ "$BENCH_ZSH" = "1" ]; then
    zmodload zsh/zprof && zprof
fi
if [ -e "${HOME}/.zshenv_local" ]; then
  source "${HOME}/.zshenv_local"
fi
