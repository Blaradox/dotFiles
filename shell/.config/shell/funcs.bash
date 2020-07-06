#!/usr/bin/env bash

alert() {
  echo -n -e '\a'
  local mac_sound linux_sound icon tile body
  mac_sound="Glass"
  linux_sound="/usr/share/sounds/freedesktop/stereo/complete.oga"
  if [ $? = 0 ]; then
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
      *.7z)       7z x -o"${file%%.7z}" $file;;
      *.tar.*)    tar -xvf $file --one-top-level;;
      *.zip)      unzip -d"${file%%.zip}" $file;;
      *)          echo "$0: unrecognized file extension: \`$file'" >&2
                  continue;;
    esac
  done
}

# Calculator
calc() {
  echo "scale=3;$@" | bc -l
}

# Please, gotta be polite
pls() {
  if (($#)); then
    sudo "$@"
  else
    sudo $(fc -ln -1)
  fi
}

## FZF
# https://github.com/junegunn/fzf/wiki/Examples

# Open files
# CTRL-O to open with `open` command,
# Enter key to open with the $EDITOR
fe() {
  local preview out files key
  preview="bat --line-range :100 --color 'always' {}"
  out=$(fzf --preview="$preview" --query="$1" --select-1 --multi --exit-0 --expect=ctrl-o)
  key=$(head -1 <<< "$out")
  IFS=$'\n' files=($(tail -n +2 <<< "$out"))
  if [ -n "$files" ]; then
    [ "$key" = ctrl-o ] && open "${files[@]}" || ${EDITOR:-vim} "${files[@]}"
  fi
}

# Kill processes
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf --header='[kill:process]' --multi | awk '{print $2}')
  if [ -n "$pid" ]; then
    echo $pid | xargs kill -${1:-9}
  fi
}

# Change git branch
fbr() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m --height=10 --reverse) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# Change tmux session
tm() {
  local change session
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then
    tmux $change -t "$1" 2>/dev/null || \
      (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi
  if (( $(tmux list-sessions 2>/dev/null|grep -o '^\w\+:.*windows.*$'|wc -l) == 1 )); then
    tmux attach; return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | \
    fzf --height=10 --reverse --exit-0) \
    &&  tmux $change -t "$session" || tmux new-session
}

# Open Github remote url in browser
bro() {
  local remote url
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
    fzf --query="$1" --reverse --select-1 --exit-0 | \
    sed -n "s/^\([0-9]*\)).*/\1/p") || return 1
  [ -n "$song_position" ] && mpc -q play $song_position
}

