#!/bin/sh

#git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
#git submodule init
#git submodule update

if [ $1="delete" ] ; then
  rm -rf ../.vimrc
  echo "rm -rf ../.vimrc"
  rm -rf ../.vim
  echo "rm -rf ../.vim"
fi
ln -s ${HOME}/dotfiles/_vimrc ${HOME}/.vimrc
echo "create symboliclink for ../.vimrc"
ln -s ${HOME}/dotfiles/_vim ${HOME}/.vim
echo "create symboliclink for ../.vim"

