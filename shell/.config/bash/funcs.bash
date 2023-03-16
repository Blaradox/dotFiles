#!/usr/bin/env bash

# pomodoro
work () {
  local duration
  duration="${1:=20m}"
  timer "$duration" && osascript -e 'display notification "☕" with title "Work Timer is up!" subtitle "Take a Break 😊" sound name "Crystal"'
}
rest () {
  local duration
  duration="${1:=5m}"
  timer "$duration" && osascript -e 'display notification "⏰" with title "Rest Timer is up!" subtitle "Well done! Now lets do some work!" sound name "Crystal"'
}


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

# subreddit music playlist
reddit_play() {
  local subreddit
  [ -z "$1" ] && subreddit="bayrap" || subreddit="$1"
  eval "curl -s -A $RANDOM https://www.reddit.com/r/${subreddit}.json" \
    | jq -r '.data.children | .[] | select(.data.url | contains("youtu")) | .data.url' \
    | mpv --no-video --playlist=-
}

# create qr code for connecting to wifi
wifipass() {
  local nmcall ssid pass sec err
  nmcall="$(nmcli device wifi show -s)"
  ssid="$(awk '{ if ($1 == "SSID:" ) { sub($1 FS, ""); print} }' <<< $nmcall)"
  pass="$(awk '{ if ($1 == "Password:" ) { sub($1 FS, ""); print} }' <<< $nmcall)"
  sec="$(awk '{ if ($1 == "Security:" ) { sub($1 FS, ""); print} }' <<< $nmcall)"
  err="$(awk '{ if ($1 == "Error:" ) { print } }' <<< $nmcall)"
  if [[ -n $err ]] ; then
    echo "$err"
  else
    qrencode -t ansiutf8 "WIFI:T:$sec;S:$ssid;P:$pass;;"
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

