export PATH=$HOME/.local/bin:$PATH
export VISUAL="nvim"
export EDITOR=$VISUAL
export PAGER="less"
# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

export DEFAULT_USER=sloaneat
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden --follow'
export FZF_DEFAULT_OPTS='--color=16 --bind ctrl-t:toggle-all'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export WEECHAT_HOME="${XDG_CONFIG_HOME:=$HOME/.config}/weechat"
