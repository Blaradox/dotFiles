#!/usr/bin/env bash

echo "Stowing Dotfiles..."

cd ~/dotFiles
for file in ~/dotFiles/*; do
  # Only run stow on directories
  if [ -d ${file} ]; then
    stow -R $(basename $file)
    echo "$(basename $file) stowed."
  fi
done

# stow by default ignores .gitignore files
ln -sf ~/dotfiles/git/.gitignore ~/.gitignore

echo "Done Stowing!"

