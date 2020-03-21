#!/bin/zsh

# 各種プラグインのインストール

# zplug
source $HOME/.zplug/init.zsh
zplug install

# tpm
$TMUX_PLUGIN_MANAGER_PATH/tpm/bindings/install_plugins

# vim-plug
vim -c 'PlugInstall|qa'
