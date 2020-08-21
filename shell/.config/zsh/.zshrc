# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[[ ! -d "$XDG_CONFIG_HOME/antigen" ]] && git clone https://github.com/zsh-users/antigen.git "$XDG_CONFIG_HOME/antigen"
source "$XDG_CONFIG_HOME/antigen/antigen.zsh"
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen theme romkatv/powerlevel10k

# Load everything
antigen apply

# Load custom bash aliases and functions
if [[ -d "$HOME/.config/bash" ]]; then
  for file in $HOME/.config/bash/{alias,funcs}.bash; do
    source "$file"
  done
fi

# Set zsh options
if [[ -d "$HOME/.config/zsh/" ]]; then
  for file in $HOME/.config/zsh/{completion,editor,history}.zsh; do
    source "$file"
  done
fi

autoload -U zmv
autoload -Uz bracketed-paste-url-magic
zle -N bracketed-paste bracketed-paste-url-magic

# FZF keybindings
if [[ -s "/usr/local/opt/fzf/shell/key-bindings.zsh" ]]; then
  source "/usr/local/opt/fzf/shell/key-bindings.zsh"
fi
if [[ -s "/usr/share/fzf/key-bindings.zsh" ]]; then
  source "/usr/share/fzf/key-bindings.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
