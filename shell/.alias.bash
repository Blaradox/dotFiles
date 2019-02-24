#!/usr/bin/env bash

# Use colors always
alias ls="ls -GFh"
alias egrep="egrep --color=auto"

# Program alternatives
alias ping="prettyping --nolegend"
alias preview="fzf --preview 'bat --line-range :100 --color always {}'"
alias du="ncdu --color 'dark' -rr -x --exclude '.git' --exclude 'node_modules'"
alias ncdu="ncdu --color 'dark' -x"

# Version control (taken from Prezto git module)
# https://github.com/sorin-ionescu/prezto/blob/master/modules/git/alias.zsh
alias g="git"
# Status (s)
alias gs="git status --short --branch --ignored"
alias gsl="git status --long --verbose --ignored"
# Branch (b)
alias gb="git branch"
alias gba="git branch --all --verbose"
# Commit (c)
alias gc="git commit --verbose"
alias gca="git commit --verbose --all"
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
alias gid="git diff --no-ext-diff --cached"
alias gix='git rm -r --cached'
alias giX='git rm -rf --cached'
# Log (l)
alias gl='git log --topo-order --pretty=format:"${_git_log_medium_format}"'
alias gls='git log --topo-order --stat --pretty=format:"${_git_log_medium_format}"'
# Merge (m)
alias gm="git merge"
alias gmC="git merge --no-commit"
alias gma="git merge --abort"
# Push (p)
alias gp="git push"
# Rebase (r)
alias gr='git rebase'
alias gra='git rebase --abort'
alias grc='git rebase --continue'
alias gri='git rebase --interactive'
alias grs='git rebase --skip'
# Remote (R)
alias gR='git remote'
alias gRl='git remote --verbose'
alias gRa='git remote add'
alias gRx='git remote rm'
alias gRm='git remote rename'
alias gRu='git remote update'
alias gRp='git remote prune'
alias gRs='git remote show'
# Stash (s)
alias gS='git stash'
alias gSa='git stash apply'
alias gSx='git stash drop'
alias gSX='git-stash-clear-interactive'
alias gSl='git stash list'
alias gSL='git-stash-dropped'
