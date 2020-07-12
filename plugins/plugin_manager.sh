#!/usr/bin/env bash

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

# zplug
if [ -e ~/.zplug ]; then
    echo 'zplug already exists'
else
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

# tpm
if [ -e ~/.tmux/plugins/tpm ]; then
    echo 'tpm already exists'
else
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
