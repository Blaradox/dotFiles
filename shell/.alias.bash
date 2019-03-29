#!/usr/bin/env bash

# Use colors always
alias tree="tree -C --dirsfirst -I '.git'"
alias egrep="egrep --color=auto"
if [[ $OSTYPE == darwin* ]]; then
  alias ls="/usr/local/bin/gls --color --classify --group-directories-first --human-readable"
elif [[ $OSTYPE == linux* ]]; then
  alias ls="ls --color --classify --group-directories-first --human-readable"
fi

# Program defaults
alias rg="rg --smart-case"

# Program alternatives
alias ping="prettyping --nolegend"
alias ncdu="ncdu --color 'dark' -rr -x"

# Vim and git
# ACMR = Added || Copied || Modified || Renamed
alias v="vim"
alias vid="vim \$(git diff --staged --name-only --diff-filter=ACMR)"
alias vwd="vim \$(git diff HEAD --name-only --diff-filter=ACMR)"

# Version control (taken from Prezto git module)
# https://github.com/sorin-ionescu/prezto/blob/master/modules/git/alias.zsh
alias g="git"
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
alias giA="git add --patch"
alias giu="git add --update"
alias gid="git diff --no-ext-diff --cached"
alias giD="git diff --no-ext-diff --cached --word-diff"
alias gis="git status --short --branch"
alias giS="git status --verbose --branch"
alias gix="git rm -r --cached"
alias giX="git rm -rf --cached"
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
alias gr="git rebase"
alias gra="git rebase --abort"
alias grc="git rebase --continue"
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
