#!/usr/bin/env bash

function stow-dots {
  local configs=()
  if [[ $OSTYPE == darwin* ]]; then
    configs=(fonts git karabiner kitty mpd mpv ncmpcpp nvim scripts shell tmux vim)
  elif [[ $OSTYPE == linux* ]]; then
    configs=(fonts git kitty mpd mpv ncmpcpp nvim scripts shell tmux vim)
  fi

  mkdir -p "${XDG_CONFIG_HOME:=$HOME/.config}"
  mkdir -p "${XDG_DATA_HOME:=$HOME/.local/share}/fonts"
  mkdir -p "$HOME/.local/bin"

  printf "Stowing Dotfiles...\n"
  cd "$HOME/dotFiles"
  for file in "${configs[@]}"; do
    # Only run stow on directories
    if [[ -d "$file" ]]; then
      stow -R "$(basename $file)"
      printf "$(basename $file) stowed.\n"
    fi
  done

  # stow by default ignores .gitignore files
  ln -sf "$HOME/dotFiles/.ignore" "$HOME/.ignore"

  printf "Done Stowing!\n"
}

if [[ -s "$HOME/dotFiles" ]]; then
  stow-dots "$@"
else
  printf "Check to make sure that you cloned this repository in your home folder\n"
fi
