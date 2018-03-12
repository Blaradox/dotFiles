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

scripts=(tmux-spotify-info tmux-music-info tmux-battery-info)
for file in ${scripts[@]}; do
  ln -sf ~/dotFiles/$file /usr/local/bin
  echo "$file symlink created."
done

cd ~

echo "Done Stowing!"

