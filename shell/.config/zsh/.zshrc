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
  for file in $HOME/.config/bash/{alias,funcs,git-funcs}.bash; do
    [[ -f "$file" ]] && source "$file"
  done
fi

# Set zsh options
if [[ -d "$HOME/.config/zsh/" ]]; then
  for file in $HOME/.config/zsh/{completion,editor,history}.zsh; do
    [[ -f "$file" ]] && source "$file"
  done
fi

# Highlight pastes in terminal and don't execute
autoload -U zmv
autoload -Uz bracketed-paste-url-magic
zle -N bracketed-paste bracketed-paste-url-magic

# Bind GIT keybindings
# https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236
join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}
bind-git-helper() {
  local c
  for c in "$@"; do
    eval "fzf-g$c-widget() { local result=\$(_g$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
    eval "zle -N fzf-g$c-widget"
    eval "bindkey '^g^$c' fzf-g$c-widget"
  done
}
bind-git-helper f b t r h s
unset -f bind-git-helper

# FZF keybindings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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

conda-start() {
  local conda_setup
  conda_setup="$('/Users/sloaneat/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
    eval "$conda_setup"
  else
    if [ -f "/Users/sloaneat/miniconda3/etc/profile.d/conda.sh" ]; then
      . "/Users/sloaneat/miniconda3/etc/profile.d/conda.sh"
    else
      export PATH="/Users/sloaneat/miniconda3/bin:$PATH"
    fi
  fi
}

nvm-start() {
  export NVM_DIR="$HOME/.nvm"
  [ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && \. "$(brew --prefix)/opt/nvm/nvm.sh" # This loads nvm
  [ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
}

pyenv-start() {
  eval "$(pyenv init --path)"
}
