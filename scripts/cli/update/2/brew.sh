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
    # slackcat

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

    # ccze # ログに色を付ける
    # hexyl # 16進数ダンプ
    # pastel # カラー表示(いい感じの色を探すときに便利そう)

    # 開発 効率化
    direnv
    ctags

    # テキストエディタ
    neovim
    # kakoune # vim インスパイアなエディタ
    # micro # ベーシックな感じのキーバインドのエディタ。nanoの代わりに使えそう？

    # TUI
    # ranger # localeの設定がうまく行ってない？のでpipの方で入れる(https://github.com/ranger/ranger/issues/937)
    nnn # 軽量なファイルマネージャ
    tmux
    # sc-im # スプレッドシート

    # Markdown
    mdp # CLIでのプレゼンツール

    # ファイルマネージャ
    lf

    # 検索
    ripgrep
    rga
    # ripgrep-all # テキスト以外のファイルもrgaコマンドで一気に検索
    the_silver_searcher
    fzf
    peco
    fd

    sd # sedの代わり。でも置換しかできない？速度は速いみたい。

    # 各種言語
    ruby
    node
    # deno
    go
    golang
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
    trash-cli # ゴミ箱操作
    jq        # JSONをいい感じにフィルター
    gron      # jsonをgrepしやすい形にする
    # fx        # jqみたいだけどインタラクティブにできたりする
    # jo        # JSONオブジェクトを生成
    # bitwise   # ビット表示
    # unar      # ファイルの解凍
    dust      # ファイル容量一覧を表示
    choose-rust  # Pythonのスライスのような感じで、シーケンスから要素を抽出

    # Web
    # monolith  # Webページを一つのHTMLファイルにしてダウンロード
    httpie    # curlのようなやつ
    hugo  # 静的サイトジェネレータ

    # 図形作成
    graphviz
    plantuml
    # ditaa

    # 文書
    pandoc
    # redpen # 文章校正

    # 見た目
    figlet   # 文字をアスキーアートで出すやつ
    neofetch # アスキーアートでOSのアイコン出す
    emojify  # 絵文字を入力するため

    # パスワード管理
    gopass
    gpg

    # AWS
    awscli

    # ビデオストリーミングをビデオプレイヤーなどにパイプするツール
    streamlink

    # Azure
    # azure-cli
)

formulas_only_mac=(
  # koekeishiya/formulae/yabai  # タイル型ウィンドウマネージャ
  # koekeishiya/formulae/skhd  # 上記のyabaiを使うときに一緒に使う。キーバインド設定ツール
  wget
  cmake
  emscripten # C/C++をWebAssemblyに変換するツールチェーン
  llvm
  ffmpeg
  libmagic
  # mono  # C#関連で必要 no bottle available!が出るため一時無効
  mas  # App Storeのアプリをインストール
  # sshfs
  iproute2mac  # ipコマンドをmacで使うため

  # TensorFlow for MacOSの依存
  openssl
  zlib
  hdf5

  # matplotlibの依存
  libjpeg

  # ファイル監視
  fswatch

  # PDF
  poppler
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
  clipy
  # cheatsheet  # cmdキー長押しで、ショートカット一覧表示
  # imageoptim  # 画像サイズの削減
  flux  # ブルーライトカット
  karabiner-elements  # キー配列の設定
  appcleaner  # アプリを削除＆ゴミも一緒に削除
  # skitch  # ちょっとした画像作成
  kindle
  # bettertouchtool  # ウィンドウのサイズ変更 有料
  # xquartz  # Xサーバー
  scroll-reverser  # トラックパッドとマウスでスクロール方向を個別設定
  # rectangle  # ウィンドウのサイズ変更や移動のショートカットを追加。hammerspoonで代替可能なので削除
  # alfred  # spotlightの強化版
  # osxfuse  # sshfsの依存
  # pinta  # 簡易的なペイント
  # krita  # お絵かき
  # firealpaca  # お絵かき
  # medibangpaintpro  # お絵かき
  # audacity  # 音声ファイル編集
  # miniforge  # M1Macで使うanacondaの代わり
  # utm  # 仮想マシンを動かすアプリ
  discord
  # keycastr  # キーキャストを表示するやつ
  spotify  # 音楽
  # docker
  bitwarden
  # gyazo  # スクショを撮ってURL作る
  # cyberduck  # FTP
  # microsoft-remote-desktop
  # renpy
  hammerspoon  # キーバインドで各種操作を実行
)

installed_casks=$(brew list --cask)
if [ "$(uname)" == 'Darwin' ]; then
  if type "brew" > /dev/null 2>&1; then
    for cask in "${casks[@]}"; do
        if echo "$installed_casks" | grep "$cask" > /dev/null 2>&1; then
            echo "$cask already exists"
        else
            brew install --cask "$cask"
        fi
    done
  fi
fi

