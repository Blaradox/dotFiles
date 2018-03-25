#!/usr/bin/env bash

# PATH
export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/opt/fzf/bin

# Aliases
alias ls="ls -GFh"
alias egrep="egrep --color=auto"

# Variables
export VISUAL=/usr/local/bin/vim
export EDITOR=$VISUAL
export DEFAULT_USER=sloaneat
export FZF_DEFAULT_OPTS='
  --color=16
  --height=10
  --reverse
'

# FZF C-r and C-t
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# tmuxp Completions not working yet in zsh...
# https://github.com/tmux-python/tmuxp/issues/190
# eval "$(_TMUXP_COMPLETE=source tmuxp)"

# Functions
fe() {
  local files
  IFS=$'\n' files=($(fzf --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

fbr() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m --height=10 --reverse) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

tm() {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then
    tmux $change -t "$1" 2>/dev/null || \
      (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | \
    fzf --height=10 --reverse --exit-0) \
    &&  tmux $change -t "$session" || echo "No sessions found."
}

bro() {
  if [ $1 ]; then
    remote=$(git remote | fzf --height=10 --reverse --exit-0 --query="$1" --select-1)
    url=$(git remote get-url "$remote")
    if [ $url ]; then
      open "$url"; return
    fi
  fi
  remote=$(git remote | fzf +m --height=10 --reverse --exit-0)
  url=$(git remote get-url "$remote")
  if [ $url ]; then
    open "$url"
  fi
}
