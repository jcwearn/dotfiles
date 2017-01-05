#!/bin/bash
cd ~

#install emacs24.4
platform=$(uname)

if [[ $platform == "Darwin" ]]; then
    brew install emacs --with-cocoa --with-gnutls
elif [[ $platform == "Linux"  ]]; then
    taken from http://askubuntu.com/a/546050
    mkdir emacs-src && cd emacs-src
    wget http://mirror.team-cymru.org/gnu/emacs/emacs-24.4.tar.gz
    tar xvf emacs-24.4.tar.gz

     sudo apt-get install build-essential
     sudo apt-get build-dep emacs24
     cd emacs-24.4
     ./configure
     make
     sudo make install
     rm -rf ~/emacs-src
fi

cp ~/dotfiles/.emacs
cp -r ~/dotfiles/.emacs.d/
