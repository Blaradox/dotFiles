#!/usr/bin/env bash

# PATH
export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin
export PATH=$PATH:/usr/local/opt/fzf/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:/usr/sbin:/sbin

# Necessities
export DEFAULT_USER=sloaneat
export VISUAL=/usr/local/bin/vim
export EDITOR=$VISUAL

# FZF
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
export FZF_DEFAULT_OPTS='--color=16'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
