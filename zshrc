# vim:set foldmethod=marker foldlevel=0:
# プロンプト設定{{{
# http://tkengo.github.io/blog/2013/05/12/zsh-vcs-info/
# この行は現在のパスを表示する設定です。ブランチを表示して色をつける設定とは関係ありません
autoload -Uz colors
colors
# RPROMPT="%{${fg[blue]}%}[%~]%{${reset_color}%}"

autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
# プロンプト行右側に表示される内容
# RPROMPT=$RPROMPT'${vcs_info_msg_0_}'
# 右側に表示するのを変更して左側へ変更

# プロンプト内容
# %B...%b: 太字
# %~: カレントディレクトリ
# %n: ユーザ名

PROMPT='%B%F{green}%n@%m%f:%F{blue}%~%f${vcs_info_msg_0_}$%b'
# }}}
# コマンド補完{{{
autoload -U compinit
compinit

# 矢印キーで自動補完
zstyle ':completion:*' menu select

# エイリアスでも自動補完
setopt completealiases

# ディレクトリ名のみでのcdを無効
unsetopt auto_cd
# }}}
# 履歴{{{
# 履歴サイズ
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
# HISTFILESIZE=2000

# 拡張フォーマットで保存
setopt extended_history

# 履歴に同一のものがあれば削除
setopt hist_ignore_all_dups

# # 履歴に同じ行が重複するのを避ける。上記設定の下位互換
# setopt HIST_IGNORE_DUPS

# ヒストリファイル保存時に重複したコマンドラインは古い方を削除
setopt hist_save_no_dups

# シェル終了時、履歴を追加
setopt append_history

# コマンド実行時にファイルに追加
setopt inc_append_history

# 履歴を共有
setopt share_history
# }}}
# キーバインド{{{
# emacsモード
bindkey -e
# }}}
# ディレクトリ移動{{{
# ディレクトリ名でcdになるのを無効。(コマンドとのバッティングがうざかったため)
unsetopt auto_cd
 
# 移動したディレクトリを記録しておく。"cd -[Tab]"で移動履歴を一覧
setopt auto_pushd
# }}}
# ビープ音{{{
# 補完候補表示時などにピッピとビープ音をならないように設定
setopt nolistbeep

# ビープ音を出さない
setopt no_beep
# }}}
