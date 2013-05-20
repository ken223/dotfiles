#!/bin/sh

if [ $1="delete" ] ; then
  rm -rf ../.vimrc
  echo "rm -rf ../.vimrc"
  rm -rf ../.vim
  echo "rm -rf ../.vim"
fi

git submodule add http://github.com/gmarik/vundle.git _vim/vundle.git

ln -s ${HOME}/dotfiles/_vimrc ${HOME}/.vimrc
echo "create symboliclink for ../.vimrc"
ln -s ${HOME}/dotfiles/_vim ${HOME}/.vim
echo "create symboliclink for ../.vim"

echo "
At first , open some file.
$ vim hoge
:BundleInstall
And start to install bundles automatically."
