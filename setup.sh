#!/bin/sh

if [ $1="delete" ] ; then
  rm -rf ../.vimrc
  rm -rf ../.vim
fi
ln -s ${HOME}/dotfiles/_vimrc ${HOME}/.vimrc
ln -s ${HOME}/dotfiles/_vim ${HOME}/.vim

#git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
