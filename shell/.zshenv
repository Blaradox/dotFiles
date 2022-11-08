export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ADOTDIR="$XDG_CONFIG_HOME/antigen"

# export PATH="$HOME/.local/bin:$PATH"
path+="$HOME/.local/bin"
path+="/opt/homebrew/bin/"
export VISUAL='nvim'
export EDITOR="$VISUAL"
export PAGER='less'
export BROWSER='firefox'

export DEFAULT_USER='sloaneat'
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden --follow'
export FZF_DEFAULT_OPTS='--color=16 --bind ctrl-t:toggle-all'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export WEECHAT_HOME="$XDG_CONFIG_HOME/weechat"
export NNN_TRASH=1
