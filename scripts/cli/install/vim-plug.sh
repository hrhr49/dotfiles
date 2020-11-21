#!/usr/bin/env bash
set -e

# vim-plug for vim
if [ -e ~/.vim/autoload/plug.vim ]; then
    echo 'vim-plug for vim already exists'
else
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# vim-plug for neovim
if [ -e ~/.local/share/nvim/site/autoload/plug.vim ]; then
    echo 'vim-plug for neovim already exists'
else
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
