#!/bin/bash

# Gifで録画できるやつ

if type "peek" > /dev/null 2>&1; then
    echo "peek is already installed"
else
    sudo add-apt-repository ppa:peek-developers/stable
    sudo apt update
    sudo apt install peek
fi
