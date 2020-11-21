#!/usr/bin/env bash
set -e

# zshのプラグインマネージャzinit(zplugより速いらしい？)
if [ -e ~/.zinit ]; then
    echo 'zinit already exists'
else
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
fi
