#!/bin/bash

# tpm
if [ -e ~/.tmux/plugins/tpm ]; then
    echo 'tpm already exists'
else
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
