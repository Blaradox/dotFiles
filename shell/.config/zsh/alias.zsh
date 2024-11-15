alias e='$EDITOR'
alias py='python3'
alias t='trash'
alias rcp="rsync -av --info=progress2"
# alias intip="ip addr|grep 'inet '|grep -v '127.0.0.1'|cut -d' ' -f6|cut -d'/' -f1"
# alias extip="curl --silent ipinfo.io|sed -nE '/(ip|region)/ s/.*:\s.(.*).,/\1/p'"
alias disks='df -h -T'
alias space='du -a -h --max-depth=1|sort -h -r|less'
alias update='brew update && brew upgrade && brew upgrade --cask --greedy && brew autoremove && brew cleanup'
# alias getqrcode="import -silent -window root bmp:- | zbarimg -q -"

# locations
alias dots='cd ~/dotFiles && git status --short --branch'
alias dev='cd ~/Developer && ls'

# suffix aliases
alias -s git='git clone'
alias -s {js,json,env,md,html,css,toml,yaml}="$EDITOR"
alias -s {sh,bash,zsh,zshrc,zshenv,zprofile}="$EDITOR"
alias -s {vim,lua}="$EDITOR"
alias -s py="$EDITOR"
alias -s conf="$EDITOR"
alias -s {mp4,mkv}='mpv'
alias -s {epub,mobi}='epr'

# wezterm
alias s='wezterm ssh'

# mpc
alias mt='mpc toggle'
alias mn='mpc next'
alias mp='mpc prev'
alias mr='mpc shuffle'
alias ms='mpc stop'
alias ma='mpc load all'
alias mc='mpc clear'

# Program defaults
alias la='ls -A'
alias ll='ls -lh'
alias lla='ls -lhA'
alias rm='rm -i'
alias mv='mv -i'
alias type='type -a'
alias mkdir='mkdir -p'
alias rg='rg --smart-case'
alias ncdu="ncdu --color 'dark' -rr -x"

# Version control (taken from Prezto git module)
# https://github.com/sorin-ionescu/prezto/blob/master/modules/git/alias.zsh
alias g="git"
# Branch (b)
alias gb="git branch"
alias gba="git branch --all --verbose"
alias gbc='git checkout -b'
alias gbd='git branch --delete'
alias gbD='git branch --delete --force'
alias gbx='git branch --delete'
alias gbX='git branch --delete --force'
# Commit (c)
alias gc="git commit --verbose"
alias gca="git commit --verbose --all"
alias gco='git checkout'
alias gcO='git checkout --patch'
# Data (d)
alias gd="git ls-files"
alias gdc="git ls-files --cached"
alias gdx="git ls-files --deleted"
# Fetch (f)
alias gf="git fetch"
alias gfa="git fetch --all"
alias gfm="git pull"
alias gfr="git pull --rebase"
# Index (i)
alias gia="git add"
alias giA="git add --patch"
alias giu="git add --update"
alias gid="git diff --no-ext-diff --cached"
alias giD="git diff --no-ext-diff --cached --word-diff"
alias gis="git status --short --branch"
alias giS="git status --verbose --branch"
alias gix="git rm -r --cached"
alias giX="git rm -rf --cached"
# Log (l)
alias gl='git log --topo-order'
alias gls='git log --topo-order --stat'
# Merge (m)
alias gm="git merge"
alias gmC="git merge --no-commit"
alias gma="git merge --abort"
# Push (p)
alias gp="git push"
# Rebase (r)
alias gr="git rebase"
alias gra="git rebase --abort" alias grc="git rebase --continue"
alias gri="git rebase --interactive"
alias grs="git rebase --skip"
# Remote (R)
alias gR="git remote"
alias gRl="git remote --verbose"
alias gRa="git remote add"
alias gRx="git remote rm"
alias gRm="git remote rename"
alias gRu="git remote update"
alias gRp="git remote prune"
alias gRs="git remote show"
# Stash (s)
alias gs="git stash"
alias gsa="git stash apply"
alias gsx="git stash drop"
alias gsX="git-stash-clear-interactive"
alias gsl="git stash list"
alias gsL="git-stash-dropped"
# Working Copy (w)
alias gws="git status --ignore-submodules=none --branch --short --ignored"
alias gwS="git status --ignore-submodules=none --branch --ignored"
alias gwd="git diff --no-ext-diff"
alias gwD="git diff --no-ext-diff --word-diff"
alias gwr="git reset --soft"
alias gwR="git reset --hard"
alias gwc="git clean -n"
alias gwC="git clean -f"
alias gwx="git rm -r"
alias gwX="git rm -rf"
