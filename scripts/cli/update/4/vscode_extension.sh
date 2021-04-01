#!/usr/bin/env bash
set -eu

# vscodeでインストールする拡張機能リスト
# 現在のvscodeでインストールされている拡張機能は以下のコマンドで確認できる
# code --list-extensions

packages=(
  # Python
  donjayamanne.python-extension-pack
  batisteo.vscode-django
  magicstack.MagicPython
  ms-python.python
  ms-toolsai.jupyter
  wholroyd.jinja

  # JavaScript
  esbenp.prettier-vscode
  dbaeumer.vscode-eslint
  eg2.vscode-npm-script
  christian-kohler.npm-intellisense
  msjsdiag.debugger-for-chrome
  wix.vscode-import-cost  # インポートしたときのバンドルサイズを表示

  # CSS
  stylelint.vscode-stylelint  # CSS用のリンター

  # Markdown
  DavidAnson.vscode-markdownlint
  mushan.vscode-paste-image  # クリップボードの画像貼り付け
  shd101wyy.markdown-preview-enhanced

  # C#
  jchannon.csharpextensions
  ms-dotnettools.csharp
  ms-vscode.mono-debug

  # Git
  donjayamanne.githistory
  eamodio.gitlens

  # Theme, Color
  CoenraadS.bracket-pair-colorizer-2
  vscode-icons-team.vscode-icons

  # Windows
  ms-vscode-remote.remote-wsl

  # Other
  ms-azuretools.vscode-docker
  ms-vscode-remote.remote-containers
  # ms-vsliveshare.vsliveshare
  # Unity.unity-debug
  VisualStudioExptTeam.vscodeintellicode
  # vscodevim.vim
)

if type "code" > /dev/null 2>&1; then
  for package in "${packages[@]}"; do
      code --install-extension "$package"
  done
fi
