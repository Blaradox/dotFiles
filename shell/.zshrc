# Source Prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Change Prezto prompt
# change prompt in `~/.zpreztorc` to giddie

# Load custom bash variables, aliases and functions
if [[ -s "$HOME/.config/shell/vars.bash" ]]; then
  source "$HOME/.config/shell/vars.bash"
fi
if [[ -s "$HOME/.config/shell/alias.bash" ]]; then
  source "$HOME/.config/shell/alias.bash"
fi
if [[ -s "$HOME/.config/shell/funcs.bash" ]]; then
  source "$HOME/.config/shell/funcs.bash"
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
