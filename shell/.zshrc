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

# Create mpv fifo file
[[ -e "/tmp/mpv.fifo" ]] || mkfifo "/tmp/mpv.fifo"

# FZF keybindings
if [[ -s "/usr/local/opt/fzf/shell/key-bindings.zsh" ]]; then
  source "/usr/local/opt/fzf/shell/key-bindings.zsh"
fi
if [[ -s "/usr/share/fzf/key-bindings.zsh" ]]; then
  source "/usr/share/fzf/key-bindings.zsh"
fi

# Follow Bash Readline
bindkey \^U backward-kill-line
