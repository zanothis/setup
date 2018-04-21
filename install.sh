#!/bin/bash

ORIGIN=$(pwd)
LOG="${ORIGIN}/install_log.txt"
CHECK="\033[0;32m✔︎\033[m"
ERROR="\033[0;31m✖\033[m"
INDENT="\0 \0 "

function log {
  echo -ne $1 | tee -a $LOG
}

function logn {
  echo -e $1 | tee -a $LOG
}

function status_out {
  if [ $? -ne 0 ]; then
    logn $ERROR
  else
    logn $CHECK
  fi
}

if [ -f $LOG ]; then
  rm $LOG
fi

log "Checking for git"
if [ ! `which git` ]; then
  log "\n${INDENT}Installing git.........."
  sudo pacman -Sy --noconfirm git >> $LOG 2>&1
  status_out
else
  logn "..........$CHECK"
fi

log "Checking for curl"
if [ ! `which curl` ]; then
  log "\n${INDENT}Installing curl........."
  sudo pacman -S --noconfirm curl >> $LOG 2>&1
  status_out
else
  logn ".........$CHECK"
fi

log "Checking for vim"
if [ ! `which vim` ]; then
  log "\n${INDENT}Installing vim.........."
  sudo pacman -S --noconfirm vim >> $LOG 2>&1
  status_out
else
  logn "..........$CHECK"
fi

log "Checking for go"
if [ ! `which go` ]; then
  log "\n${INDENT}Installing go..........."
  sudo pacman -S --noconfirm go >> $LOG 2>&1
  status_out
else
  logn "...........$CHECK"
fi

log "Checking for mono"
if [ ! `which mono` ]; then
  log "\n${INDENT}Installing mono........."
  sudo pacman -S --noconfirm mono >> $LOG 2>&1
  status_out
else
  logn ".........$CHECK"
fi

if [ ! -d $HOME/dotfiles ]; then
  log "Installing dotfiles...\n${INDENT}Cloning into dotfiles..."
  git clone https://github.com/zanothis/dotfiles.git $HOME/dotfiles >> $LOG 2>&1
  status_out
  if [ $? -ne 0 ]; then
    log "\n${INDENT}Linking dotfiles to \"$HOME\"..."
    log "\n${INDENT}${INDENT}Linking .screenrc....."
    ln -s $HOME/dotfiles/.screenrc $HOME/.screenrc
    log "$CHECK\n${INDENT}${INDENT}Linking .inputrc......"
    ln -s $HOME/dotfiles/.inputrc $HOME/.inputrc
    log "$CHECK\n${INDENT}${INDENT}Linking .vimrc........"
    ln -s $HOME/dotfiles/.vimrc $HOME/.vimrc
    log "$CHECK\n${INDENT}${INDENT}Linking .gitconfig...."
    ln -s $HOME/dotfiles/.gitconfig $HOME/.gitconfig
    logn $CHECK
  fi
else
  log "Updating dotfiles........."
  cd $HOME/dotfiles
  git up >> $LOG 2>&1
  status_out
  cd $ORIGIN
fi

if [ ! -f $HOME/.vim/autoload/plug.vim ]; then
  log "Installing plug-vim......."
  curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  status_out
  log "Installing vim plugins...."
  vim +PlugInstall +qall
  status_out
fi
