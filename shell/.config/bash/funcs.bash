#!/usr/bin/env bash

alert() {
  echo -n -e '\a'
  local mac_sound linux_sound icon title body
  mac_sound="Glass"
  linux_sound="/usr/share/sounds/freedesktop/stereo/complete.oga"
  if [ $# = 0 ]; then
    icon="terminal"
    title="Job Completed"
  else
    icon="error"
    title="Job Failed"
  fi
  body="$(fc -n -l -1|sed -e 's/[;&|]\s*alert$//')"
  case "$OSTYPE" in
    (darwin*)
      /usr/bin/osascript -e 'display notification "$body" with title "$title" sound name "$mac_sound"'
      ;;
    (linux-gnu)
      notify-send --urgency=low -i "$icon" "$title" "$body"; paplay "$linux_sound"
      ;;
  esac
}

# Extract files
extract() {
  local file
  (($#)) || return
  for file; do
    if [[ ! -r $file ]]; then
      echo "$0: file is unreadable: \`$file'" >&2
      continue
    fi
    case $file in
      *.7z)       7z x -o"${file%%.7z}" "$file";;
      *.tar.*)    tar -xvf "$file" --one-top-level;;
      *.zip)      unzip -d"${file%%.zip}" "$file";;
      *)          echo "$0: unrecognized file extension: \`$file'" >&2
                  continue;;
    esac
  done
}

# Calculator
calc() {
  echo "scale=3;$*" | bc -l
}

# Please, gotta be polite
pls() {
  if (($#)); then
    sudo "$@"
  else
    eval "sudo $(fc -ln -1)"
  fi
}

## FZF
# https://github.com/junegunn/fzf/wiki/Examples

# Open files in editor
fe() {
  local files preview
  preview="bat --line-range :100 --color 'always' {}"
  IFS=$'\n' files=($(fzf --query="$1" --preview="$preview" --multi --select-1 --exit-0))
  if [ -n "$files" ]; then
    ${EDITOR:-vim} "${files[@]}"
  fi
}

# Kill processes
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf --header='[kill:process]' --multi | awk '{print $2}')
  if [ -n "$pid" ]; then
    echo "$pid" | xargs kill -"${1:-9}"
  fi
}

# Change git branch
fbr() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m --height=10 --reverse) &&
  git checkout "$(echo "$branch" | awk '{print $1}' | sed 's/.* //')"
}

# Change tmux session
tm() {
  local change session
  if [ -n "$TMUX" ]; then
    change="switch-client"
  else
    change="attach-session"
  fi
  if [ "$1" ]; then
    tmux $change -t "$1" 2>/dev/null \
      || (tmux new-session -d -s "$1" && tmux $change -t "$1"); return
  fi
  if (( $(tmux list-sessions 2>/dev/null|grep -o '^\w\+:.*windows.*$'|wc -l) == 1 )); then
    tmux attach; return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --height=10 --reverse --exit-0)
  if [ -n "$session" ]; then
    tmux $change -t "$session"
  else
    tmux new-session
  fi
}

# Open Github remote url in browser
bro() {
  local remote url
  remote=$(git remote | fzf --height=10 --reverse --exit-0 --query="$1" --select-1)
  url=$(git remote get-url "$remote")
  if [ "$url" ]; then
    eval "$BROWSER" "$url"; return
  fi
}

play() {
  local song
  if song=$(mpc listall | fzf --query="$1" --select-1 --exit-0); then
    mpc insert "$song"
    mpc next
    mpc play
  fi
}

