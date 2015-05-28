#!/bin/bash

sudo apt-get update

if [ ! `which git` ]; then
  sudo apt-get install -y git-core
fi

if [ ! `which curl` ]; then
  sudo apt-get install -y curl
fi

if [ ! `which ag` ]; then
  sudo apt-get install -y silversearcher-ag
fi

if [ ! -d dotfiles ]; then
  git clone https://github.com/zanothis/dotfiles.git
  cp dotfiles/.screenrc ~/
  cp dotfiles/.inputrc ~/
  cp dotfiles/.vimrc ~/.vimrc
  cp dotfiles/.gitconfig ~/.gitconfig
else
  cd dotfiles
  git pull
  cd ..
  cp dotfiles/.screenrc ~/
  cp dotfiles/.inputrc ~/
  cp dotfiles/.vimrc ~/.vimrc
  cp dotfiles/.gitconfig ~/.gitconfig
fi

if [ ! -d vim-packages ]; then
  git clone https://github.com/zanothis/vim-packages.git

  mkdir -p ~/.vim

  cd vim-packages
  git submodule init
  git submodule update
  cp -rf * ~/.vim
else
  cd vim-packages
  git pull
  git submodule update
  cp -rf * ~/.vim
fi
