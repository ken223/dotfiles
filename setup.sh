#!/bin/sh

rm -rf ../.vimrc
rm -rf ../.vim
ln -s .vimrc ../.vimrc
ln -s .vim ../.vim

#git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
