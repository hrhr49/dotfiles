# zsh固有設定 基本的にzshの設定はoh-my-zshのテンプレを使用するが
# 変更したい部分のみここに記載する

# oh-my-zshのテーマ変更(ubuntuのbashデフォルトみたいなの)
# どうやらzshrcの頭の部分に書いてあるのを変更する必要あるみたいなので
# 以下の行で書き換える(手動）
# ZSH_THEME="lukerandall"

# ディレクトリ名でcdになるのを無効。(コマンドとのバッティングがうざかったため)
unsetopt auto_cd
