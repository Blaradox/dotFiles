# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Setup antigen
[[ ! -d "$XDG_CONFIG_HOME/antigen" ]] && git clone https://github.com/zsh-users/antigen.git "$XDG_CONFIG_HOME/antigen"
source "$XDG_CONFIG_HOME/antigen/antigen.zsh"

antigen use belak/zsh-utils --branch=main
antigen bundle zsh-users/zsh-completions

antigen bundle editor@main
antigen bundle history@main
antigen bundle prompt@main
antigen bundle utility@main
antigen bundle completion@main

antigen bundle zsh-users/zsh-syntax-highlighting
antigen theme romkatv/powerlevel10k

# Load everything
antigen apply

# Set completion style
compstyle prezto

# Use emacs key bindings
bindkey -e

# Change directories without cd
setopt autocd

# Highlight pastes in terminal and don't execute
autoload -U zmv
autoload -Uz bracketed-paste-url-magic
zle -N bracketed-paste bracketed-paste-url-magic


# Load custom bash aliases and functions
if [[ -d "$HOME/.config/zsh" ]]; then
  for file in $HOME/.config/zsh/{alias,funcs}.zsh; do
    [[ -f "$file" ]] && source "$file"
  done
fi

# FZF keybindings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.fzf-git.sh ] && source ~/.fzf-git.sh

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'
export LESS_TERMCAP_md=$'\e[01;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;44;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[01;32m'
export GROFF_NO_SGR=1

# nvm setup
export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && \. "$(brew --prefix)/opt/nvm/nvm.sh" # This loads nvm
[ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

# pyenv setup
eval "$(pyenv init --path)"

# zoxide setup to use j
eval "$(zoxide init zsh --cmd j)"
