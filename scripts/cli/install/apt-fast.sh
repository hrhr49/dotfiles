#!/usr/bin/env bash
set -e
if type "apt" > /dev/null 2>&1; then
  /bin/bash -c "$(curl -sL https://git.io/vokNn)"
fi
