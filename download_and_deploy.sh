#!/usr/bin/env bash
set -eu

# HOW TO USE
# curl -L raw.github.com/hrhr49/dotfiles/master/download_and_deploy.sh | bash

DOTPATH=~/memo/dotfiles
GITHUB_URL=https://github.com/hrhr49/dotfiles.git
TARBALL=https://github.com/hrhr49/dotfiles/archive/master.tar.gz

has() {
  type "$1" > /dev/null 2>&1
}

if has git; then
    git clone --recursive "$GITHUB_URL" "$DOTPATH"
elif has curl || has wget; then
    if has curl; then
        curl -L "$TARBALL"
    elif has wget ; then
        wget -O - "$TARBALL"
    fi | tar xvz
    mkdir -p "$DOTPATH"
    mv -f -T dotfiles-master "$DOTPATH"
else
    echo "curl or wget required"
fi

cd "$DOTPATH"
./install.sh
