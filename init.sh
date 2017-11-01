#!/bin/bash

rm ~/.gitignore ~/.gitconfig ~/.vimrc ~/.tmux.conf ~/.zshrc

chmod +x ~/dotFiles/zshrc

ln -s ~/dotFiles/zshrc ~/.zshrc
ln -s ~/dotFiles/vimrc ~/.vimrc
ln -s ~/dotFiles/tmux.conf ~/.tmux.conf
ln -s ~/dotFiles/gitconfig ~/.gitconfig
ln -s ~/dotFiles/gitignore ~/.gitignore

source ~/.zshrc
