#!/usr/bin/env zsh
# vim:set foldmethod=marker foldlevel=0:

source "${HOME}/.commonshrc"

# プロファイリング用(参考 https://qiita.com/vintersnow/items/7343b9bf60ea468a4180)
if [ "$BENCH_ZSH" = "1" ]; then
  if (which zprof > /dev/null 2>&1) ;then
    zprof
  fi
fi

# emacsモード(色々設定する前にemacsモードの設定しとく)
bindkey -e
# プラグイン{{{

# zinit
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi
source "${HOME}/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

zinit wait lucid for \
  Aloxaf/fzf-tab \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
  atload"FAST_HIGHLIGHT_STYLES[path-to-dir]=fg=magenta" \
  zdharma/fast-syntax-highlighting \
  blockf \
  zsh-users/zsh-completions \
  atload"!_zsh_autosuggest_start" \
  zsh-users/zsh-autosuggestions

# 遅いので保留
# zinit creinstall -Q %HOME/.zfunc
# }}}
# プロンプト設定{{{
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u%b%f "
zstyle ':vcs_info:*' actionformats '%b|%a '
function precmd() {
  vcs_info
}

# プロンプト行右側に表示される内容
# RPROMPT=$RPROMPT'${vcs_info_msg_0_}'
# 右側に表示するのを変更して左側へ変更

# プロンプト内容
# %B...%b: 太字
# %~: カレントディレクトリ
# %n: ユーザ名

PROMPT='%B%F{blue}%~%f ${vcs_info_msg_0_}%b'

# Dockerコンテナ内のときには 'docker' という文字列も表示する
if [ -f /.dockerenv ]; then
  PROMPT=$PROMPT'%B%F{yellow}docker%b '
fi

# sshでアクセスしているときには 'ssh' という文字列も表示する
if [ -n "${SSH_CONNECTION}" ]; then
  PROMPT=$PROMPT'%B%F{magenta}ssh%b '
fi
# }}}
# コマンド補完{{{

# 矢印キーで自動補完
zstyle ':completion:*' menu select

# 補完時にhjklで選択
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# 大文字小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# エイリアスでも自動補完(逆に設定したらだめだった。ややこしい・・・)
# setopt completealiases
# setopt complete_aliases

# ディレクトリ名のみでのcdを無効
unsetopt auto_cd

# コマンドスペルの訂正を使用
setopt CORRECT

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

# <C-x> <C-e>でコマンドラインをエディタで編集
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

function exit_zsh() {
  exit
}
zle -N  exit_zsh
# Alt + dでexit
bindkey '^[d' exit_zsh

# <C-s>による停止などを無効化
setopt no_flow_control

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
# 外部コマンド設定 {{{

# fzfの設定
if [ -f ~/.fzf.zsh ]; then
  source ~/.fzf.zsh
elif [[ -f /home/linuxbrew/.linuxbrew/var/homebrew/linked/fzf/shell/completion.zsh \
  && -f /home/linuxbrew/.linuxbrew/var/homebrew/linked/fzf/shell/key-bindings.zsh ]]; then
  source /home/linuxbrew/.linuxbrew/var/homebrew/linked/fzf/shell/completion.zsh
  source /home/linuxbrew/.linuxbrew/var/homebrew/linked/fzf/shell/key-bindings.zsh
elif [[ -f /usr/share/doc/fzf/examples/completion.zsh \
  && -f /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then
  source /usr/share/doc/fzf/examples/completion.zsh
  source /usr/share/doc/fzf/examples/key-bindings.zsh
elif [[ -f /data/data/com.termux/files/usr/share/fzf/completion.zsh \
  && -f /data/data/com.termux/files/usr/share/fzf/key-bindings.zsh ]]; then
  source /data/data/com.termux/files/usr/share/fzf/completion.zsh
  source /data/data/com.termux/files/usr/share/fzf/key-bindings.zsh
elif [[ -f /opt/homebrew/Cellar/fzf/0.25.1/shell/completion.zsh \
  && -f /opt/homebrew/Cellar/fzf/0.25.1/shell/key-bindings.zsh ]]; then
  source /opt/homebrew/Cellar/fzf/0.25.1/shell/completion.zsh
  source /opt/homebrew/Cellar/fzf/0.25.1/shell/key-bindings.zsh
else
  [ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
  [ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
fi


# invokeのzsh用入力補完(自動生成されたもの)
# Invoke tab-completion script to be sourced with the Z shell.
# Known to work on zsh 5.0.x, probably works on later 4.x releases as well (as
# it uses the older compctl completion system).

_complete_invoke() {
  # `words` contains the entire command string up til now (including
  # program name).
  #
  # We hand it to Invoke so it can figure out the current context: spit back
  # core options, task names, the current task's options, or some combo.
  #
  # Before doing so, we attempt to tease out any collection flag+arg so we
  # can ensure it is applied correctly.
  collection_arg=''
  if [[ "${words}" =~ "(-c|--collection) [^ ]+" ]]; then
    collection_arg=$MATCH
  fi
  # `reply` is the array of valid completions handed back to `compctl`.
  # Use ${=...} to force whitespace splitting in expansion of
  # $collection_arg
  reply=( $(invoke ${=collection_arg} --complete -- ${words}) )
}


# Tell shell builtin to use the above for completing our given binary name(s).
# * -K: use given function name to generate completions.
# * +: specifies 'alternative' completion, where options after the '+' are only
#   used if the completion from the options before the '+' result in no matches.
# * -f: when function generates no results, use filenames.
# * positional args: program names to complete for.
compctl -K _complete_invoke + -f invoke inv

# direnvの設定
# if type "direnv" > /dev/null 2>&1; then
#   eval "$(direnv hook zsh)"
# fi

if type "zoxide" > /dev/null 2>&1; then
  # zinitが勝手にziにエイリアスしているっぽい
  alias zi=''
  unalias zi
  eval "$(zoxide init zsh)"
fi
# }}}
# エイリアス{{{
# ネットからコピペするときに$が先頭についていたら面倒なので消す
# bashだとエラーが出る?
alias '$'=' '

# 拡張子ごとに使用するコマンド
alias -s png=sxiv
alias -s jpg=sxiv
alias -s jpeg=sxiv

alias -s mp4=mpv
alias -s mp3=mpv
alias -s wav=mpv

alias -s pdf=zathura

alias -s log=less

# bashだとエラーが出るのでzshでのみ設定
alias ../="cd .."
alias ../..="cd ../.."
alias ../../..="cd ../../.."
alias ../../../..="cd ../../../.."
# }}}
# その他{{{
# PATHの重複を削除
typeset -U path PATH
# }}}
# ローカルの設定 {{{
if [ -e "${HOME}/.zshrc_local" ]; then
  source "${HOME}/.zshrc_local"
fi
# }}}
