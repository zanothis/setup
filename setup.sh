#!/bin/bash

sudo apt-get update

if [ ! `which git` ]; then
  sudo apt-get install -y git-core
fi

if [ ! `which curl` ]; then
  sudo apt-get install -y curl
fi

#wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh

#heroku login
#
#sudo apt-get install -y python-software-properties python g++ make
#sudo add-apt-repository ppa:chris-lea/node.js
#sudo apt-get update
#sudo apt-get install -y nodejs
#
#npm install -g jshint
#
#git config --global user.name "Nathan Benjamin"
#git config --global user.email "nb-accounts@thebenjamins.me"

git clone git://github.com/zanothis/dotfiles.git
cp dotfiles/.screenrc ~
cp dotfiles/.vimrc ~

git clone git://github.com/zanothis/vim-packages.git

mkdir -p ~/.vim

cd vim-packages; cp -rf * ~/.vim
