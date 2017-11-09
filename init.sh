#!/bin/bash

rm ~/.gitignore ~/.gitconfig ~/.vimrc ~/.tmux.conf ~/.env.sh

chmod +x ~/dotFiles/env.sh

ln -s ~/dotFiles/env.sh ~/.env.sh
ln -s ~/dotFiles/vimrc ~/.vimrc
ln -s ~/dotFiles/tmux.conf ~/.tmux.conf
ln -s ~/dotFiles/gitconfig ~/.gitconfig
ln -s ~/dotFiles/gitignore ~/.gitignore

source ~/.zshrc

