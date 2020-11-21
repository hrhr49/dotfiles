#!/usr/bin/env bash
set -e

if [ -f "$TMUX_PLUGIN_MANAGER_PATH"/tpm/bindings/install_plugins ]; then
  # tpm
  "$TMUX_PLUGIN_MANAGER_PATH"/tpm/bindings/install_plugins
fi
