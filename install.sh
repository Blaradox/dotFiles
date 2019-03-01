#!/usr/bin/env bash

if [[ -s $HOME/dotfiles ]]; then

  echo "Stowing Dotfiles..."

  cd "$HOME/dotFiles"
  # Only choose desired configurations
  configs=(fonts git mpd ncmpcpp ranger scripts shell tmux vim)
  for file in ${configs[@]}; do
    # Only run stow on directories
    if [[ -d $file ]]; then
      stow -R "$(basename $file)"
      echo "$(basename $file) stowed."
    fi
  done

  # stow by default ignores .gitignore files
  ln -sf "$HOME/dotfiles/git/.gitignore" "$HOME/.gitignore"

  echo "Done Stowing!"
else
  echo "Check to make sure that you cloned this repository in your home folder"
fi
