# zsh固有設定 基本的にzshの設定はoh-my-zshのテンプレを使用するが
# 変更したい部分のみここに記載する

# oh-my-zshのテーマ変更(ubuntuのbashデフォルトみたいなの)
# どうやらzshrcの頭の部分に書いてあるのを変更する必要あるみたいなので
# 以下の行で書き換える(手動）
# ZSH_THEME="lukerandall"

# ディレクトリ名でcdになるのを無効。(コマンドとのバッティングがうざかったため)
unsetopt auto_cd
 
# 移動したディレクトリを記録しておく。"cd -[Tab]"で移動履歴を一覧
setopt auto_pushd

# 補完候補表示時などにピッピとビープ音をならないように設定
setopt nolistbeep

# ビープ音を出さない
setopt no_beep
