#!/usr/bin/env bash
set -e

# goでインストールするものリスト
packages=(
    github.com/golang/dep/cmd/dep
    # デバッガ
    github.com/go-delve/delve/cmd/dlv
    # gitリポジトリ管理
    github.com/x-motemen/ghq
    # pistolの依存。MIMEタイプの判定
    github.com/rakyll/magicmime
)

go11packages=(
    # ファイルのプレビュー
    github.com/doronbehar/pistol/cmd/pistol
)

if type "go" > /dev/null 2>&1; then
  # TODO: バージョン 1.18 からは go installに変更する
  go get -u "${packages[@]}"
  env GO111MODULE=on go get -u "${go11packages[@]}"
fi
