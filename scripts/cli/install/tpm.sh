#!/usr/bin/env bash
set -e

# tpm
if [ -e ~/.tmux/plugins/tpm ]; then
    echo 'tpm already exists'
else
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
