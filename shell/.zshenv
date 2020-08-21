export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ADOTDIR="$XDG_CONFIG_HOME/antigen"

export PATH="$HOME/.local/bin:$PATH"
export VISUAL='nvim'
export EDITOR="$VISUAL"
export PAGER='less'
export BROWSER='firefox'

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

export DEFAULT_USER='sloaneat'
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden --follow'
export FZF_DEFAULT_OPTS='--color=16 --bind ctrl-t:toggle-all'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export WEECHAT_HOME="$XDG_CONFIG_HOME/weechat"
