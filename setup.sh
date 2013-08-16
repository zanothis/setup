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
