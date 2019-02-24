#!/usr/bin/env bash

# Use colors always
alias ls="ls -GFh"
alias egrep="egrep --color=auto"

# Program alternatives
alias ping="prettyping --nolegend"
alias preview="fzf --preview 'bat --line-range :100 --color always {}'"
alias du="ncdu --color 'dark' -rr -x --exclude '.git' --exclude 'node_modules'"
alias ncdu="ncdu --color 'dark' -x"

# Version control
alias g="git"

