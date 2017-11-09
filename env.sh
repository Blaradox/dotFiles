# PATH
export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/opt/fzf/bin

# aliases
alias ls="ls -GFh"
alias ..="cd .."

# use fzf C-t and C-r
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# useful functions
fbr() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m --height=10 --reverse) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

tm() {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then 
    tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --height=10 --reverse --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
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
