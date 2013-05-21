#!/bin/sh

VUNDLE_DIR="_vim/vundle.git"
BUNDLE_DIR="_vim/bundle"

if [[ $1 = "delete" ]] ; then
  rm -rf ../.vimrc
  echo "rm -rf ../.vimrc"
  rm -rf ../.vim
  echo "rm -rf ../.vim"

  if [ -e ${VUNDLE_DIR} ] ; then
    rm -rf ${VUNDLE_DIR}
    echo "rm -rf ${VUNDLE_DIR}"
  fi

  git rm -r ${VUNDLE_DIR}
  echo "git rm -r ${VUNDLE_DIR}"

  git submodule add http://github.com/gmarik/vundle.git ${VUNDLE_DIR}
  echo "git submodule add http://github.com/gmarik/vundle.git ${VUNDLE_DIR}"

  if [ -e ${BUNDLE_DIR} ] ; then
    rm -rf ${BUNDLE_DIR}
    echo "rm -rf ${BUNDLE_DIR}"
  fi

fi


if [ ! -e ${HOME}/.vimrc ] ; then
  ln -s ${HOME}/dotfiles/_vimrc ${HOME}/.vimrc
  echo "create symboliclink for ../.vimrc"
fi

if [ ! -e ${HOME}/.vim ] ; then
  ln -s ${HOME}/dotfiles/_vim ${HOME}/.vim
  echo "create symboliclink for ../.vim"
fi

echo "
At first , open some file.
$ vim hoge
:BundleInstall
And start to install bundles automatically."
