#!/usr/bin/env bash

# goでインストールするものリスト
packages=(
    github.com/golang/dep/cmd/dep
)

go get -u "${packages[@]}"
