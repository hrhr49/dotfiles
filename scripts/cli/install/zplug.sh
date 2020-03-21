#!/bin/bash

# zplug
if [ -e ~/.zplug ]; then
    echo 'zplug already exists'
else
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi
