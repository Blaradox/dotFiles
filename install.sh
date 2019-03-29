#!/usr/bin/env bash

function stow-dots {
  local configs=()
  if [[ $OSTYPE == darwin* ]]; then
    configs=(fonts git karabiner kitty mpd ncmpcpp scripts shell tmux vim)
  elif [[ $OSTYPE == linux* ]]; then
    configs=(fonts git kitty mpd ncmpcpp scripts shell tmux vim)
  fi

  mkdir -p "$HOME/.local/share/fonts"
  mkdir -p "$HOME/.local/bin"
  mkdir -p "$HOME/.config"

  printf "Stowing Dotfiles...\n"
  cd "$HOME/dotFiles"
  for file in ${configs[@]}; do
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
