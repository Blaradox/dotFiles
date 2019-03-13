# Source Prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Change Prezto prompt
# change prompt in `~/.zpreztorc` to giddie

# Load custom bash variables, aliases and functions
if [[ -s "$HOME/.vars.bash" ]]; then
  source "$HOME/.vars.bash"
fi
if [[ -s "$HOME/.alias.bash" ]]; then
  source "$HOME/.alias.bash"
fi
if [[ -s "$HOME/.funcs.bash" ]]; then
  source "$HOME/.funcs.bash"
fi

# FZF C-r and C-t
[[ -s "$HOME/.fzf.zsh" ]] && source "$HOME/.fzf.zsh"

# Follow Bash Readline
bindkey \^U backward-kill-line
