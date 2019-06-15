#!/usr/bin/env bash

# PATH
if [[ -s "/usr/local/opt/ruby/bin" ]]; then
  export PATH=/usr/local/opt/ruby/bin:$PATH
fi
if [[ -s "/usr/local/opt/fzf/bin" ]]; then
  export PATH=/usr/local/opt/fzf/bin:$PATH
fi
export PATH=$HOME/.local/bin:$PATH

# Necessities
export DEFAULT_USER=sloaneat
if [[ $OSTYPE == darwin* ]]; then
  export VISUAL=/usr/local/bin/nvim
elif [[ $OSTYPE == linux* ]]; then
  export VISUAL=/usr/bin/nvim
fi
export EDITOR=$VISUAL

# FZF
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden --follow'
export FZF_DEFAULT_OPTS='--color=16'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Weechat
export WEECHAT_HOME="${XDG_CONFIG_HOME:=$HOME/.config}/weechat"
