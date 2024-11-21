# Please, gotta be polite
pls() {
  if (($#)); then
    sudo "$@"
  else
    eval "sudo $(fc -ln -1)"
  fi
}

# pomodoro
work () {
  local duration="${1:=20m}"
  timer "$duration" && osascript -e 'display notification "☕" with title "Work Timer is up!" subtitle "Take a Break 😊" sound name "Crystal"'
}
rest () {
  local duration="${1:=5m}"
  timer "$duration" && osascript -e 'display notification "⏰" with title "Rest Timer is up!" subtitle "Well done! Now lets do some work!" sound name "Crystal"'
}

# Use after another terminal command to send a system notification upon completion
alert() {
  if [ $? = 0 ]; then
    local icon="terminal"
    local title="Job Completed 🟢"
  else
    local icon="error"
    local title="Job Failed 🔴"
  fi
  local body sound
  echo -n -e '\a'
  body="${1:-Terminal has finished the command}"
  case "$OSTYPE" in
    (darwin*)
      sound="Glass"
      osascript \
        -e "on run(argv)" \
        -e "return display notification item 1 of argv with title item 2 of argv sound name item 3 of argv" \
        -e "end" \
        -- "$body" "$title" "$sound"
      ;;
    (linux-gnu)
      sound="/usr/share/sounds/freedesktop/stereo/complete.oga"
      notify-send --urgency=low -i "$icon" "$title" "$body"; paplay "$sound"
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
  local apcall nmcall ssid pass sec err
  case $OSTYPE in
    (darwin*)
      apcall="$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport --getinfo)"
      ssid="$(awk '/^ *SSID:/ { print $2 }' <<< $apcall)"
      pass="$(security find-generic-password -wga ${ssid})"
      sec="$(awk '/^ *link auth:/ { print $3 }' <<< $apcall)"
      err="$(awk '/AirPort: Off/ { print }' <<< $apcall)"
      ;;
    (linux-gnu)
      nmcall="$(nmcli device wifi show -s)"
      ssid="$(awk '{ if ($1 == "SSID:" ) { sub($1 FS, ""); print} }' <<< $nmcall)"
      pass="$(awk '{ if ($1 == "Password:" ) { sub($1 FS, ""); print} }' <<< $nmcall)"
      sec="$(awk '{ if ($1 == "Security:" ) { sub($1 FS, ""); print} }' <<< $nmcall)"
      err="$(awk '{ if ($1 == "Error:" ) { print } }' <<< $nmcall)"
      ;;
  esac
  case $sec in
    (wpa2-psk) sec="WPA";;
    (wep) sec="WEP";;
    (none) sec="nopass";;
    (*) sec="WPA";;
  esac
  if [[ -n $err || -z $ssid ]] ; then
    echo "Error finding WiFi $err"
  else
    echo "SSID: $ssid"
    echo "Password: $pass"
    echo "Security: $sec"
    qrencode -t ansiutf8 "WIFI:T:$sec;S:$ssid;P:$pass;;"
  fi
}

## FZF

fzf-alias-widget() {
    local cmd
    cmd=$(alias | fzf --query="$1" --no-multi --exit-0 | cut -d'=' -f 2-)
    if [ -n "$cmd" ]; then
        temp="${cmd%'}"
        eval "${temp#'}"
   else
       echo 'No alias chosen.'
    fi
}

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

play() {
  local song
  if song=$(mpc listall | fzf --query="$1" --select-1 --exit-0); then
    mpc insert "$song"
    mpc next
    mpc play
  fi
}

