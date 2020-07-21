#!/usr/bin/env bash

# goでインストールするものリスト
packages=(
    github.com/golang/dep/cmd/dep
    # デバッガ
    github.com/go-delve/delve/cmd/dlv
)

go get -u "${packages[@]}"
