#!/bin/bash

sudo apt-get install -y git-core
sudo apt-get install -y curl

wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh

heroku login

sudo apt-get update
sudo apt-get install -y python-software-properties python g++ make
sudo add-apt-repository ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get install -y nodejs

npm install -g jshint

git config --global user.name "Nathan Benjamin"
git config --global user.email "nb-accounts@thebenjamins.me"

git clone git@github.com:zanothis/dotfiles.git
cp dotfiles/.screenrc ~
cp dotfiles/.vimrc ~

git clone git@github.com:zanothis/vim-packages.git
mkdir .vim
cd vim-packages; cp -rf * ~/.vim
