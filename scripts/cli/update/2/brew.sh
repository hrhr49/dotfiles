#!/usr/bin/env bash
set -e

# brewでインストールするものリスト
formulas=(
    # gcc-5がないとgo getとかで怒られるときがある
    # MacOSだとだめっぽい
    # gcc@5
    # シェル
    # "--without-etcdir zsh"
    # zsh
    # zsh-completions

    # バージョン管理
#    git
    ghq
    tig
    git-delta
    gibo # gitignore生成

    # 外部サービスとの連携
    hub
    slackcat

    # 文字コード
    nkf

    # 表示
    tree
    htop
    bat # catの色付き & 行番号や、git差分なども表示
    ccat # catの色付き
    exa # lsのいい感じバージョン
    lsd # exaと同じ。こっちのがはやい？
    ncdu # ディスク使用量
    tldr # コマンドの使用例
    tokei # ファイル種別ごとの行数などを表示
    catimg # ターミナルで画像表示
    colordiff # diffの色付きバージョン

    # silicon # ソースコードをいい感じの画像に変換(フォントを指定しないと日本語がないフォントだとエラーになる)

    ccze # ログに色を付ける
    hexyl # 16進数ダンプ
    pastel # カラー表示(いい感じの色を探すときに便利そう)

    # 開発 効率化
    direnv
    ctags

    # テキストエディタ
    neovim
    kakoune # vim インスパイアなエディタ
    micro # ベーシックな感じのキーバインドのエディタ。nanoの代わりに使えそう？

    # TUI
    # ranger # localeの設定がうまく行ってない？のでpipの方で入れる(https://github.com/ranger/ranger/issues/937)
    nnn # 軽量なファイルマネージャ
    tmux
    sc-im # スプレッドシート

    # Markdown
    mdp # CLIでのプレゼンツール

    # ファイルマネージャ
    lf

    # 検索
    ripgrep
    # ripgrep-all # テキスト以外のファイルもrgaコマンドで一気に検索
    the_silver_searcher
    fzf
    peco
    fd

    sd # sedの代わり。でも置換しかできない？速度は速いみたい。

    # 各種言語
    ruby
    node
    go
    # rust # rustよりrustupのほうがいい？ 
    rustup # rustup-initを実行する必要あり
    perl
    # python3
    lua
    # nim # choosenimでインストールする(パッケージマネージャだとnimbleが正しく動かないっぽい)

    # shellcheck # シェルスクリプトのLinter

    # ユーティリティ
    # fasd
    zoxide    # zコマンドで最近のディレクトリに移動
    httpie    # curlのようなやつ
    trash-cli # ゴミ箱操作
    jq        # JSONをいい感じにフィルター
    gron      # jsonをgrepしやすい形にする
    fx        # jqみたいだけどインタラクティブにできたりする
    jo        # JSONオブジェクトを生成
    bitwise   # ビット表示
    unar      # ファイルの解凍

    # 図形作成
    graphviz
    plantuml
    # ditaa

    # 文書
    # pandoc
    # redpen # 文章校正

    # 見た目
    figlet   # 文字をアスキーアートで出すやつ
    neofetch # アスキーアートでOSのアイコン出す
    emojify  # 絵文字を入力するため

    # 静的サイトジェネレータ
    hugo

    # パスワード管理
    gopass
)

formulas_only_mac=(
  koekeishiya/formulae/yabai
  koekeishiya/formulae/skhd
  wget
  cmake
  emscripten # C/C++をWebAssemblyに変換するツールチェーン
  llvm
  ffmpeg
)

if [ "$(uname)" == 'Darwin' ]; then
  formulas=("${formulas[@]}" "${formulas_only_mac[@]}")
fi

installed_formulas=$(brew list --formula)

if type "brew" > /dev/null 2>&1; then
  # インストールしていないものだけインストール
  # 直接installコマンドに与えると警告やエラーが出るので、それを回避
  for formula in "${formulas[@]}"; do
      if echo "$installed_formulas" | grep "$formula" > /dev/null 2>&1; then
          echo "$formula already exists"
      else
          brew install "$formula"
      fi
  done
fi

# brewでインストールするものリスト(cask)
casks=(
  google-chrome
  iterm2
  google-japanese-ime
  mpv
  zoom
  visual-studio-code
)


if [ "$(uname)" == 'Darwin' ]; then
  if type "brew" > /dev/null 2>&1; then
    for cask in "${casks[@]}"; do
        if echo "$installed_formulas" | grep "$cask" > /dev/null 2>&1; then
            echo "$cask already exists"
        else
            brew install --cask "$cask"
        fi
    done
  fi
fi

