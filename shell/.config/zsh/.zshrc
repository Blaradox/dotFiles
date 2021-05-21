# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Setup antigen
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
if [[ -s "/usr/share/fzf/shell/key-bindings.zsh" ]]; then
  source "/usr/share/fzf/shell/key-bindings.zsh"
fi

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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/sloaneat/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/sloaneat/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/sloaneat/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/sloaneat/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

