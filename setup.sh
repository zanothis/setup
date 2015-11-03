#!/bin/bash

if [ $EUID != 0 ]; then
  sudo "$0" "$@"
  exit $?
fi

echo -ne "Updating APT..."
sudo apt-get update > /dev/null

echo -ne "done\nChecking for git..."
if [ ! `which git` ]; then
  echo -ne "Installing git..."
  sudo apt-get install -y git-core > /dev/null
  echo "done"
else
  echo "git is already installed"
fi

echo "Checking for curl..."
if [ ! `which curl` ]; then
  echo -ne "Installing curl..."
  sudo apt-get install -y curl > /dev/null
  echo "done"
else
  echo "curl is already installed"
fi

echo -ne "Checking for The Silver Searcher..."
if [ ! `which ag` ]; then
  echo -ne "\nInstalling The Silver Searcher..."
  sudo apt-get install -y silversearcher-ag > /dev/null
  echo "done"
else
  echo "The Silver Searcher is already installed"
fi

echo "Installing dotfiles..."
if [ ! -d dotfiles ]; then
  echo -ne "  Cloning into dotfiles..."
  git clone https://github.com/zanothis/dotfiles.git > /dev/null
  echo -ne "done\n  Copying dotfiles to \"$HOME\"..."
  cp dotfiles/.screenrc ~/
  cp dotfiles/.inputrc ~/
  cp dotfiles/.vimrc ~/.vimrc
  cp dotfiles/.gitconfig ~/.gitconfig
  echo "done"
else
  cd dotfiles
  echo -ne "  Updating dotfiles..."
  git pull > /dev/null
  cd ..
  echo -ne "done\n  Copying dotfiles...\n    Copying .screenrc..."
  cp dotfiles/.screenrc ~/
  echo -ne "done\n    Copying .inputrc..."
  cp dotfiles/.inputrc ~/
  echo -ne "done\n    Copying .vimrc..."
  cp dotfiles/.vimrc ~/.vimrc
  echo -ne "done\n    Copying .gitconfig..."
  cp dotfiles/.gitconfig ~/.gitconfig
  echo "done"
fi

echo "Installing vim-packages..."
if [ ! -d vim-packages ]; then
  echo -ne "  Cloning into vim-packages..."
  git clone https://github.com/zanothis/vim-packages.git > /dev/null
  echo "done"

  mkdir -p ~/.vim

  cd vim-packages
  echo -ne "  Initializing submodules..."
  git submodule update --init --recursive > /dev/null
  echo -ne "done\n  Copying vim plugins to \"$HOME\"/.vim..."
  cp -rf * ~/.vim

  echo -ne "done\n  Checking for NodeJS..."
  if [ `which node` ]; then
    echo -ne "found\n  Setting up Tern for Vim..."
    cd ~/.vim/bundle/ternjs
    sudo npm install > /dev/null
    echo "done"
  else
    echo "missing\n  Install NodeJS and try again."
  fi

  echo -ne "  Adding Mono packages to APT..."
  # Add the Mono Project's GPG key
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF > /dev/null

  # Add the Mono packages to apt
  echo "deb http://download.mono-project.com/repo/debian wheezy main" | sudo tee /etc/apt/sources.list.d/mono-xamarin.list > /dev/null

  # Update and install
  sudo apt-get update > /dev/null
  echo -ne "done\n  Installing mono-devel..."
  sudo apt-get install --install-suggests mono-devel > /dev/null

  echo -ne "done\n  Building YCM..."
  cd ~/.vim/bundle/YouCompleteMe
  ./install.py --omnisharp-completer > /dev/null
  echo "done"
else
  cd vim-packages
  echo -ne "  Updating vim-packages..."
  git pull > /dev/null
  echo -ne "done\n  Initializing submodules..."
  git submodule update --init --recursive > /dev/null
  echo -ne "done\n  Copying vim plugins..."
  cp -rf * ~/.vim

  echo -ne "done\n  Checking for NodeJS..."
  if [ `which node` ]; then
    echo -ne "found\n  Setting up Tern for Vim..."
    cd ~/.vim/bundle/ternjs
    sudo npm install > /dev/null
    echo "done"
  else
    echo "missing\n  Install NodeJS and try again."
  fi

  if sudo apt-key finger | grep '3FA7 E032' > /dev/null
  then
    echo -e "  Mono is already installed"
  else
    echo -ne "  Adding Mono packages to APT..."
    # Add the Mono Project's GPG key
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF > /dev/null

    # Add the Mono packages to apt
    echo "deb http://download.mono-project.com/repo/debian wheezy main" | sudo tee /etc/apt/sources.list.d/mono-xamarin.list > /dev/null

    # Update and install
    sudo apt-get update > /dev/null
    echo -ne "done\n  Installing mono-devel..."
    sudo apt-get install --install-suggests mono-devel > /dev/null
    echo "done"
  fi

  echo -ne "  Building YCM..."
  cd ~/.vim/bundle/YouCompleteMe
  ./install.py --omnisharp-completer > /dev/null
  echo "done"
fi
