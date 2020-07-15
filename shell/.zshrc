# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[[ ! -d "$HOME/.config/antigen" ]] && git clone https://github.com/zsh-users/antigen.git "$HOME/.config/antigen"
source "$HOME/.config/antigen/antigen.zsh"

# Set the default plugin repo to be zsh-utils
antigen use belak/zsh-utils

# Specify completions we want before the completion module
antigen bundle zsh-users/zsh-completions

# Specify plugins we want
antigen bundle editor
antigen bundle history
antigen bundle prompt
antigen bundle utility
antigen bundle completion

# Specify additional external plugins we want
antigen bundle zsh-users/zsh-syntax-highlighting
antigen theme romkatv/powerlevel10k

# Load everything
antigen apply

# Set any settings or overrides here
# prompt belak
bindkey -e
setopt autocd
zstyle ':completion:*' menu select

man() {
  LESS_TERMCAP_md=$'\e[01;31m' \
  LESS_TERMCAP_me=$'\e[0m' \
  LESS_TERMCAP_se=$'\e[0m' \
  LESS_TERMCAP_so=$'\e[01;44;33m' \
  LESS_TERMCAP_ue=$'\e[0m' \
  LESS_TERMCAP_us=$'\e[01;32m' \
  command man "$@"
}

# Load custom bash variables, aliases and functions
if [[ -d "$HOME/.config/shell/bash" ]]; then
  for file in $HOME/.config/shell/bash/*.bash; do
    source "$file"
  done
fi

# FZF keybindings
if [[ -s "/usr/local/opt/fzf/shell/key-bindings.zsh" ]]; then
  source "/usr/local/opt/fzf/shell/key-bindings.zsh"
fi
if [[ -s "/usr/share/fzf/key-bindings.zsh" ]]; then
  source "/usr/share/fzf/key-bindings.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
