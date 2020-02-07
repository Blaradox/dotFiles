#!/usr/bin/env bash

# Extract file
extract() {
  local file
  (($#)) || return
  for file; do
    if [[ ! -r $file ]]; then
      echo "$0: file is unreadable: \`$i'" >&2
      continue
    fi
    case $file in
      *.7z)       7z x -o"${file%%.7z}" $file;;
      *.tar.*)    tar -xf $file --one-top-level;;
      *.zip)      unzip -d"${file%%.zip}" $file;;
      *)          echo "$0: unrecognized file extension: \`$i'" >&2
                  continue;;
    esac
  done
}

## FZF
# https://github.com/junegunn/fzf/wiki/Examples

# Open files
# CTRL-O to open with `open` command,
# Enter key to open with the $EDITOR
fe() {
  local preview out files key
  preview="bat --line-range :100 --color 'always' {}"
  out=$(fzf --preview="$preview" --query="$1" --multi --exit-0 --expect=ctrl-o)
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

# [B]rew [I]nstall [P]lugin
bip() {
  local search=($(brew search | fzf --header '[brew:install]' --multi))
  if [ -n "$search" ];then
    for item in ${search[@]}; do
      brew install "$item"
    done
    notify "Your installation is done!" "Brew Install"
  fi
}

# [B]rew [U]pdate [P]lugin
bup() {
  local leaves=($(brew outdated | fzf --header '[brew:update]' --multi))
  if [ -n "$leaves" ];then
    for leaf in ${leaves[@]}; do
      brew upgrade "$leaf"
    done
    notify "Your updates are done!" "Brew Update"
  fi
}

# [B]rew [C]lean [P]lugin
bcp() {
  local leaves=($(brew leaves | fzf --header '[brew:clean]' --multi))
  if [ -n "$leaves" ];then
    for leaf in ${leaves[@]}; do
      brew uninstall "$leaf"
    done
    notify "Your package(s) have been removed" "Brew Clean"
  fi
}

