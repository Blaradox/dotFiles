#!/usr/bin/env zsh

# Download prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

# Copy files to home directory
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

# Change shell to zsh
chsh -s /bin/zsh

# Change theme from 'sorin' to 'giddie'
sed -i "s/'sorin'/'giddie'/" "$HOME/.zpreztorc"
