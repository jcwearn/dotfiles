#!bin/bash
cd ~
mkdir emacs-src && cd emacs-src
wget http://mirror.team-cymru.org/gnu/emacs/emacs-24.4.tar.gz
tar xvf emacs-24.4.tar.gz

sudo apt-get install build-essential
sudo apt-get build-dep emacs24
cd emacs-24.4
./configure
make
sudo make install
rm -rf emacs-src
