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

if type "direnv" > /dev/null 2>&1; then
  eval "$(direnv hook bash)"
fi
