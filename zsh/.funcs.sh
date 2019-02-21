#!/usr/bin/env bash

# PATH
export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin
export PATH=$PATH:/usr/local/opt/fzf/bin
export PATH=$PATH:~/.local/bin
export PATH=$PATH:/usr/sbin:/sbin

# Aliases
alias ls="ls -GFh"
alias egrep="egrep --color=auto"
alias weather="curl wttr.in"
alias cheat="curl cheat.sh"

# Variables
export VISUAL=/usr/local/bin/vim
export EDITOR=$VISUAL
export DEFAULT_USER=sloaneat

# FZF C-r and C-t
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow \
  --glob "!{.git,node_modules}/*" \
  2>/dev/null'
export FZF_DEFAULT_OPTS='--color=16'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Shortcut Sync
source ~/.bash_shortcuts

# tmuxp Completions not working yet in zsh...
# https://github.com/tmux-python/tmuxp/issues/190
# eval "$(_TMUXP_COMPLETE=source tmuxp)"

# Functions
# https://github.com/junegunn/fzf/wiki/Examples
fd() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

# CTRL-O to open with `open` command,
# CTRL-E or Enter key to open with the $EDITOR
fe() {
  local out file key
  IFS=$'\n' out=($(fzf --query="$1" --exit-0 --expect=ctrl-o,ctrl-e))
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
  fi
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
    &&  tmux $change -t "$session" || tmux new-session
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

fmpc() {
  local song_position
  song_position=$(mpc -f "%position%) %artist% - %title%" playlist | \
    fzf-tmux --query="$1" --reverse --select-1 --exit-0 | \
    sed -n 's/^\([0-9]*\)).*/\1/p') || return 1
  [ -n "$song_position" ] && mpc -q play $song_position
}

