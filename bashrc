# shellcheck shell=bash
if which nvim > /dev/null 2>&1; then
  export EDITOR=nvim
  export VISUAL=nvim
  alias vim=nvim
  alias vi=nvim
else
  export EDITOR=vim
  export VISUAL=vim
fi
alias open='xdg-open'

if [ -f ~/.fzf.bash ]; then
    source ~/.fzf.bash
elif [ -f /usr/share/doc/fzf/examples/key-bindings.bash ]; then
    source /usr/share/doc/fzf/examples/completion.bash
    source /usr/share/doc/fzf/examples/key-bindings.bash
fi

if type "direnv" > /dev/null 2>&1; then
  eval "$(direnv hook bash)"
fi
