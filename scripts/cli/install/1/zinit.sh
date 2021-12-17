#!/usr/bin/env bash
set -e

# zshのプラグインマネージャzinit(zplugより速いらしい？)
if [ -e ~/.zinit ]; then
    echo 'zinit already exists'
else
    sh -c "$(curl -fsSL https://git.io/zinit-install)"
fi
