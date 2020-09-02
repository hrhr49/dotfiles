#!/usr/bin/env zsh
# vim:set foldmethod=marker foldlevel=0:

# プロファイリング用(参考 https://qiita.com/vintersnow/items/7343b9bf60ea468a4180)
if [ "$BENCH_ZSH" = "1" ]; then
    if (which zprof > /dev/null 2>&1) ;then
      zprof
    fi
fi

export TERM="xterm-256color"
# プラグイン{{{
# zinit
source "${HOME}/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
# fzf-tabの前にemacsモードにしとかないとうまく行かない？
# emacsモード
bindkey -e
zinit light Aloxaf/fzf-tab
zinit light zdharma/fast-syntax-highlighting
# zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# }}}
# プラグイン設定{{{
# zsh-users/zsh-syntax-highlighting{{{
# ZSH_HIGHLIGHT_STYLES[path]=none
# ZSH_HIGHLIGHT_STYLES[path_prefix]=none
# }}}
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
# }}}
# コマンド補完{{{

# brewでzsh-completionsをインストールしている場合はそれを使用する(参考 https://gist.github.com/juno/5546198)
[ -e ${HOMEBREW_PREFIX}/share/zsh-completions ] && fpath=(${HOMEBREW_PREFIX}/share/zsh-completions $fpath)

# zplugで呼ぶため不要
# autoload -U compinit
# compinit

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
if type "direnv" > /dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

if type "zoxide" > /dev/null 2>&1; then
  # zinitが勝手にziにエイリアスしているっぽい
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
# }}}
