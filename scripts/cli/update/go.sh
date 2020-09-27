#!/usr/bin/env bash

# goでインストールするものリスト
packages=(
    github.com/golang/dep/cmd/dep
    # デバッガ
    github.com/go-delve/delve/cmd/dlv
    # gitリポジトリ管理
    github.com/x-motemen/ghq
)

if type "go" > /dev/null 2>&1; then
  go get -u "${packages[@]}"
fi
